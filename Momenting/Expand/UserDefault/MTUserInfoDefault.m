//
//  MTUserInfoDefault.m
//  Momenting
//
//  Created by xiaobai zhang on 2018/8/28.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "MTUserInfoDefault.h"
#import "MTMeModel.h"
#import "MTMediaFileManager.h"

static NSString *kUserInfoKey = @"userInfoKey";
static NSString *kLanagureKey = @"appLanguage";

static NSString *kUsersKey = @"kUsersKey";

@implementation MTUserInfoDefault


+ (NSArray *)users
{
    NSString *key = kUsersKey;
    NSArray *info = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return info;
}

+ (void)saveUser:(NSDictionary *)user
{
    NSString *userPhone = user[@"phone"];
    NSArray *users = [self users];
    
    __block BOOL isExist = NO;
    [users enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *objPhone = obj[@"phone"];
        if ([userPhone isEqualToString:objPhone]) {
            NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:obj];
            [mudic setObject:user[@"password"] forKey:@"password"];
            obj = [mudic copy];
            isExist = YES;
        }
    }];
    
    NSMutableArray *muUsers = [NSMutableArray arrayWithArray:users];
    if (!isExist) {
        [muUsers addObject:user];
    }
    
    NSString *key = kUsersKey;
    [[NSUserDefaults standardUserDefaults] setObject:muUsers forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isLoginSuccessWithUser:(NSDictionary *)user {
    
    NSString *userPhone = user[@"phone"];
    NSString *password = user[@"password"];
    NSArray *users = [self users];
    __block BOOL isExist = NO;
    [users enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *objPhone = obj[@"phone"];
        NSString *objPassword = obj[@"password"];
        if ([userPhone isEqualToString:objPhone] && [objPassword isEqualToString:password]) {
            isExist = YES;
        }
    }];
    
    if (isExist) {
        [UIView showToastInKeyWindow:@"欢迎登陆"];
    } else {
        [UIView showToastInKeyWindow:@"用户名或密码错误"];
    }
    
    return isExist;
}



+ (void)saveDefaultUserInfo:(MTMeModel *)model
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    if (model.image) {
        [info setObject:model.image forKey:@"image"];
    }
    if (model.name) {
        [info setObject:model.name forKey:@"name"];
    }
    if (model.about) {
        [info setObject:model.about forKey:@"about"];
    }
    NSString *key = kUserInfoKey;
    [[NSUserDefaults standardUserDefaults] setObject:info forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (MTMeModel *)getUserDefaultMeModel
{
    NSString *key = kUserInfoKey;
    NSDictionary *info = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    MTMeModel *meModel = [[MTMeModel alloc] init];
    [meModel setValuesForKeysWithDictionary:info];
    meModel.image = [[MTMediaFileManager sharedManager]getUserImageFilePath];
    return meModel;
    
}

+ (void)saveDefaultLanagure:(BOOL)isChinese
{
    NSString *key = kLanagureKey;
    NSString *string = isChinese ? @"zh-Hans" : @"en";
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getUserDefaultLanagureIsChinese
{
    NSString *key = kLanagureKey;
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return ![string isEqualToString:@"en"];
}

+ (void)saveHomeWebURL:(NSDictionary*)url
{
    NSString *key = @"homeWebURL";
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDictionary *)getHomeWebURL
{
    NSString *key = @"homeWebURL";
    NSDictionary *string = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return string;
}

+ (void)saveAgreeSecretList
{
    NSString *key = @"AgreeSecretList";
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isAgreeSecretList
{
    NSString *key = @"AgreeSecretList";
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


@end
