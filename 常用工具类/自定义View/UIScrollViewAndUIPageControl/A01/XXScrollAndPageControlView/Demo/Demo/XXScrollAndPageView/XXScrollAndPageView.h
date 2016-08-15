//
//  XXScrollViewAndPageControlView.h
//  ScrollViewAndPageControl
//
//  Created by xiacheng on 16/4/1.
//  Copyright © 2016年 zjut. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XXScrollAndPageViewDelegate;
@interface XXScrollAndPageView : UIView


@property (nonatomic, strong )  NSMutableArray<UIView *> *imageViewArr;
@property (nonatomic, assign)   BOOL shouldAutoShow;
@property (nonatomic, assign)   id<XXScrollAndPageViewDelegate> delegate;
@end

@protocol XXScrollAndPageViewDelegate <NSObject>
@optional
- (void)didTapScrollView:(XXScrollAndPageView *)view atIndex:(NSInteger)index;
@end


