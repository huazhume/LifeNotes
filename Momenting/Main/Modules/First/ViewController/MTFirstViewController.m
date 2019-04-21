//
//  MTFirstViewController.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/20.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTFirstViewController.h"
#import "MTSecondViewCell.h"
#import "MTFirstViewModel.h"
#import "MTMarketHotView.h"
#import "MTFirstViewModel.h"
#import "NSObject+YYModel.h"
#import "MTFirstViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "MTLocalDataManager.h"
#import "MTNoteModel.h"
#import "FLBaseWebViewController.h"



@interface MTFirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;

@end

@implementation MTFirstViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.leftButton.hidden = YES;
    [self.view addSubview:self.tableView];
    [self loadData];
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    NSMutableArray *muImage = [NSMutableArray array];
    for (int i = 1 ; i < 34 ; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
        [muImage addObject:image];
    }
    // 设置普通状态的动画图片
    [header setImages:muImage forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:muImage forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:muImage forState:MJRefreshStateRefreshing];
    // 设置header
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    
    
}



- (void)loadData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self readFile];
}

- (void)readFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"home_content" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *data = [self jsonStringToKeyValues:content];
    
    NSArray *events = [data objectForKey:@"events"];
    
    self.dataList = [[NSArray yy_modelArrayWithClass:[MTFirstViewModel class] json:events] mutableCopy];
    
    [self.dataList enumerateObjectsUsingBlock:^(MTFirstViewModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.article.cover.length || !obj.article.title.length || !obj.article.snippet.length) {
            [self.dataList removeObject:obj];
        }
    }];
    
    
    NSArray *myArray = [[MTLocalDataManager shareInstance] getNoteSelf];
    [myArray enumerateObjectsUsingBlock:^(MTNoteModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        MTFirstViewModel *models = [MTFirstViewModel new];
        MTFirstViewContentModel *content = [MTFirstViewContentModel new];
        content.title = model.text;
        content.cover = model.imagePath;
        content.snippet = model.text;
        content.mid = model.noteId;
        content.isMe = YES;
        models.article = content;
        [self.dataList insertObject:models atIndex:0];
    }];
    
    [self.tableView reloadData];
}

//json字符串转化成OC键值对
- (id)jsonStringToKeyValues:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = nil;
    if (JSONData) {
        responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return responseJSON;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MTFirstViewModel *model = [self.dataList objectAtIndex:indexPath.row];
    if (model.article.mid.integerValue % 2 == 0 && !model.article.isMe) {
        MTSecondViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MTSecondViewCell getIdentifier]];
        cell.model = model;
        return cell;
    } else {
        MTFirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MTFirstViewCell getIdentifier]];
        cell.model = model;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTFirstViewModel *model = [self.dataList objectAtIndex:indexPath.row];
    
    if (model.article.mid.integerValue % 2 == 0  && !model.article.isMe) {
        return 140;
    } else {
        if (model.article.isMe && !model.article.title.length) {
            return 210;
        }
        return 230 + 32;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTFirstViewModel *model = [self.dataList objectAtIndex:indexPath.row];
    if (!model.article.isMe) {
        FLBaseWebViewController *web = [[FLBaseWebViewController alloc] initWithUrl:model.article.webUrl];
        web.hidesBottomBarWhenPushed = YES;
        web.navigationTitle = model.article.title;
        web.isShowNavigation = YES;
        [[MTHelp currentNavigation] pushViewController:web animated:YES];
    } else {
        [UIView showToastInKeyWindow:@"审核通过后方可查看，请耐心等待!"];
    }
}





//#pragma mark - Setter && Getter
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.height, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - self.navigationView.height - iPhoneBottomMargin)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerNib:[UINib nibWithNibName:@"MTSecondViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTSecondViewCell getIdentifier]];
         [_tableView registerNib:[UINib nibWithNibName:@"MTFirstViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTFirstViewCell getIdentifier]];
        _tableView.backgroundColor = [UIColor colorWithHex:0xeaeaea];
    }
    return _tableView;
}

@end

