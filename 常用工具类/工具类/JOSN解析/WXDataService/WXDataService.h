//
//  WXDataService.h
//  TimeMovie
//
//  Created by xiacheng on 15/12/11.
//  Copyright © 2015年 zjut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXDataService : NSObject

/**
 从文件名为fileName 的JSON文件中读取数据，并以id参数返回
 
 @param fileName JSON文件的文件名，必须包含扩展名.json
 
 @return id类型的值
 */
+ (id)requestDataWithJsonFileName:(NSString *)fileName;

@end
