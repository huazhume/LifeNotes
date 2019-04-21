//
//  MTNavigationView.m
//  Momenting
//
//  Created by huazhume on 2018/8/8.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "MTNavigationView.h"

@interface MTNavigationView ()



@end

@implementation MTNavigationView

+ (instancetype)loadFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"MTNavigationView" owner:nil options:nil];
    if (views && views.count > 0) {
        return [views firstObject];
    }
    return nil;
}

+ (CGFloat)viewHeight
{
    return 55.f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self registNotifications];
}


- (void)registNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:)name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)orientChange:(NSNotification *)noti
{
//    self.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setter
- (void)setType:(MTNavigationViewType)type
{
    self.titleLabel.text = type == MTNavigationViewNoteDetail ? @"" : @"Note";
    self.rightButton.hidden = type == MTNavigationViewNoteDetail;
    NSString *imageName = type == MTNavigationViewNoteDetail ? @"ic_arrow_back_white_24dp" : @"ic_arrow_back_black_24dp";
    [self.leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setNavigationTitle:(NSString *)navigationTitle
{
    _navigationTitle = navigationTitle;
    self.titleLabel.text = navigationTitle;
}

- (void)setRightTitle:(NSString *)rightTitle
{
    _rightTitle = rightTitle;
    self.rightButton.hidden = !rightTitle.length;
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
}

- (void)setRightImageName:(NSString *)rightImageName
{
    _rightImageName = rightImageName;
    [self.rightButton setImage:[UIImage imageNamed:rightImageName] forState:UIControlStateNormal];
}

- (void)setRightColor:(UIColor *)rightColor
{
    _rightColor = rightColor;
    [self.rightButton setTitleColor:rightColor forState:UIControlStateNormal];
}

#pragma mark - events

- (IBAction)leftButtonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftAction)]) {
        [self.delegate leftAction];
    }
}
- (IBAction)rightButtonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightAction)]) {
        [self.delegate rightAction];
    }
}

@end
