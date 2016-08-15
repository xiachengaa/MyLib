//
//  EJTextField.m
//  EJTextField
//
//  Created by xiacheng on 16/5/6.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "EJTextField.h"

CGFloat const lineHeight = 1;

@interface EJTextField ()

{
    UIView *_lineView;
}

@end

@implementation EJTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-lineHeight, frame.size.width, lineHeight)];
        _lineView.backgroundColor = [UIColor colorWithRed:238/255.0f  green:238/255.0f blue:238/255.0f alpha:1];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(lineHeight);
        }];
    }
    return self;
}

- (void)awakeFromNib
{
    self.clipsToBounds = NO;
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-lineHeight, self.frame.size.width, lineHeight)];
    _lineView.backgroundColor = [UIColor colorWithRed:238/255.0f  green:238/255.0f blue:238/255.0f alpha:1];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(lineHeight);
    }];
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
        _lineView.backgroundColor = lineColor; 
    }
}

@end
