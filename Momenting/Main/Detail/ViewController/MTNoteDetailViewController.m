//
//  MTNoteDetailViewController.m
//  Momenting
//
//  Created by xiaobai zhang on 2018/8/14.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "MTNoteDetailViewController.h"
#import "MTNavigationView.h"
#import "MTNoteToolsTextCell.h"
#import "MTNoteToolsImageCell.h"
#import "MTNoteModel.h"
#import "MTLocalDataManager.h"
#import "MTActionToastView.h"
#import "MTNoteDetailSectionView.h"
#import <UIButton+WebCache.h>

@interface MTNoteDetailViewController ()
<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,
MTNavigationViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@property (weak, nonatomic) IBOutlet UIView *navigationBgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *toolsBgView;
@property (strong, nonatomic) NSMutableArray *datalist;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationBarTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolsViewBottomConstraint;

@property (assign, nonatomic) BOOL isAnimationing;
@property (strong, nonatomic) NSDate *lastScrollDate;
@property (assign, nonatomic) CGPoint scrollViewOldOffset;

@property (assign, nonatomic) BOOL isDownloading;
@property (weak, nonatomic) IBOutlet UIButton *weatherButton;

@property (strong, nonatomic) UIView *tableHeaderView;
@property (strong, nonatomic) UIButton *topButton;

@end

@implementation MTNoteDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseViews];
    [self loadData];
    self.weather = self.weather.length ? self.weather : @"A";
    [self.weatherButton setTitle:[NSString stringWithFormat:@" %@",self.weather] forState:UIControlStateNormal];
    self.weatherButton.titleLabel.font = [UIFont mtWeatherFontWithFontSize:22];
    NSArray *colors = @[[UIColor colorWithHex:0x96B46C],[UIColor colorWithHex:0xE48370],[UIColor colorWithHex:0xC496C5],[UIColor colorWithHex:0x79B47C],[UIColor colorWithHex:0xA299CE],[UIColor colorWithHex:0xA2AEBB] ];
    [self.weatherButton setTitleColor:colors[(int)arc4random_uniform(colors.count)] forState:UIControlStateNormal];
    
    self.jubaoButton.hidden = !self.isJubaoHidden;
    self.top.constant = self.navigationView.height - 20;
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    self.navigationView.navigationTitle = self.natitle;
    [self.topButton sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] forState:UIControlStateNormal];
}

- (void)loadData
{
    self.datalist = [[[MTLocalDataManager shareInstance] getNoteDetailList:self.noteId] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//   [UIApplication sharedApplication].statusBarHidden = YES;
//    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [UIApplication sharedApplication].statusBarHidden = self.isStatusBarHidden;
//    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
}

- (void)initBaseViews
{
//    [self.navigationBgView addSubview:self.navigationView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MTNoteToolsTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTNoteToolsTextCell getIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"MTNoteToolsImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTNoteToolsImageCell getIdentifier]];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.borderColor = self.color.CGColor;
    self.tableView.layer.masksToBounds = YES;
}

#pragma mark - ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView.contentOffset.y - self.scrollViewOldOffset.y > 1) {
//        //向下滑动
//        [self scrollAnimationIsShow:NO];
//    } else if (self.scrollViewOldOffset.y - scrollView.contentOffset.y > 0){
//        [self scrollAnimationIsShow:YES];
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 获取开始拖拽时tableview偏移量
    self.scrollViewOldOffset = scrollView.contentOffset;
}

- (void)scrollAnimationIsShow:(BOOL)isShow
{
    NSDate *nowDate = [NSDate date];
    
    NSTimeInterval times = [nowDate timeIntervalSinceDate:self.lastScrollDate];
    if (self.isAnimationing || self.tableView.contentOffset.y <= 0 || times < 0.5 || self.tableView.contentOffset.y >= self.tableView.contentSize.height) {
        return;
    }
    if (isShow && self.toolsViewBottomConstraint.constant == 0.f) {
        return;
    }
    
    if (!isShow && self.toolsViewBottomConstraint.constant == -44.f) {
        return;
    }
    self.lastScrollDate = [NSDate date];
    [self setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:0.29 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.navigationBarTopConstraint.constant = isShow ? -20.f : -40.f;
        self.toolsViewBottomConstraint.constant = isShow ? 0.f : -44.f;
//        [UIApplication sharedApplication].statusBarHidden = !isShow;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.isAnimationing = NO;
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.datalist[indexPath.row];
    UITableViewCell *cell = nil;
    if ([model isKindOfClass:[MTNoteTextVo class]]) {
        
        MTNoteTextVo *vo = model;
        MTNoteToolsTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:[MTNoteToolsTextCell getIdentifier]];
        [textCell setType:MTNoteToolsTextCellDetail];
        textCell.model = model;
        if (vo.fontSize == 0) {
            textCell.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        } else {
            textCell.font = [UIFont fontWithName:vo.fontName size:vo.fontSize];
        }

        cell = textCell;
        
    } else {
        MTNoteToolsImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:[MTNoteToolsImageCell getIdentifier]];
        imageCell.model = model;
        [imageCell setType:MTNoteToolsImageCellDetail];
        cell = imageCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.isDownloading ? [MTNoteDetailSectionView viewHeight] : 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MTNoteDetailSectionView *sectionView = [MTNoteDetailSectionView loadFromNib];
    sectionView.color = self.color;
    return self.isDownloading ? sectionView : [UIView new];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.datalist[indexPath.row];
    if ([model isKindOfClass:[MTNoteTextVo class]]) {
        return [MTNoteToolsTextCell heightForCellWithModel:model];
    } else {
        return [MTNoteToolsImageCell heightForCellWithModel:model];
    }
}

#pragma mark - events
- (IBAction)dismissButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)downloadButtonClicked:(id)sender
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85f, 0.85f);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        } completion:^(BOOL finished) {
            [self.tableView renderViewToImageCompletion:^(UIImage *image) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                MTActionToastView *toastView = [MTActionToastView loadFromNib];
                toastView.bounds = CGRectMake(0, 0, 110, 32);
                [toastView show];
                
            }];
        }];
    }];
    
}

#pragma mark - getter

- (NSMutableArray *)datalist
{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
        MTNoteTextVo *textModel = [[MTNoteTextVo alloc] init];
        [_datalist addObject:textModel];
    }
    return _datalist;
}



- (IBAction)jubaoButtonClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定要举报此内容吗？" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
}


- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"UADefaultPlaceholder"] forState:UIControlStateNormal];
        button.frame = CGRectMake(8, 8, SCREEN_WIDTH - 16, 200 -16);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [_tableHeaderView addSubview:button];
        self.topButton = button;
    }
    return _tableHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
