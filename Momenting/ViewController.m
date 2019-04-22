//
//  ViewController.m
//  Momenting
//
//  Created by xiaobai zhang on 2018/8/7.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "ViewController.h"
#import "MTFirstViewController.h"
#import "MTSecondViewController.h"
#import "MTThirdViewController.h"
#import "MTFourthViewController.h"
#import "MTFifthViewController.h"
#import "MTNoteViewController.h"
#import "MineController.h"

#pragma mark - 声明
@interface ViewController ()<UITabBarControllerDelegate>




@end


#pragma mark - 实现
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    MTFirstViewController *home = [[MTFirstViewController alloc] init];
    [self addChildViewController:home title:@"热门" image:@"tabbar_detail_n" selImage:@"tabbar_detail_s"];
    
    MTSecondViewController *sort = [[MTSecondViewController alloc] init];
    [self addChildViewController:sort title:@"发现" image:@"tabbar_chart_n" selImage:@"tabbar_chart_s"];
    
    MTThirdViewController *message = [[MTThirdViewController alloc] init];
    [self addChildViewController:message title:@"书写" image:@"" selImage:@""];
    
    MTFourthViewController *cart = [[MTFourthViewController alloc] init];
    [self addChildViewController:cart title:@"消息" image:@"tabbar_discover_n" selImage:@"tabbar_discover_s"];
    
    MineController *mine = [[MineController alloc] init];
    [self addChildViewController:mine title:@"我的" image:@"tabbar_mine_n" selImage:@"tabbar_mine_s"];
    
    self.tabBar.tintColor = [UIColor blackColor];
    
    UIImageView *imagaVIew = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 15, 9.5, 30, 30)];
    imagaVIew.image = [UIImage imageNamed:@"tab_stroked_write"];
    [self.tabBar addSubview:imagaVIew];
}

- (void)addChildViewController:(MTBaseViewController *)childVc title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    static NSInteger index = 0;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    childVc.tabBarItem.tag = index;
    childVc.navTitle = title;
    
    index++;
    
    // 让子控制器包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
    
    if (index == 2) {
        MTNoteViewController *vc = [[MTNoteViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 2) return NO;
    return YES;
}


@end
