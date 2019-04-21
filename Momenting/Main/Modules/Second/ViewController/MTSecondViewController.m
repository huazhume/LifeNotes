//
//  MTSecondViewController.m
//  Momenting
//
//  Created by xiaobai zhang on 2019/4/20.
//  Copyright © 2019年 xiaobai zhang. All rights reserved.
//

#import "MTSecondViewController.h"
#import "MTActivityView.h"

@interface MTSecondViewController ()

@property (strong, nonatomic) MTActivityView *activityView;


@end

@implementation MTSecondViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationView.leftButton.hidden = YES;
    [self.view addSubview:self.activityView];
}



- (MTActivityView *)activityView
{
    if (!_activityView) {
        _activityView = [[MTActivityView alloc] initWithFrame:CGRectMake(0, self.navigationView.height, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - self.navigationView.height - iPhoneBottomMargin)];
    }
    return _activityView;
    
}


@end
