/**
 * 工具类
 * @author xiaobai zhang 2018-12-24 创建文件
 */

#import "MTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - typedef
typedef void (^LoginComplete)(void);

#pragma mark - 声明
@interface MTBaseViewController (Extension)

- (void)startQQLogin:(LoginComplete)complete;

@end


NS_ASSUME_NONNULL_END
