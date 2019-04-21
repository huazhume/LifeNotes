//
//  MTMessageModel.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/21.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTMessageModel.h"

@implementation MTMessageModel


- (CGFloat)height
{
    CGSize labelsize  = [self.content
                         boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, CGFLOAT_MAX)
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}
                         context:nil].size;
    
    CGFloat height = 0;
    if (!self.isFold) {
        height = 150;
    } else {
        height = labelsize.height + 61 + 15;
    }
   
    return height;
    
}

@end
