//
//  ZoomImageView.m
//  ZoomImageView
//
//  Created by xiacheng on 16/7/6.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "ZoomImageView.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"

@implementation ZoomImageView

- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapRecognizer addTarget:self action:@selector(bigButtonTapped:)];
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
    [self setAccessibilityLabel:@"Photo of a cat wearing a Bane costume."];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
        [tapRecognizer addTarget:self action:@selector(bigButtonTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        self.userInteractionEnabled = YES;
        [self setAccessibilityLabel:@"Photo of a cat wearing a Bane costume."];
    }
    return self;
    
}


- (void)bigButtonTapped:(id)sender {
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    if (self.url.length > 0) {
        imageInfo.imageURL = [NSURL URLWithString:self.url];
    }else{
        imageInfo.image = self.image;
    }
    
    imageInfo.referenceRect = self.frame;
    imageInfo.referenceView = self.superview;
    imageInfo.referenceContentMode = self.contentMode;
    imageInfo.referenceCornerRadius = self.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    UIViewController *currentVC = [self getTopViewController];
    [imageViewer showFromViewController:currentVC transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

//找到当前显示的viewController，包括presentViewController
//这里返回的viewCnotroller 如果有tabbarVC，则返回的是tabbarVC。 如果有present出来的modalView，则是modalView
- (UIViewController *)getTopViewController {
    UIViewController *topViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topViewController.presentedViewController) topViewController = topViewController.presentedViewController;
    
    return topViewController;
}
@end
