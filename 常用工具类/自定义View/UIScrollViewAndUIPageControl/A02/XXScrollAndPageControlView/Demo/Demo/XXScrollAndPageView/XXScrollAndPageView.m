//
//  XXScrollViewAndPageControlView.m
//  ScrollViewAndPageControl
//
//  Created by xiacheng on 16/4/1.
//  Copyright © 2016年 zjut. All rights reserved.
//

/*
 还存在一些问题，主要是用手滑动时的问题
 2016.7.18
 解决问题：修复了连续滑动时定时器重复添加的问题
 发现问题：<1> 快速滑动时会出现不能滑动的情况。
 
 */




#import "XXScrollAndPageView.h"
#define showInterval  3
#define animationInterval 1


@interface XXScrollAndPageView ()<UIScrollViewDelegate>
{
    UIScrollView    *_scrollView;
    UIPageControl   *_pageControl;
    NSInteger       _currentPage;
    NSTimer         *_autoShowTimer;
    UITapGestureRecognizer *_tapGesture;
    BOOL            _isDrag; //是否是自己拖动
    BOOL            _isReset;//是有重设器任务等待执行
    
    UIView *_firstView;
    UIView *_middleView;
    UIView *_lastView;
}
@end

@implementation XXScrollAndPageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = frame.size;
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _scrollView.contentSize = CGSizeMake(size.width * 3, size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor darkGrayColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, size.height - 30, size.width, 30)];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        _tapGesture.numberOfTapsRequired = 1;
        _tapGesture.numberOfTouchesRequired = 1;
        [_scrollView addGestureRecognizer:_tapGesture];
    }
    return self;
}

+ (instancetype)viewWithFrame:(CGRect)frame  ImageNames:(NSArray *)imageNames
{
    XXScrollAndPageView *view = [[XXScrollAndPageView alloc]initWithFrame:frame];
    [view setImageNames:imageNames];
    return view;
}

+ (instancetype)viewWithFrame:(CGRect)frame ImageNames:(NSArray *)imageNames urlArray:(NSArray *)urlArray
{
    XXScrollAndPageView *view = [self viewWithFrame:frame ImageNames:imageNames];
    [view setUrlArray:urlArray];
    return view;
}


//创建要显示的viewsArray
- (void)setImageViewArr:(NSArray<UIView *> *)imageViewArr
{
    if (_imageViewArr != imageViewArr) {
        _imageViewArr = imageViewArr;
        _currentPage = 0;
        _pageControl.numberOfPages = _imageViewArr.count;
        _isDrag = NO;
        [self reloadView];
    }
}


//通过imageNames 来创建views
- (void)setImageNames:(NSArray<NSString *> *)imageNames
{
    NSMutableArray *imageViewArr = [NSMutableArray array];
    for (int i=0; i<imageNames.count;i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:imageNames[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;//图片显示模式   //!!!这里可能会有问题
        [imageViewArr addObject:imageView];
    }
    [self setImageViewArr:[imageViewArr copy]];
}

//刷新界面调用的方法
- (void)reloadView
{
    //#warning  message "这里有隐患，如果_imageViewArr只有一个，会造成越界访问"
    [_firstView removeFromSuperview];
    [_middleView removeFromSuperview];
    [_lastView removeFromSuperview];
    
    
    if (_currentPage == 0) {
        _firstView = [_imageViewArr lastObject];
        _middleView = [_imageViewArr firstObject];
        _lastView = [_imageViewArr objectAtIndex:_currentPage +1];
    }else if(_currentPage == (_imageViewArr.count - 1))
    {
        _firstView = [_imageViewArr objectAtIndex:_currentPage - 1];
        _middleView = [_imageViewArr objectAtIndex:_currentPage];
        _lastView = [_imageViewArr firstObject];
    }else
    {
        _firstView = [_imageViewArr objectAtIndex:_currentPage -1];
        _middleView = [_imageViewArr objectAtIndex:_currentPage];
        _lastView = [_imageViewArr objectAtIndex:_currentPage +1];
    }
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _firstView.frame = CGRectMake(0, 0, width,height);
    _middleView.frame = CGRectMake(width, 0, width, height);
    _lastView.frame =  CGRectMake(width * 2, 0, width, height);
    
    [_scrollView addSubview:_firstView];
    [_scrollView addSubview:_middleView];
    [_scrollView addSubview:_lastView];
    
    _pageControl.currentPage = _currentPage;
    
//    NSLog(@"isDrag:%d",_isDrag);
    if (!_isDrag) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        //翻页的动画
        [UIView animateWithDuration:animationInterval animations:^{
            _scrollView.contentOffset = CGPointMake(width, 0);
        }];
    }else{
        _scrollView.contentOffset = CGPointMake(width, 0);
        _isDrag = NO;
    }
}

- (void)setShouldAutoShow:(BOOL)ShouldAutoShow
{
    if (_shouldAutoShow != ShouldAutoShow) {
        _shouldAutoShow = ShouldAutoShow;
    }
    
    if (ShouldAutoShow) {
        _autoShowTimer = [NSTimer scheduledTimerWithTimeInterval:showInterval target:self selector:@selector(autoShowTimerAction:) userInfo:nil repeats:YES];
    }else{
        if (_autoShowTimer.isValid)
        {
            [_autoShowTimer invalidate];
            _autoShowTimer = nil;
        }
    }
}

- (void)reSetAutoShowTimer
{
    NSLog(@"-----reSet-----");
    _autoShowTimer = [NSTimer scheduledTimerWithTimeInterval:showInterval target:self selector:@selector(autoShowTimerAction:) userInfo:nil repeats:YES];
    _isReset = NO;
}

- (void)autoShowTimerAction:(NSTimer *)timer
{
    _currentPage = (++_currentPage) % _imageViewArr.count;
    [self reloadView];
}

#pragma mark - <UIScorllViewDelegate>
//在drag 松开并减速完成时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isDrag = YES;
    if (self.shouldAutoShow) {
        
        if (_autoShowTimer.isValid) {
            [_autoShowTimer invalidate];
            _autoShowTimer = nil;
            NSLog(@"=====inValidate");
        }
        if (!_autoShowTimer) {
            if (!_isReset) {
                _isReset = YES;
                [self performSelector:@selector(reSetAutoShowTimer) withObject:nil afterDelay:1];
            }
        }
    }
    
//    NSLog(@"%@",_autoShowTimer);
    float x = _scrollView.contentOffset.x;
    CGFloat viewWidth = self.frame.size.width;
    //往前翻
    if (x <= viewWidth * 0.1) {
        if (_currentPage == 0) {
            _currentPage = _imageViewArr.count-1;
        }else{
            _currentPage --;
        }
    }
    
    //往后翻
    if (x >= viewWidth*1.9) {
        if (_currentPage ==_imageViewArr.count-1) {
            _currentPage = 0;
        }else{
            _currentPage ++;
        }
    }
    //    _pageControl.currentPage = _currentPage;
    [self reloadView];
}


- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(didTapScrollView:atIndex:)]) {
        [self.delegate didTapScrollView:self atIndex:_currentPage];
    }
    
    if ([self.delegate respondsToSelector:@selector(didTapScrollView:atIndex:withUrl:)]) {
        NSString *urlString;
        if (self.urlArray.count > _currentPage) {//保证数组不会越界
            urlString = self.urlArray[_currentPage];
        }else{
            urlString = nil;
        }
        [self.delegate didTapScrollView:self atIndex:_currentPage withUrl:urlString];
    }

}
@end
