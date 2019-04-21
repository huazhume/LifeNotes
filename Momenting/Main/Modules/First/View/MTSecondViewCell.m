//
//  MTSecondViewCell.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/21.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTSecondViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MTSecondViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setModel:(MTFirstViewModel *)model
{
    _model = model;
  
    _model = model;
    self.titleLabel.text = model.article.title;
    self.contentLabel.text = model.article.snippet;
     [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.article.cover]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
