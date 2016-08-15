//
//  RootTabBarController.h
//  DaDaGo
//
//  Created by xiacheng on 16/4/27.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTabBarController : UITabBarController

@property (nonatomic, strong)  UIView *tabBarView;

- (void)swipeGestureDidSwipe:(UISwipeGestureRecognizer *)gesture;
- (void)goToFirstView;

@end
