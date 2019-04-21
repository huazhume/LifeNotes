//
//  MTFirstViewModel.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/21.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTFirstViewModel.h"

@implementation MTFirstViewModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"article" : [MTFirstViewContentModel class]};
}




@end

@implementation MTFirstViewCorverModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

@implementation MTFirstViewContentModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"covers" : [MTFirstViewCorverModel class]};
}

- (CGFloat)height
{
    return self.type ? 150 : 200;
}

- (NSInteger)type
{
    return 1;
}

@end
