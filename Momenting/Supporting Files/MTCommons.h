//
//  MYCommons.h
//  Meiyu
//
//  Created by QingyunLiao on 15/11/6.
//  Copyright © 2015年 jimeiyibao. All rights reserved.
//

#ifndef MYCommons_h
#define MYCommons_h


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define Localized(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Language"]

#define IS_iPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneTopMargin (IS_iPHONE_X ? 24.f : 0.f)
#define iPhoneBottomMargin (IS_iPHONE_X ? 34.f : 0.f)

// 颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HexColor(A) [UIColor colorWithHexString:A]

// 线条
#define kColor_Line_Night          HexColor(@"27262A")       // Cell 线条
#define kColor_Main_Color          RGBA(1,202,94,1)
#define kColor_Main_Dark_Color     RGBA(241,206,65,1)
#define kColor_Red_Color           HexColor(@"FF4500")
#define kColor_Red_Dark_Color      HexColor(@"f24302")

#define zl_weakify(var)   __weak typeof(var) weakSelf = var
#define zl_strongify(var) __strong typeof(var) strongSelf = var

#import "UIColor+Hex.h"
#import "UITableViewCell+Categoty.h"
#import "UITextView+Category.h"
#import <Masonry/Masonry.h>
#import "UIView+Category.h"
#import "MTHelp.h"
#import "NSDateFormatter+Category.h"
#import "MTLanguageManager.h"
#import "UIFont+MTFont.h"
#import "MTBaseViewController.h"
#import "UIView+Extension.h"
#import "UIFont+Extension.h"
#import "UITableViewCell+Extension.h"
#import "UITableView+Extension.h"
#import "BaseView.h"
#import "AFNManager.h"
#import "CountDown.h"
#import <MJExtension/MJExtension.h>
#import "UIView+TCYToast.h"

// 单色
#define kColor_White               HexColor(@"#FFFFFF")     // 白色

// 背景色
#define kColor_BG                  RGBA(250,250,250,1)      // 日间背景色
#define kColor_Line_Color          RGBA(245,245,245,1)      // 日间背景色

#define kColor_Night_Back_Small    HexColor(@"#232226")     // 夜间背景色 浅
#define kColor_Night_Back_Medium   HexColor(@"#232226")     // 夜间背景色 中等
#define kColor_Night_Back_Big      HexColor(@"#201523")     // 夜间背景色 深

// 文字颜色
#define kColor_Text_Black          RGBA(52, 50, 51, 1)       // 深
#define kColor_Text_Gary           HexColor(@"#999999")      // 灰
#define kColor_Text_Light          HexColor(@"#8B8B8B")      // 浅
#define kColor_Text_Red            HexColor(@"#FD4751")      // 红

#define kColor_Chart_Header        RGBA(79, 76, 77, 1)       // 图表头视图底部
#define kColor_Chart_Text          RGBA(220, 220, 220, 1)    // 图表文字

// Cell高亮
#define kColor_Cell_High_Light     HexColor(@"D9D9D9")       // Cell点击高亮色
#define kColor_Cell_High_Night     HexColor(@"1B1B1B")       // Cell点击高亮色


#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)


// 比例
#define countcoordinatesX(A) [UIScreen mainScreen].bounds.size.width * (A / 375.f)


// 版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
#define iOS12Later ([UIDevice currentDevice].systemVersion.floatValue >= 12.0f)
#define iOS7 (iOS7Later) && !(iOS8Later)
#define iOS8 (iOS8Later) && !(iOS9Later)
#define iOS9 (iOS9Later) && !(iOS10Later)
#define iOS10 (iOS10Later) && !(iOS11Later)
#define iOS11 (iOS11Later) && !(iOS12Later)


// 手机型号
#define IS_SIMULATOR (TARGET_IPHONE_SIMULATOR == 1 ? 1 : 0)
#define IS_IPHONEXR (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)
#define IS_IPHONEX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE_6_PLUS_UP ([[UIScreen mainScreen] bounds].size.height > 736.0f)


// 尺寸
#define StatusBarHeight ((IS_IPHONEX || IS_IPHONEXR) ? 44.f : 20.f)
#define SafeAreaBottomHeight (IS_IPHONEX || IS_IPHONEXR ? 34 : 0)
#define TabbarHeight    (49.f + SafeAreaBottomHeight)
#define NavigationBarHeight (44.f + StatusBarHeight)


// 颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HexColor(A) [UIColor colorWithHexString:A]

// 字体
#define AdjustFont(A) [UIFont adjustFontSize:A]



#endif /* MYCommons_h */
