//
//  MTBaseViewController.h
//  Momenting
//
//  Created by xiaobai zhang on 2018/9/14.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTNavigationView.h"

@interface MTBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *navigationBgView;

@property (strong, nonatomic) MTNavigationView *navigationView;

@property (copy, nonatomic) NSString *navTitle;

@end
