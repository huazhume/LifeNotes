/**
 * 记账
 * @author xiaobai zhang 2018-12-16 创建文件
 */

#import "MineController.h"
#import "MTMeModel.h"
#import "MTUserInfoDefault.h"
#import "MineTableHeader.h"


#pragma mark - 声明
@interface MineController()

@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation MineController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self mine];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mine.table.header refresh];
}

- (void)setupUI {
    [self.view addSubview:_mine];
}


#pragma mark - 请求

#pragma mark - set

// Cell
- (void)mineCellClick:(NSIndexPath *)indexPath {
 
}
// 头像
- (void)headerIconClick:(id)data {
    // 登录了
   
}
// 打卡
- (void)punchClick:(id)data {
   
}
// 连续打卡


#pragma mark - get
- (MineView *)mine {
    if (!_mine) {
        _mine = [MineView loadCode:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabbarHeight)];
    }
    return _mine;
}


#pragma mark - 系统

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupUI];
}


@end
