//
//  PeopleAloneView.m
//  DaDaGo
//
//  Created by xiacheng on 16/5/25.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "PeopleAloneView.h"

@interface PeopleAloneView ()
{
//    UIImageView *_grayView;
    UIImageView *_redView;
}

@end

@implementation  PeopleAloneView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self p_initSubViews];
    }
    return self;
}

- (void)awakeFromNib
{
    self.clipsToBounds = YES;
    [self p_initSubViews];
}

- (void)p_initSubViews
{
//    if (!_grayView) {
//        _grayView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_people_gray"]];
//        [self addSubview:_grayView];
//    }
    
    if (!_redView) {
        _redView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_people"]];
        [self addSubview:_redView];
    }
    
}


- (void)setPeopleNumber:(NSInteger)peopleNumber
{
    if (_peopleNumber != peopleNumber) {
        _peopleNumber = peopleNumber;
        NSInteger delayNum = 4 - peopleNumber;
        //        _redView.right = _grayView.left + (_peopleNumber / 4.0) * 114 + 14 * (_peopleNumber - 1);
        _redView.right = 18 * _peopleNumber + 14 * (_peopleNumber - 1);
        _redView.left = -(18+14) * delayNum;
    }
}

@end
