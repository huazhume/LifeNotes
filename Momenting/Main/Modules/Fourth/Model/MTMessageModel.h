//
//  MTMessageModel.h
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/21.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTMessageModel : NSObject


@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;

@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *source;
@property (assign, nonatomic) BOOL isFold;

@property (assign, nonatomic) CGFloat height;

@end

NS_ASSUME_NONNULL_END
