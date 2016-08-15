//
//  ZoomImageView.m
//  84班微博
//
//  Created by xiacheng on 16/1/19.
//  Copyright © 2016年 george. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"
#import "SDPieProgressView.h"
#import "UIImage+GIF.h"


@interface ZoomImageView ()<NSURLSessionDataDelegate>

@end

@implementation ZoomImageView
{
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
    NSURLSessionDataTask *_dataTask;
    NSMutableData *_data;
    SDPieProgressView *_progressView;

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomIn)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomIn)];
        [self addGestureRecognizer:tap];
    }
    return self;
}



- (void)zoomIn
{
    [self _createViews];
    _fullImageView.image = [self fixrotation:self.image];
    
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = rect;
    [UIView animateWithDuration:0.5 animations:^{
        _fullImageView.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
        
        //图片可能是长图，需要修改contentSize
        CGFloat height = self.image.size.height / self.image.size.width * kScreenWidth;
        
        if (height > [UIScreen mainScreen].bounds.size.height) {
            
            _scrollView.contentSize = CGSizeMake(kScreenWidth, height);
            _fullImageView.height = height;
        }
        
//        _progressView = [[SDPieProgressView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//        _progressView.center = self.window.center;
//        [_scrollView addSubview:_progressView];
//        if (self.urlStr.length > 0) {
//            NSURL *url = [NSURL URLWithString:self.urlStr];
//            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//            _dataTask = [session dataTaskWithRequest:request];
//            _data = [NSMutableData data];
//            [_dataTask resume];
//        }
    }];
    
    
}

- (void)_createViews
{
    if (!_scrollView) {
     //1、scrollView 的创建
    _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentMode = UIViewContentModeScaleAspectFit;
    _scrollView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomOut)];
    [_scrollView addGestureRecognizer:tap];
    [self.window addSubview:_scrollView];
    
    //fullView 的创建
    _fullImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_fullImageView];
    
    }
}

- (void)zoomOut
{
    [_dataTask cancel];
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    [UIView animateWithDuration:0.5 animations:^{
        _fullImageView.frame = rect;
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _fullImageView = nil;
        _scrollView = nil;
        
    }];
}

#pragma mark - NSSessionDataTask delegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [_data appendData:data];
 
    _progressView.progress = (double)dataTask.countOfBytesReceived / dataTask.countOfBytesExpectedToReceive;
    
    if (_progressView.progress == 1) {
        
        //gif 图片的播放
        if (self.isGif) {
            _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
        }else{
            
            UIImage *image = [UIImage imageWithData:_data];
            _fullImageView.image = image;
            //图片可能是长图，需要修改contentSize
            CGFloat height = image.size.height / image.size.width * kScreenWidth;
        
            if (height > [UIScreen mainScreen].bounds.size.height) {
             
                _scrollView.contentSize = CGSizeMake(kScreenWidth, height);
                _fullImageView.height = height;
        }
            
    }
        
    }
    
}


//解析位置显示不对的问题
- (UIImage *)fixrotation:(UIImage *)image{
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
    
}


@end
