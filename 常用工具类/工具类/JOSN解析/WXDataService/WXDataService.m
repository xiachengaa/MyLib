//
//  WXDataService.m
//  TimeMovie
//
//  Created by xiacheng on 15/12/11.
//  Copyright © 2015年 zjut. All rights reserved.
//

#import "WXDataService.h"

@implementation WXDataService

+ (id)requestDataWithJsonFileName:(NSString *)fileName
{
    //解析json数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:NULL];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    id jsonId = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    return jsonId;
}

@end
