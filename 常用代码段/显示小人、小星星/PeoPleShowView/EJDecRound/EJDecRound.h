//
//  EJDecRound.h
//  EJTextField
//
//  Created by xiacheng on 16/7/6.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJDecRound : NSObject

+ (NSString *)Rounding:( float )price afterPoint:( int )position RoundingMode:(NSRoundingMode)roundingMode
;


@end
