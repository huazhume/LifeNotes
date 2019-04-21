//
//  MTMessageViewCell.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/21.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTMessageViewCell.h"

@interface MTMessageViewCell ()

@end

@implementation MTMessageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 5;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
