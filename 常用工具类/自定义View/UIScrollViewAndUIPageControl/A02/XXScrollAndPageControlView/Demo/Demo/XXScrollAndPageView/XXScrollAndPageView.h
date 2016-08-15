//
//  XXScrollViewAndPageControlView.h
//  ScrollViewAndPageControl
//
//  Created by xiacheng on 16/4/1.
//  Copyright © 2016年 zjut. All rights reserved.
//

//NSArray 的内存管理策略

#import <UIKit/UIKit.h>

@protocol XXScrollAndPageViewDelegate;
@interface XXScrollAndPageView : UIView


@property (nonatomic, strong)  NSArray<UIView *> *imageViewArr;
@property (nonatomic, assign)   BOOL shouldAutoShow;
@property (nonatomic, assign)   id<XXScrollAndPageViewDelegate> delegate;
@property (nonatomic, strong)  NSArray<NSString *> *imageNames;
@property (nonatomic, strong)  NSArray<NSString *> *urlArray;

+ (instancetype)viewWithFrame:(CGRect)frame  ImageNames:(NSArray *)imageNames urlArray:(NSArray *)urlArray;

+ (instancetype)viewWithFrame:(CGRect)frame  ImageNames:(NSArray *)imageNames;

@end




@protocol XXScrollAndPageViewDelegate <NSObject>
@optional
- (void)didTapScrollView:(XXScrollAndPageView *)view atIndex:(NSInteger)index;
- (void)didTapScrollView:(XXScrollAndPageView *)view atIndex:(NSInteger)index withUrl:(NSString *)urlString;
@end


