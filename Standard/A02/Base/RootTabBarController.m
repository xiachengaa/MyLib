//
//  RootTabBarController.m
//  DaDaGo
//
//  Created by xiacheng on 16/4/27.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "RootTabBarController.h"
#import "PublishViewController.h"
#import "MsgShowViewController.h"
#import "MineTableViewController.h"
#import "MineNaviController.h"


@interface RootTabBarController ()
{
    CGFloat _barHeight;
}

@property (nonatomic, strong) UIView *maskView;
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [NSThread sleepForTimeInterval:3];//延时3s
    [self p_addViewControllers];
    [self p_initBarHeight];
    [self p_createTabBar];
//    [self p_addGestures];
    // Do any additional setup after loading the view.
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 83, 3)];
        _maskView.backgroundColor = [UIColor whiteColor];
    }
    return _maskView;
}

- (void)p_initBarHeight
{
    if (kScreenHeight <= 667) {
        _barHeight = 44;
    }else{
        _barHeight = 46;
    }
}

- (void)p_addGestureToViewController:(UIViewController *)vc
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureDidSwipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [vc.view addGestureRecognizer:swipeGesture];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureDidSwipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [vc.view addGestureRecognizer:swipeGestureLeft];
}


- (void)p_addViewControllers
{
    //1. PublishMsg VC
    PublishViewController *publishVC = [[PublishViewController alloc]init];

//    MineNaviController *navi = [[MineNaviController alloc]initWithRootViewController:publishVC];
    [self p_addGestureToViewController:publishVC];
    //2. MsgShow VC
    MineNaviController  *msgShowNaviVC = [[UIStoryboard storyboardWithName:@"MsgShow" bundle:nil]instantiateInitialViewController];
    
    //3. Mine VC
    MineNaviController *mineNaviVC = (MineNaviController *)[[UIStoryboard storyboardWithName:@"MineViewController" bundle:nil] instantiateInitialViewController];
    self.viewControllers = @[publishVC,msgShowNaviVC,mineNaviVC];
}

- (void)p_createTabBar
{
    CGFloat itemWidth = kScreenWidth / 3.0;
    CGFloat tabBarHeight = _barHeight;//为了与navigationBar 的高度保持一致
    self.tabBar.hidden = YES;
    
    _tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, tabBarHeight)];
    _tabBarView.backgroundColor = kBgColor;
    [self.view addSubview:_tabBarView];
    
    
    NSArray *titleArr = @[@"即刻",
                          @"嗒嗒",
                          @"我"];
    //添加按钮
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(itemWidth * i,0, itemWidth, tabBarHeight);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(p_tabBarClicked:) forControlEvents:UIControlEventTouchUpInside];
        //设置初始化时maskView 的位置
        if (i == 0) {
            self.maskView.center = btn.center;
            self.maskView.bottom = btn.bottom;
        }
        [_tabBarView addSubview:btn];
    }
    
    [_tabBarView addSubview:self.maskView];// 把maskView添加到tabBarView 上去，由于图层的位置关系，要后添加
    
    //设置status bar  的背景
    UIView *statusBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    statusBack.backgroundColor = kBgColor;
    [self.view addSubview:statusBack];
}



- (void)p_removeUITabBarButton
{
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}

- (void)p_tabBarClicked:(UIButton *)btn
{
    NSInteger index = btn.tag - 1000;
    self.selectedIndex = index;
//    NSLog(@"currentView%@",self.view);
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.maskView.center = btn.center;
        weakSelf.maskView.bottom = btn.bottom;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)swipeGestureDidSwipe:(UISwipeGestureRecognizer *)gesture
{
//    NSLog(@"--------Swipped:%lu",(unsigned long)gesture.direction);
    NSInteger curentIndex;
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft &&
        self.selectedIndex < 2) {
        self.selectedIndex = self.selectedIndex + 1;
        curentIndex = self.selectedIndex;
        UIButton *btn = [_tabBarView viewWithTag:(1000 + curentIndex)];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.maskView.center = btn.center;
            weakSelf.maskView.bottom = btn.bottom;
        }];
        
    }else if(gesture.direction == UISwipeGestureRecognizerDirectionRight &&
             self.selectedIndex > 0)
    {
        self.selectedIndex = self.selectedIndex - 1;
        curentIndex = self.selectedIndex;
        UIButton *btn = [_tabBarView viewWithTag:(1000 + curentIndex)];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.maskView.center = btn.center;
            weakSelf.maskView.bottom = btn.bottom;
        }];
    }
}

- (void)goToFirstView
{
    self.selectedIndex = 0;
    UIButton *btn = [_tabBarView viewWithTag:(1000+0)];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.maskView.center = btn.center;
        weakSelf.maskView.bottom = btn.bottom;
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.selectedViewController preferredStatusBarStyle];
}
@end
