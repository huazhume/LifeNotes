/**
 * 登录
 * @author xiaobai zhang 2018-12-17 创建文件
 */

#import "MTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - type
typedef void (^LoginComplete) (void);

#pragma mark - 声明
@interface LoginController : MTBaseViewController

@property (nonatomic, copy  ) LoginComplete complete;

@end


NS_ASSUME_NONNULL_END
