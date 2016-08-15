//
//  EJViewFinder.h
//  嗒个车
//
//  Created by xiacheng on 16/7/5.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJViewFinder : NSObject
/**
 *  打到当前正在显示的viewController(可能是根viewController)
 *
 *  @return 当前正在显示的viewController
 */
+ (UIViewController *)getCurrentVC;


/**
 *  找到view 所属的viewController
 *
 *  @param view UIView 对象
 *
 *  @return view所属的viewController
 */
+ (UIViewController*)getParentViewController:(UIView*)view;

/**
 *  找到在最上面显示的viewController,包括present出来的modal
 *
 *  @return viewController
 */
+ (UIViewController *)getTopViewController;

/**
 *  找到在最上面显示的viewController,包括present出来的modal
 *
 *  @return viewController
 */
+ (UIViewController*) getTopMostViewController;

@end
