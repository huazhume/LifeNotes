//
//  MTFirstViewCell.h
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/21.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTFirstViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTFirstViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *deepButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@property (strong, nonatomic) MTFirstViewModel *model;


@end

NS_ASSUME_NONNULL_END
