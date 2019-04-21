/**
 * 我的列表
 * @author xiaobai zhang 2018-12-16 创建文件
 */

#import "MineTableView.h"
#import "MineTableCell.h"
#import "MineTableHeader.h"
#import "MINE_EVENT_MANAGER.h"
#import "MTProfileSetViewController.h"
#import "MTNotificationViewController.h"
#import "FLBaseWebViewController.h"
#import "MTMyIssiaViewController.h"


#define APP_ID @"1460515293"
// iOS 11 以下的评价跳转
#define APP_OPEN_EVALUATE [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APP_ID]
// iOS 11 的评价跳转
#define APP_OPEN_EVALUATE_AFTER_IOS11 [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8&action=write-review", APP_ID]


#pragma mark - 声明
@interface MineTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSArray<NSArray *> *> *datas;

@property (nonatomic, strong) UIButton *footerButton;

@end


#pragma mark - 实现
@implementation MineTableView


+ (instancetype)initWithFrame:(CGRect)frame {
    MineTableView *table = [[MineTableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [table setDelegate:table];
    [table setDataSource:table];
    [table lineHide];
    [table lineAll];
    [table setTableHeaderView:[table header]];
    [table setShowsVerticalScrollIndicator:NO];
    [table setShowsHorizontalScrollIndicator:NO];
    [table setBackgroundColor:kColor_BG];
    [table setContentInset:UIEdgeInsetsMake(0, 0, countcoordinatesX(50), 0)];
    [table setBackgroundView:({
        UIView *back = [[UIView alloc] initWithFrame:table.bounds];
        [back setBackgroundColor:kColor_BG];
        [back addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, table.header.height)];
            view.backgroundColor = kColor_Main_Color;
            view;
        })];
        back;
    })];
    table.tableFooterView = table.footerButton;
    return table;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas[0].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas[0][section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableCell *cell = [MineTableCell loadFirstNib:tableView];
    cell.indexPath = indexPath;
    cell.nameLab.text = self.datas[0][indexPath.section][indexPath.row];
    cell.icon.image = [UIImage imageNamed:self.datas[1][indexPath.section][indexPath.row]];
    cell.status = [self.datas[2][indexPath.section][indexPath.row] integerValue];
   
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return countcoordinatesX(50);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return !section ? countcoordinatesX(10) : 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = kColor_BG;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor colorWithHex:0xfafafa];
    return footer;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *baseVC = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            baseVC = [MTProfileSetViewController new];
        } else if (indexPath.row == 1) {
            baseVC = [MTNotificationViewController new];
            
        }
        
    } else {
        if (indexPath.row == 0) {
           //评分
            
            NSString *version= [UIDevice currentDevice].systemVersion;
            NSString *urlString = nil;
            if(version.doubleValue >=11.0) {
                
                urlString = APP_OPEN_EVALUATE_AFTER_IOS11;
            }else{
                urlString = APP_OPEN_EVALUATE;
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        } else if (indexPath.row == 1) {
            //反馈
            MTMyIssiaViewController *vc = [[MTMyIssiaViewController alloc] init];
            baseVC = vc;
        } else if (indexPath.row == 2) {
            //帮助
        } else {
            //关于生活笔记
            NSString * htmlPath = @"aboutours";
            FLBaseWebViewController *web = [[FLBaseWebViewController alloc] initWithUrl:htmlPath];
            web.isShowNavigation = YES;
            web.navigationTitle = @"关于我们";
            baseVC = web;
        }
    }
    
    if (!baseVC) return;
    baseVC.hidesBottomBarWhenPushed = YES;
    [[MTHelp currentNavigation] pushViewController:baseVC animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}


#pragma mark - get
- (MineTableHeader *)header {
    if (!_header) {
        _header = [MineTableHeader loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, countcoordinatesX(240))];
        
    }
    return _header;
}
- (NSArray<NSArray<NSArray *> *> *)datas {
    _datas = @[
               @[
                   @[@"修改资料",@"定时提醒",@"声音开关",@"平台推送"],
                   @[@"去App Store给生活笔记评分",@"意见反馈",@"帮助",@"关于生活笔记"],
                   ],
               @[
                   @[@"mine_tallytype",@"mine_remind",@"mine_sound",@"mine_detail"],
                   @[@"mine_rating",@"mine_feedback",@"mine_help",@"mine_about"],
                   ],
               @[
                   @[@(0),@(0),@(1),@(1)],
                   @[@(0),@(0),@(0),@(0),@(0),@(0)],
                   ]
               ];
    return _datas;
}

- (UIButton *)footerButton
{
    if (!_footerButton) {
        _footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_footerButton setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
        [_footerButton setTitle:@"退出登录" forState:UIControlStateNormal];
        _footerButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _footerButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        _footerButton.backgroundColor = [UIColor whiteColor];
    }
    return _footerButton;
}


@end
