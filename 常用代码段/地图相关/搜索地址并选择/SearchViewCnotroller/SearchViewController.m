//
//  SearchViewController.m
//  GaoDe-da0hang
//
//  Created by xiacheng on 16/4/19.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultTableViewCell.h"
#import "AppDelegate.h"


static NSString *resultCell = @"resultCell";
@interface SearchViewController ()<UITextFieldDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

{
    AMapSearchAPI *_search;
    NSString *_locationName;
    NSMutableArray *_dataArr;
    UITableView *_searchTableView;
    AMapTip *_choosedTip;
}
//@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UIButton *cityLabel;
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
- (IBAction)rightBtnAction:(UIButton *)sender;


@end

@implementation SearchViewController

+ (instancetype)searchViewController
{
    SearchViewController *searchVC = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    return searchVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.locationTF becomeFirstResponder];
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    _locationTF.delegate = self;
    [_locationTF addTarget:self  action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    _locationTF.placeholder = self.placeHolder;
    [self p_addBackGesture];
    [self initSearchTableView];
//    [self testData];
}

#pragma -mark init operations
- (void)initSearchTableView
{
    CGFloat y = 20+_cityLabel.height+10;
    _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, kScreenHeight - y) style:UITableViewStylePlain];
    _searchTableView.dataSource = self;
    _searchTableView.delegate = self;
    [_searchTableView registerNib:[UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:resultCell];
    [self.view addSubview:_searchTableView];
    _searchTableView.hidden = YES;
    //数据源数组的初始化
    _dataArr = [NSMutableArray array];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    if (placeHolder.length && placeHolder!= _placeHolder ) {
        _placeHolder = placeHolder;
//        self.locationTF.placeholder = placeHolder;
    }
}


- (void)p_addBackGesture
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureDidSwipe)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGesture];
        
//        UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureDidSwipe:)];
//        swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
//        [self.view addGestureRecognizer:swipeGestureLeft];

}

- (void)swipeGestureDidSwipe
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textChanged:(UITextField *)textField
{
//    NSLog(@"textField Change Characters");
    NSString *city = self.cityLabel.titleLabel.text;
    NSString *inputAdress = textField.text;
//    //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
//    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
//    geo.city = city;
//    geo.address = inputAdress;
//    //发起正向地理编码
//    [_search AMapGeocodeSearch: geo];
    
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = inputAdress;
    tipsRequest.city = city;
    
    [_search AMapInputTipsSearch:tipsRequest];
}

//- (void)testData
//{
//    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:40.00 longitude:117.00];
//    AMapNaviPoint *destPoint = [AMapNaviPoint locationWithLatitude:39.00 longitude:116.00];
//    _startLocatonBlock(startPoint);
//    _destLocationblock(destPoint);
//}

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


#pragma  -mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSLog(@"textField Change Characters");
//    NSString *city = self.cityLabel.titleLabel.text;
//    NSString *inputAdress = textField.text;
//    
//    //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
//    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
//    geo.city = city;
//    geo.address = inputAdress;
//    //发起正向地理编码
//    [_search AMapGeocodeSearch: geo];
//    return YES;    //这里返回YES则 change 一效，返回NOchange无效。
//}

#pragma -mark AMapSearchAPI delegate
//- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
//{
//    NSLog(@"responsed");
//    if(response.geocodes.count == 0)
//    {
//        return;
//    }
//    //通过AMapGeocodeSearchResponse对象处理搜索结果
//    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
//    NSString *strGeocodes = @"";
//    for (AMapTip *p in response.geocodes) {
//        strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %@", strGeocodes, p.description];
//    }
//    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];
//    NSLog(@"Geocode: %@", result);
//}

-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    NSMutableArray *tempArr = [NSMutableArray array];
    //当前位置的Tip
    AMapTip *curTip = [[AMapTip alloc]init];
    curTip.location = ((AppDelegate *)[UIApplication sharedApplication].delegate).userLocation;
    curTip.name = @"当前位置";
    curTip.district = @"当前位置";
    [tempArr addObject:curTip];
    
    for (AMapTip *aTip in response.tips) {
        if (aTip.uid.length && aTip.location) {
            [tempArr addObject:aTip];
        }
    }
    if (tempArr.count > 0) {
        _dataArr = tempArr;
        [_searchTableView reloadData];
        _searchTableView.hidden = NO;
    }else
    {
        _searchTableView.hidden = YES;
    }
    
//    @property (nonatomic, copy) NSString     *uid; //!< poi的id
//    @property (nonatomic, copy) NSString     *name; //!< 名称
//    @property (nonatomic, copy) NSString     *adcode; //!< 区域编码
//    @property (nonatomic, copy) NSString     *district; //!< 所属区域
//    @property (nonatomic, copy) AMapGeoPoint *location; //!< 位置
//    AMapTip *aTip = [response.tips lastObject];
//    NSLog(@"uid=%@\nname=%@\nadcode=%@\ndistrict=%@",aTip.uid,aTip.name,aTip.adcode,aTip.district);
    //通过AMapInputTipsSearchResponse对象处理搜索结果
//    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
//    NSString *strtips = @"";
//    for (AMapTip *p in response.tips) {
//        strtips = [NSString stringWithFormat:@"%@\nTip: %@", strtips, p.description];
//    }
    
//    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
//    NSLog(@"InputTips: %@", result);
}

#pragma -mark UITableView DataSouce 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resultCell forIndexPath:indexPath];
    cell.tip = _dataArr[indexPath.row];
    return cell;
}

#pragma -mark UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.view endEditing:YES];
    AMapTip *tip = _dataArr[indexPath.row];
//    self.locationTF.text = tip.name;
//    if (_locationBlock) {
//        AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:tip.location.latitude longitude:tip.location.longitude];
//        _locationBlock(point,tip.name);
//    }
    _choosedTip = tip;
//    [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    _searchTableView.hidden = YES;
    //传回参数并关闭页面
    if (_locationBlock) {
        AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_choosedTip.location.latitude longitude:_choosedTip.location.longitude];
        _locationBlock(point,_choosedTip.name);
    }else
    {
        NSLog(@"SearchViewController:_locationBlock not found!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}


    
    
//- (IBAction)rightBtnAction:(UIButton *)sender {
//    if ([sender.currentTitle isEqualToString:@"完成"]) {
//        if (_locationBlock) {
//        AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_choosedTip.location.latitude longitude:_choosedTip.location.longitude];
//        _locationBlock(point,_choosedTip.name);
//        }
//    }else
//    {
//        self.locationTF.text = @"";
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
    
@end
