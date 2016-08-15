//
//  ViewController.m
//  DatePicker
//
//  Created by MagicBeans2 on 16/3/25.
//  Copyright © 2016年 North. All rights reserved.
//

#import "ViewController.h"
#import "MBDatePicker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)Show:(id)sender {
    
    [[[MBDatePicker alloc]initWithBlock:^(id data) {
        
        NSLog(@"%@",data);
        
        
    }]show];
    
    
}





@end
