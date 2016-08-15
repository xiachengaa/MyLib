//
//  ViewController.m
//  ScrollViewAndPageControl
//
//  Created by xiacheng on 16/4/1.
//  Copyright © 2016年 zjut. All rights reserved.
//

#import "ViewController.h"
#import "XXScrollAndPageView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<XXScrollAndPageViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    XXScrollAndPageView *scrollAndPageView = [[XXScrollAndPageView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
//    [self.view addSubview:scrollAndPageView];
//    
//    NSMutableArray *imageArr = [NSMutableArray array];
//    for (int i = 1; i < 6; i++) {
//        UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]]];
//        [imageArr addObject:view];
//    }
//    
//    scrollAndPageView.imageViewArr = imageArr;
    NSArray *imageNames = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    XXScrollAndPageView *scrollAndPageView = [XXScrollAndPageView viewWithFrame:CGRectMake(0, 100, kScreenWidth, 200) ImageNames:imageNames];
    scrollAndPageView.shouldAutoShow = YES;
    scrollAndPageView.delegate = self;
    [self.view addSubview:scrollAndPageView];
    
}

#pragma mark - <XXScrollAndPageViewDelegate>
- (void)didTapScrollView:(XXScrollAndPageView *)view atIndex:(NSInteger)index withUrl:(NSString *)urlString
{
    NSLog(@"index:%li   url:%@",(long)index,urlString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
