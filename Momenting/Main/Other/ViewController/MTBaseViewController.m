//
//  MTBaseViewController.m
//  Momenting
//
//  Created by xiaobai zhang on 2018/9/14.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "MTBaseViewController.h"

@interface MTBaseViewController () <MTNavigationViewDelegate>


@end

@implementation MTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.navigationView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Setter
- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    self.navigationView.navigationTitle = navTitle;
}

#pragma mark - MTNavigationViewDelegate
- (void)leftAction
{
    [[MTHelp currentNavigation] popViewControllerAnimated:YES];
}

- (void)rightAction
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter
- (MTNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [MTNavigationView loadFromNib];
        _navigationView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55 + iPhoneTopMargin);
        _navigationView.delegate = self;
        _navigationView.rightTitle = @"";
        _navigationView.navigationTitle = @"";
    }
    return _navigationView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
