//
//  PeoPleShowView.m
//  DaDaGo
//
//  Created by xiacheng on 16/5/15.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "PeoPleShowView.h"
#import "EJDecRound.h"

@implementation PeoPleShowView
{
    UIImageView *_grayView;
    UIImageView *_redView;
}

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
    if (!_grayView) {
        _grayView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_people_gray"]];
        [self addSubview:_grayView];
    }
    
    if (!_redView) {
        _redView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_people"]];
        [self addSubview:_redView];
    }
    
}


- (void)setPeopleNumber:(NSInteger )peopleNumber
{
//    if (_peopleNumber != peopleNumber) {
        _peopleNumber = peopleNumber;
//        _redView.right = _grayView.left + (_peopleNumber / 4.0) * 114 + 14 * (_peopleNumber - 1);
        _redView.right = 18 * _peopleNumber + 14 * (_peopleNumber - 1);
//    }
}

//- (void)setTotalNumber:(NSInteger)totalNumber
//{
//    _totalNumber = totalNumber;
//    self.width = 18 * totalNumber + 14 * (totalNumber - 1);
//    [self layoutIfNeeded];
//}
//

@end
