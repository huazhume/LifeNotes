//
//  NSDateFormatter+MYCategory.h
//  Meiyu
//
//  Created by QingyunLiao on 16/1/25.
//  Copyright © 2016年 jimeiyibao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (MYCategory)

+ (NSDateFormatter *)sharedFormatter;

+ (NSDateFormatter *)my_getHHmmFormatter;

+ (NSDateFormatter *)my_gethhmmFormatter;

+ (NSDateFormatter *)my_getDefaultFormatter;

+ (NSDateFormatter *)my_getMMddHHmmssFormatter;

+ (NSDateFormatter *)my_getMMddHHmmFormatter;

+ (NSDateFormatter *)my_getHHmmssFormatter;

+ (NSDateFormatter *)my_getOralMMddHHmmFormatter;

+ (NSDateFormatter *)my_getSegmentMMddHHmmFormatter;

+ (NSDateFormatter *)my_getYYMMddFormatter;

+ (NSDateFormatter *)my_getYYMMddHHmmFormatter;

+ (NSDateFormatter *)my_getDDFormatter;

+ (NSDateFormatter *)my_getMMddFormatter;

+ (NSDateFormatter *)my_getSegmentMMddHHmmssFormatter;

@end
