//
//  MTNavigationView.h
//  Momenting
//
//  Created by huazhume on 2018/8/8.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTNavigationViewDelegate <NSObject>

@optional

- (void)leftAction;

- (void)rightAction;

@end

typedef NS_ENUM(NSUInteger, MTNavigationViewType) {
    MTNavigationViewNote = 0,
    MTNavigationViewNoteDetail,
};


@interface MTNavigationView : UIView

@property (weak, nonatomic) id <MTNavigationViewDelegate> delegate;

@property (assign, nonatomic) MTNavigationViewType type;

@property (copy, nonatomic) NSString *navigationTitle;

@property (copy, nonatomic) NSString *rightTitle;

@property (strong, nonatomic) UIColor *rightColor;

@property (copy, nonatomic) NSString *rightImageName;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)loadFromNib;

+ (CGFloat)viewHeight;

@end
