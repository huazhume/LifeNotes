//
//  BaseCollectionReusableView.h
//  coding-ios-master
//
//  Created by xiaobai zhang on 2018/5/5.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionReusableView : UICollectionReusableView

+ (instancetype)initWithCollection:(UICollectionView *)collection kind:(NSString *)kind indexPath:(NSIndexPath *)indexPath;
- (void)initUI;

@end
