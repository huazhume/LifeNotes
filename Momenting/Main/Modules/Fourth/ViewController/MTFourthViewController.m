//
//  MTFourthViewController.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/20.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTFourthViewController.h"
#import "MTMessageViewCell.h"
#import "MTMessageModel.h"
#import "MTMarketHotView.h"
#import <MJRefresh/MJRefresh.h>


@interface MTFourthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) MTMarketHotView *hotView;


@property (nonatomic, strong) NSTimer *marketTimer;
@property (nonatomic, assign) NSInteger totalTimes;

@end

@implementation MTFourthViewController

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

- (void)loadData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    
    self.dataList = [NSMutableArray array];
    MTMessageModel *model1 = [[MTMessageModel alloc] init];
    model1.title = @"生活日记1.0版本上线啦";
    model1.content = @"亲爱的小伙伴们，生活笔记终于和你们见面了。作为新版本，我们定位社交圈。\n 透过「生活笔记」，我们想创造不同的工具，同所有对世界保持兴趣的人们成为朋友并把他们连接起来，一起探索并分享好的内容和信息。在这个世界上，已经有很多公司在满足人类「猎奇」他人信息的需求了，我们不会再做各种「头条」和「快报」，我们想做些其它的，用户也需要它们。\n [生活笔记」是我们想把美好的东西分享给我们的朋友的新努力，并且，这次会是一个持久努力";
    model1.time = @"2019-04-20";
    [self.dataList addObject:model1];
    
    
    MTMessageModel *model2 = [[MTMessageModel alloc] init];
    model2.title = @"创立生活日记的小故事";

    model2.content = @"当我坐在日本代官山的「蔦屋书店」，因为那个满满而平静的自己而感到幸福的时候；当我仔细设计自己的沙漠之旅、当我尝试第一次踏上滑雪板，我为自己深刻意识到世界之大感到幸福的时候；电脑前，看着创业伙伴创造一个又一个工具、认真的写着一个又一个文档、设计着一个又一个产品，听他讲「相对于出去玩，更喜欢来公司」的时候，我深深体会着「兴趣」融入「生活」、「梦想」融入「实践」的幸福，而这些感受与实实在在的获得，正是「生活日记」一定要和大家一起去持久「探索」、「激发」、「分享」的。";
    model2.time = @"2019-04-20";
     [self.dataList addObject:model2];
    
    
    MTMessageModel *model3 = [[MTMessageModel alloc] init];
    model3.title = @"[生活日记]招财纳士";
    model3.content = @"2016 年年初，我们的团队正式独立出来再次创业，此前，一直在参与培养一株叫做「豌豆荚」的神奇植物。过往的经历与点滴，让我们从来没有犹豫过，再次创业的使命仍将是「把更大、更美好的世界分享给用户」。所谓使命，就是一个团队想要为这个社会、为用户创造怎样的价值。\n 我们没有优厚的待遇，也没有「高大上」的工作环境，但假如你对上面的想法感兴趣，有兴趣加入我们，请致信 huazhume@163.com，说明来意。";
    model3.time = @"2019-04-19";
    [self.dataList addObject:model3];
    
    MTMessageModel *model4 = [[MTMessageModel alloc] init];
    model4.title = @"我们还是缺工程师";
    model4.content = @"今年 2 月份，生活日记向所有的朋友发送了一个邀请，请大家推荐能和我们一起攻克难题的人。我们还为每个岗位准备了一笔五位数的酬金。这个邀请给我们带来了不少志同道合的伙伴，我们万分感谢大家的帮助，同时也想告诉大家，五位数酬金的承诺仍然没有变化（毕竟都融到钱了）。\n引入更高效的开发框架，去用最少的人实现最大的可能性，对于一家创业公司和创业公司的每个工程师而言，是永远必要且有趣的事情。也只有在一个能够了解技术全貌的公司里，才能真正培养一个工程师的战略思维。\n对于工程师来说，如果想要参与一个早期公司的技术架构，或者想要为自己创业积累更全面的技术决策能力，生活日记是一个非常理想的选择。如果这个工程师还恰好对高品质内容充满热情，那就没有比生活日记更适合 ta 的地方了。\n如果你认识这样的工程师，或者你正是这样的工程师，一定不要犹豫把简历寄给生活日记（huazhume@163.com）。";
    model4.time = @"2019-04-19";
    [self.dataList addObject:model4];
    
    [self.tableView reloadData];
    [self addTimer];
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
    
    MTMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MTMessageViewCell getIdentifier]];
    
    MTMessageModel *model = [self.dataList objectAtIndex:indexPath.row];
    cell.timeLabel.text = model.time;
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.content;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTMessageModel *model = [self.dataList objectAtIndex:indexPath.row];
    return model.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTMessageModel *model = [self.dataList objectAtIndex:indexPath.row];
    model.isFold = !model.isFold;
    [self.tableView reloadData];
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
        _tableView.tableHeaderView = self.hotView;
        [_tableView registerNib:[UINib nibWithNibName:@"MTMessageViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTMessageViewCell getIdentifier]];
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
