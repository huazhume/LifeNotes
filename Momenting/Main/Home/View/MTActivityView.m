
//
//  MTActivityView.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/13.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTActivityView.h"
#import "MTMarketHotView.h"
#import <MJRefresh/MJRefresh.h>
#import "MTActivityViewCell.h"
#import "MTNoteDetailViewController.h"

@interface MTActivityView () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) MTMarketHotView *hotView;

@property (nonatomic, strong) NSTimer *marketTimer;
@property (nonatomic, assign) NSInteger totalTimes;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MTActivityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.top.equalTo(self);
        }];
        
        NSMutableArray *muImage = [NSMutableArray array];
        for (int i = 1 ; i < 34 ; i ++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
            [muImage addObject:image];
        }
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
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
        [self addTimer];
        
        self.dataArray = [NSMutableArray array];
        NSMutableArray *muArray1 = [NSMutableArray array];
        [muArray1 addObject:@{@"title":@"生活困境",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/451e5da8167863d39d6292d6e72fb6ae_600_426.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_01"}];
        [muArray1 addObject:@{@"title":@"电影题材",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/a8fa825833274e1a6194284f0ee07ba7_1000_425.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_02"}];
        
        [self.dataArray addObject:muArray1];
        
        
        NSMutableArray *muArray2 = [NSMutableArray array];
        [muArray2 addObject:@{@"title":@"缘浅缘深，如溪如河",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/ed55b78f8fd7850bf4be9e20dc771da1_922_393.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_03"}];
        [muArray2 addObject:@{@"title":@"爱情和生活",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/899ac4844a2363307307bb0fccd7d73d_1075_459.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_04"}];
        
        [self.dataArray addObject:muArray2];
        
        
        NSMutableArray *muArray3 = [NSMutableArray array];
        [muArray3 addObject:@{@"title":@"读心术",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/0d224d8586580b1e7b4eb87f3d655705_1080_1350.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_05"}];
        [muArray3 addObject:@{@"title":@"涂鸦人生",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/2676ff014a2f226b7bc4ba7cdf5e5122_2982_2448.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_06"}];
        
        [self.dataArray addObject:muArray3];
        
        
        NSMutableArray *muArray4 = [NSMutableArray array];
        [muArray4 addObject:@{@"title":@"街角的咖啡店",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/8867ccc7ac42bd47679dbf83e924d76f_800_340.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_07"}];
        [muArray4 addObject:@{@"title":@"记录生命的阳光",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/daba778a3bd0bc2d20c273d54de708a7_690_920.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_08"}];
        
        [self.dataArray addObject:muArray4];
        
        
        NSMutableArray *muArray5 = [NSMutableArray array];
        [muArray5 addObject:@{@"title":@"社交另一半的她",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/8938e44a0fa12103941ebc19e5999c80_833_354.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_09"}];
        [muArray5 addObject:@{@"title":@"时光荏苒",@"image":@"http://qiniuimg.qingmang.mobi/image/orion/09bd75f37f0552f6614b4327e879d179_1080_810.jpeg?imageView2/2/w/750/format/jpg/interlace/1/ignore-error/1",@"id" : @"detail_010"}];
        
        [self.dataArray addObject:muArray5];
    }
    return self;
    
}


- (void)dealloc
{
    [self cleanTimer];
}


- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTActivityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MTActivityViewCell getIdentifier]];
    [cell setDataArray:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_WIDTH - 15)/2 + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark - Timer
//添加定时器
-(void)addTimer{
    [[NSRunLoop currentRunLoop] addTimer:self.marketTimer forMode:NSRunLoopCommonModes];
}

- (void)timerAction:(id)sender
{
    self.totalTimes ++;
    [self.hotView switchCurrentBanner];
}

//删除定时器
-(void)cleanTimer{
    
    if (_marketTimer) {
        [_marketTimer invalidate];
        _marketTimer = nil;
    }
}

-(void)pauseTimer{
    
    if (_marketTimer) {
        _marketTimer.fireDate = [NSDate distantFuture];
    }
}
//继续定时器
- (void)continueTimer {
    if (_marketTimer) {
        _marketTimer.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.5];
    }
}



#pragma mark - Lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.tableHeaderView = self.hotView;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"MTActivityViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTActivityViewCell getIdentifier]];
        
    }
    return _tableView;
}

- (MTMarketHotView *)hotView
{
    if (!_hotView) {
        _hotView = [[MTMarketHotView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        [_hotView setDataArray:nil];
    }
    return _hotView;
}

- (NSTimer *)marketTimer
{
    if (!_marketTimer) {
        _marketTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
    return _marketTimer;
}

@end
