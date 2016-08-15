//
//  EJViewFinder.m
//  嗒个车
//
//  Created by xiacheng on 16/7/5.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "EJViewFinder.h"

@implementation EJViewFinder
//获取当前屏幕显示的viewcontroller
//这里返回的viewCnotroller 如果有tabbarVC，则返回的是tabbarVC。
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

//找到视图view 所在的viewController  //不包括navigationController
+ (UIViewController*)getParentViewController:(UIView*)view
{
    Class vcc = [UIViewController class];
    UIViewController *parentViewController = nil;
    UIResponder *responder = view;
    while ((responder = [responder nextResponder])){
        if ([responder isKindOfClass: vcc]){
            parentViewController =  (UIViewController*)responder;
            break;
        }
    }
    //    //如果是NavigationController情况，一般要获取当前的viewController
    //    if ([parentViewController isKindOfClass:[UINavigationController class]]) {
    //        parentViewController = [(UINavigationController*)parentViewController visibleViewController];
    //    }
    
    //    //如果是TabbarViewController 的情况，获取其正在显示的viewController
    //    if ([parentViewController isKindOfClass:[UITabBarController class]]) {
    //        parentViewController = [(UITabBarController *)parentViewController selectedViewController];
    //    }
    
    return parentViewController;
}

//!!!!!!先弃用!!!!!!
//找到当前被present出来的modal视图
- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


//找到当前显示的viewController，包括presentViewController
//这里返回的viewCnotroller 如果有tabbarVC，则返回的是tabbarVC。 如果有present出来的modalView，则是modalView
+ (UIViewController *)getTopViewController {
    UIViewController *topViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topViewController.presentedViewController) topViewController = topViewController.presentedViewController;
    
    return topViewController;
}


//----------------------------------------
//找到当前的最上面的viewcontroller，与getTopMostVC 类似
+ (UIViewController*) getTopMostViewController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    for (UIView *subView in [window subviews])
    {
        UIResponder *responder = [subView nextResponder];
        
        //added this block of code for iOS 8 which puts a UITransitionView in between the UIWindow and the UILayoutContainerView
        if ([responder isEqual:window])
        {
            //this is a UITransitionView
            if ([[subView subviews] count])
            {
                UIView *subSubView = [subView subviews][0]; //this should be the UILayoutContainerView
                responder = [subSubView nextResponder];
            }
        }
        
        if([responder isKindOfClass:[UIViewController class]]) {
            return [self topViewController: (UIViewController *) responder];
        }
    }
    
    return nil;
}

+ (UIViewController *) topViewController: (UIViewController *) controller
{
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}
//----------------------------------------


@end
