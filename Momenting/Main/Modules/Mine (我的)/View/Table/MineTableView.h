/**
 * 我的列表
 * @author xiaobai zhang 2018-12-16 创建文件
 */

#import <UIKit/UIKit.h>
@class MineTableHeader;

NS_ASSUME_NONNULL_BEGIN

@interface MineTableView : UITableView

@property (nonatomic, strong) MineTableHeader *header;
  
+ (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
