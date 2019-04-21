//
//  MTFirstViewModel.h
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/21.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface MTFirstViewCorverModel : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *width;

@end


@interface MTFirstViewContentModel : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *snippet;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) MTFirstViewCorverModel *covers;

@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *mid;
@property (strong, nonatomic) NSString *webUrl;
@property (nonatomic, assign) BOOL isMe;

@end

@interface MTFirstViewModel : NSObject


@property (strong, nonatomic) MTFirstViewContentModel *article;

@end

NS_ASSUME_NONNULL_END
