//
//  EJDecRound.m
//  EJTextField
//
//  Created by xiacheng on 16/7/6.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "EJDecRound.h"

@implementation EJDecRound

+ (NSNumber *)Rounding:( float )price afterPoint:( int )position RoundingMode:(NSRoundingMode)roundingMode
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:position raiseOnExactness: NO  raiseOnOverflow: NO  raiseOnUnderflow: NO  raiseOnDivideByZero: NO ];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return  roundedOunces;
}


@end
