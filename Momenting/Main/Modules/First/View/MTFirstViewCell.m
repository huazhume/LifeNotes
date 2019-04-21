//
//  MTFirstViewCell.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/21.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTFirstViewCell.h"
#import <UIImageView+WebCache.h>
#import "MTMediaFileManager.h"
#import "MTDateFormatManager.h"
#import "UIImage+ImageCompress.h"

@implementation MTFirstViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    self.contentImageView.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setModel:(MTFirstViewModel *)model
{
    _model = model;
    self.titleLabel.text = model.article.title;
    self.contentLabel.text = model.article.snippet;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.article.cover]];

    [self.deepButton setTitle:model.article.isMe ? @"审核中":@"深度阅读" forState:UIControlStateNormal];
    
     [self.deepButton setTitleColor:model.article.isMe ? [UIColor colorWithHex:0x999999]:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
    
    if (![model.article.cover hasPrefix:@"http"]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *path = [[MTMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGEBATE_TYPE];
        NSString *beta_path = [NSString stringWithFormat:@"%@/%@",path,model.article.cover];
        if (![fileManager fileExistsAtPath:beta_path]) {
            NSString *originPath = [[MTMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGE_TYPE];
            NSString *imagePath = [NSString stringWithFormat:@"%@/%@",originPath,model.article.cover];
            UIImage *image = [UIImage compressImage:[[UIImage alloc] initWithContentsOfFile:imagePath] compressRatio:0.05];
            NSData *beta_data = nil;
            if (UIImagePNGRepresentation(image) == nil) {
                beta_data = UIImageJPEGRepresentation(image, 1.0);
            } else {
                beta_data = UIImagePNGRepresentation(image);
            }
            [fileManager createFileAtPath:beta_path contents:beta_data attributes:nil];
        }
          self.contentImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:beta_path]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
