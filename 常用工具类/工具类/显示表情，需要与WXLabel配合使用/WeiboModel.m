//
//  WeiboModel.m
//  84班微博
//
//  Created by wenyuan on 1/13/16.
//  Copyright © 2016 george. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"
#import "AppDelegate.h"

@interface WeiboModel ()

@end
@implementation WeiboModel


- (void)setText:(NSString *)text
{
    //1、创建正则表达式
    NSString *regex = @"\\[\\w+\\]";
    //2、检索符合要求的文字并记录位置
    NSArray *arr = [text componentsMatchedByRegex:regex];
     //3、找到对应的imageName
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *itemArr = [NSArray arrayWithContentsOfFile:path];
    
    for (NSString *faceText  in arr) {
       NSString *preStr = [NSString stringWithFormat:@"chs='%@'",faceText];
       NSPredicate *pre = [NSPredicate predicateWithFormat:preStr];
       NSArray *items = [itemArr filteredArrayUsingPredicate:pre];
        
       NSArray *_resultArr;
        
        if (items.count > 0) {
        //通过安装包中的表情资源加载
            NSDictionary *faceDic = [items firstObject];
            NSString *imageName = faceDic[@"png"];
            NSString *formatImageName = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            text = [text stringByReplacingOccurrencesOfString:faceText withString:formatImageName];
        }else{
            
            //通过documents 中的表情包加载
            if (_resultArr == nil) {
                NSString *resultPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/emotions/result.plist"];
                _resultArr = [NSArray arrayWithContentsOfFile:resultPath];
                
            }
            NSString *preStrByRes = [NSString stringWithFormat:@"value='%@'",faceText];
            NSPredicate *preByRes = [NSPredicate predicateWithFormat:preStrByRes];
            NSArray *result = [_resultArr filteredArrayUsingPredicate:preByRes];
            
           if (result.count > 0) {
               NSDictionary *faceDicByRes = [result firstObject];
               NSString *url = [faceDicByRes objectForKey:@"url"];
               NSArray *strArr = [url componentsSeparatedByString:@"/"];
               NSString *imageNameByRes = [strArr lastObject];
               NSString *formatImageNameByRes = [NSString stringWithFormat:@"<image url = '%@'>",imageNameByRes];
                text = [text stringByReplacingOccurrencesOfString:faceText withString:formatImageNameByRes];
           }else{
               NSLog(@"没有在result 文件中找到");
           }
        }
       
    }
    _text = text;
}






@end
