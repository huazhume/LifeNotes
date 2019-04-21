/**
 * 注册
 * @author xiaobai zhang 2018-12-22 创建文件
 */

#import "MTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - typedef
typedef void (^RE1Complete)(void);


#pragma mark - 声明
@interface RE1Controller : MTBaseViewController

@property (nonatomic, assign) NSInteger index;  // 0: 注册   1: 找回密码   2:绑定手机
@property (nonatomic, strong) NSString *openid;
@property (nonatomic, copy  ) RE1Complete complete;

@end

NS_ASSUME_NONNULL_END
