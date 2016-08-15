//
//  SearchViewController.h
//  GaoDe-da0hang
//
//  Created by xiacheng on 16/4/19.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^PassLocationBlock)(AMapGeoPoint *, NSString *);

@interface SearchViewController : UIViewController

@property (nonatomic,strong) NSString *placeHolder;//textField 的placeHolder


//@property (nonatomic,copy) PassLocationBlock startLocatonBlock;
//@property (nonatomic,copy) PassLocationBlock destLocationblock;

@property (nonatomic,copy)  PassLocationBlock locationBlock;

+ (instancetype)searchViewController;

@end
