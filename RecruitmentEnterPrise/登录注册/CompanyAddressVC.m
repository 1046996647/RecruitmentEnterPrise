//
//  CompanyAddressVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/23.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CompanyAddressVC.h"
#import "NearbyAddressCell.h"
#import "AddressSearchVC.h"


#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface CompanyAddressVC ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKMapViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) BMKMapView *mapView;//地图视图
@property (nonatomic,strong) BMKLocationService *locService;//定位服务
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UITextField *addTF;
@property(nonatomic,strong) UITextField *detailTF;
@property(nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) BMKUserLocation *userLocation;
@property (nonatomic, strong) UIImageView *pinView;



@end

@implementation CompanyAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    baseView.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    [self.view addSubview:baseView];
    
    // 杭州
    UIButton *addBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 70, baseView.height) text:@"" font:SystemFont(12) textColor:@"#FFFFFF" backgroundColor:nil normal:@"72" selected:nil];
//    _viewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [baseView addSubview:addBtn];
    self.addBtn = addBtn;
    
//    CGFloat wdith = (kScreenWidth-10-70)/2;
    
    // 搜索框
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView0 = [UIImageView imgViewWithframe:CGRectMake(0, 0, leftView1.width, 16) icon:@"71"];
    imgView0.contentMode = UIViewContentModeScaleAspectFit;
    imgView0.center = leftView1.center;
    
    [leftView1 addSubview:imgView0];
    
    _addTF = [UITextField textFieldWithframe:CGRectMake(75, (baseView.height-30)/2, kScreenWidth-20-75, 30) placeholder:@"查找写字楼等" font:[UIFont systemFontOfSize:14] leftView:leftView1 backgroundColor:@"#FFFFFF"];
    [_addTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_addTF setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    _addTF.layer.cornerRadius = _addTF.height/2;
    _addTF.layer.masksToBounds = YES;
//    _addTF.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:_addTF];
    _addTF.text = @"";

    // 替代
    UIButton *addTFBtn = [UIButton buttonWithframe:_addTF.bounds text:nil font:nil textColor:nil backgroundColor:nil normal:nil selected:nil];
    [_addTF addSubview:addTFBtn];
    [addTFBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];

    
//    // 门牌号
//    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
//    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
//
//    imgView0 = [UIImageView imgViewWithframe:CGRectMake(0, 0, leftView1.width, 16) icon:@"70"];
//    imgView0.contentMode = UIViewContentModeScaleAspectFit;
//    imgView0.center = leftView1.center;
//
//    [leftView1 addSubview:imgView0];
//
//    _detailTF = [UITextField textFieldWithframe:CGRectMake(_addTF.right+5, (baseView.height-30)/2, wdith, 30) placeholder:@"输入楼号-门牌号" font:[UIFont systemFontOfSize:14] leftView:leftView1 backgroundColor:@"#FFFFFF"];
//    [_detailTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
//    [_detailTF setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
//    _detailTF.layer.cornerRadius = _detailTF.height/2;
//    _detailTF.layer.masksToBounds = YES;
//    [baseView addSubview:_detailTF];
    
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 17)];
    
    UIButton *viewBtn = [UIButton buttonWithframe:rightView.bounds text:@"保存" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [rightView addSubview:viewBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [viewBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 地图
    //初始化地图
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, baseView.bottom, kScreenWidth, 300*scaleWidth)];
    //底图poi标注
    self.mapView.zoomLevel = 15; // 这是定位图标的大小
    [self.view addSubview:self.mapView];
    
    // 大头针
    UIImageView *pinView = [UIImageView imgViewWithframe:CGRectMake(0, (_mapView.height-30)/2-15, _mapView.width, 30) icon:@"69"];
    pinView.contentMode = UIViewContentModeScaleAspectFit;
    [_mapView addSubview:pinView];
    self.pinView = pinView;
    
    //自定义精度圈
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.isAccuracyCircleShow = NO;
    [_mapView updateLocationViewWithParam:param];

    // 隐藏左下角百度地图logo
    UIView *mView = _mapView.subviews.firstObject;
    for (id logoView in mView.subviews)  {
        
        if ([logoView isKindOfClass:[UIImageView class]])      {
            
            UIImageView *b_logo = (UIImageView*)logoView;
            
            b_logo.hidden = YES;
            
        }
        
    }
    
    // 定位图片
    UIButton *locationBtn = [UIButton buttonWithframe:CGRectMake(7, _mapView.height-31-7, 31, 31) text:nil font:nil textColor:nil backgroundColor:nil normal:@"73" selected:nil];
    [_mapView addSubview:locationBtn];
    [locationBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 反检索
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //    _geocodesearch.delegate = self;
    
    
    //初始化BMKLocationService定位服务
    _locService = [[BMKLocationService alloc]init];
    //    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    // 表视图
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, _mapView.bottom, kScreenWidth, kScreenHeight-kTopHeight-_mapView.bottom) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;

    
}

- (void)saveAction
{
//    NSString *address = [NSString stringWithFormat:@"%@%@%@",self.addBtn.currentTitle, self.addTF.text, self.detailTF.text];
    NSString *address = [NSString stringWithFormat:@"%@%@",self.addBtn.currentTitle, self.addTF.text];

    if (self.block) {
        self.block(address);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAction
{
    AddressSearchVC *vc = [[AddressSearchVC alloc] init];
    vc.userLocation = self.userLocation;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^(NSString *text) {
        
        self.addTF.text = text;
        [self saveAction];
    };
}

// 重新定位
- (void)locationAction
{
    [_locService startUserLocationService];
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    [_locService stopUserLocationService];//定位完成停止位置更新(导致反检索失败)
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.userLocation = userLocation;
    
    //展示定位
    self.mapView.showsUserLocation = YES;
    
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    
    //获取用户的坐标
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
//    //初始化一个点的注释 //只有三个属性
//    BMKPointAnnotation *annotoation = [[BMKPointAnnotation alloc] init];
//
//    //坐标
//    annotoation.coordinate = userLocation.location.coordinate;
//
//    //title
////    annotoation.title = info.name;
//
//    //子标题
////    annotoation.subtitle = info.address;
//
//    //将标注添加到地图上
//    [self.mapView addAnnotation:annotoation];
    

    //地理反编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
        NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
        NSLog(@"反geo检索发送失败");
        
    }
}


#pragma mark -------------地理反编码的delegate---------------

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error

{
    NSLog(@"%@----%i",result,error);
    
    if (result) {
        
        // 定位
        [self.addBtn setTitle:result.addressDetail.city forState:UIControlStateNormal];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (BMKPoiInfo *poiInfo in result.poiList) {
            [arrM addObject:poiInfo];
        }
        self.dataArr = arrM;
        [_tableView reloadData];
    }
    else {
        
        [self.addBtn setTitle:@"定位失败" forState:UIControlStateNormal];
    }
    
    
    //addressDetail:     层次化地址信息
    
    //address:    地址名称
    
    //businessCircle:  商圈名称
    
    // location:  地址坐标
    
    //  poiList:   地址周边POI信息，成员类型为BMKPoiInfo
    
    //    for (BMKPoiInfo *info in result.poiList) {
    //        NSLog(@"address:%@----%@",info.name,info.address);
    //
    //    }
    
}

#pragma mark -------------BMKMapViewDelegate
/**
 *地图区域改变完成后会调用此接口
 *@param mapView 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [UIView animateWithDuration:.25 animations:^{
        self.pinView.top = self.pinView.top-15;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.25 animations:^{
            self.pinView.top = (_mapView.height-30)/2-15;
            
        }];
    }];
    
    //地理反编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = mapView.centerCoordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
        NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
        NSLog(@"反geo检索发送失败");
        
    }
}
// 该方法定位图片会把大头针盖住
///**
// *根据anntation生成对应的View
// *@param mapView 地图View
// *@param annotation 指定的标注
// *@return 生成的标注View
// */
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
//
//    //如果是注释点
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//
//        //根据注释点,创建并初始化注释点视图
//        BMKPinAnnotationView  *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"an"];
//
//        //设置大头针的颜色
////        newAnnotation.pinColor = BMKPinAnnotationColorRed;
//        newAnnotation.centerOffset = CGPointMake(0, -(newAnnotation.frame.size.height*0.6));
////        newAnnotation.image = [UIImage imageNamed:@"Group1"];   //把大头针换成别的图片
//        //设置动画
//        newAnnotation.animatesDrop = YES;
//        newAnnotation.annotation = annotation;
//        return newAnnotation;
//
//    }
//
//    return nil;
//}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BMKPoiInfo *poiInfo = self.dataArr[indexPath.row];
    self.addTF.text = poiInfo.name;

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearbyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[NearbyAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    BMKPoiInfo *poiInfo = self.dataArr[indexPath.row];
    cell.textLab.text = poiInfo.name;
    cell.detailLab.text = poiInfo.address;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
