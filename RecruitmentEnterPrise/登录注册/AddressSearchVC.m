//
//  AddressSearchVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/24.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AddressSearchVC.h"
#import "NearbyAddressCell.h"


#import <BaiduMapAPI_Search/BMKPoiSearch.h>


@interface AddressSearchVC ()<BMKPoiSearchDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UITextField *addTF;
@property (nonatomic,strong) BMKPoiSearch *poiSearch;//搜索服务
@property (nonatomic,strong) NSArray *dataArr;


@end

@implementation AddressSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight)];
    baseView.backgroundColor = colorWithHexStr(@"#D0021B");
    [self.view addSubview:baseView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_back_normal"] forState:UIControlStateNormal];
    button.frame = CGRectMake(17, kStatusBarHeight+(kNavBarHeight-20)/2, 30, 20);
    //        button.backgroundColor = [UIColor greenColor]
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:button];
    
    // 搜索框
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView0 = [UIImageView imgViewWithframe:CGRectMake(0, 0, leftView1.width, 16) icon:@"71"];
    imgView0.contentMode = UIViewContentModeScaleAspectFit;
    imgView0.center = leftView1.center;
    
    [leftView1 addSubview:imgView0];
    
    _addTF = [UITextField textFieldWithframe:CGRectMake(40, kStatusBarHeight+(kNavBarHeight-30)/2, kScreenWidth-40-54, 30) placeholder:@"查找写字楼等" font:[UIFont systemFontOfSize:14] leftView:leftView1 backgroundColor:@"#FFFFFF"];
    [_addTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_addTF setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    _addTF.layer.cornerRadius = _addTF.height/2;
    _addTF.layer.masksToBounds = YES;
    [baseView addSubview:_addTF];
    _addTF.delegate = self;
    _addTF.returnKeyType = UIReturnKeySearch;
    [_addTF addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventEditingChanged];


    // 右上角按钮
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(_addTF.right, _addTF.center.y-6.5, 54, 17) text:@"搜索" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [baseView addSubview:viewBtn];
    [viewBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];

    
    // 表视图
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, baseView.bottom, kScreenWidth, kScreenHeight-baseView.bottom) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //初始化搜索
    self.poiSearch =[[BMKPoiSearch alloc] init];


}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.poiSearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.poiSearch.delegate = nil; // 不用时，置nil

}

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
    if (self.block) {
        self.block(poiInfo.name);
    }
    [self.navigationController popViewControllerAnimated:YES];

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

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchAction
{
//    if (_addTF.text.length == 0) {
//        [_addTF resignFirstResponder];
//
//        return;
//    }
//
//    [_addTF resignFirstResponder];
    
    [SVProgressHUD show];
    
    //初始化一个周边云检索对象
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
    //索引 默认为0
    option.pageIndex = 0;
    //页数默认为10
    option.pageCapacity = 50;
    //检索的中心点，经纬度
    option.location = self.userLocation.location.coordinate;
    //搜索的关键字
    option.keyword = _addTF.text;
    
    //根据中心点、半径和检索词发起周边检索
    BOOL flag = [self.poiSearch poiSearchNearBy:option];
    if (flag) {
        NSLog(@"搜索成功");
        [SVProgressHUD dismiss];
    }
    else {
        
        NSLog(@"搜索失败");
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchAction];
    
    return YES;
}

#pragma mark -------BMKPoiSearchDelegate
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    
    //若搜索成功
    if (errorCode ==BMK_SEARCH_NO_ERROR) {
        
        NSMutableArray *arrM = [NSMutableArray array];

        //POI信息类
        //poi列表
        for (BMKPoiInfo *info in poiResult.poiInfoList) {
            
            [arrM addObject:info];
            
        }
        self.dataArr = arrM;
        [self.tableView reloadData];
    }
    
    
}

/**
 *返回POI详情搜索结果
 *@param searcher 搜索对象
 *@param poiDetailResult 详情搜索结果
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode {
    
    NSLog(@"%@",poiDetailResult.name);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
