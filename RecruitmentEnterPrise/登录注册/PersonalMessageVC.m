//
//  MessageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalMessageVC.h"
#import "PersonalMessageCell.h"

@interface PersonalMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSArray *selectJobArr;

@end

@implementation PersonalMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@[@{@"image":@"80",@"title":@"公司名称",@"key":@"title"},
                       @{@"image":@"79",@"title":@"招聘负责人",@"key":@"contactName"},
                       @{@"image":@"78",@"title":@"联系电话",@"key":@"tele"}],
                     @[@{@"image":@"77",@"title":@"点击获取公司地址",@"key":@"address"},
                       @{@"image":@"76",@"title":@"所属行业",@"key":@"cateId"},
                       @{@"image":@"75",@"title":@"公司性质",@"key":@"type"}],
                     @[@{@"image":@"74",@"title":@"公司简介",@"key":@"info"}]
                     ];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSArray *arr in self.dataArr) {
        
        NSMutableArray *arrM1 = [NSMutableArray array];

        for (NSDictionary *dic in arr) {
            
            PersonModel *model = [PersonModel yy_modelWithJSON:dic];
            [arrM1 addObject:model];
        }
        
        [arrM addObject:arrM1];

    }
    
    self.dataArr = arrM;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 41*2+20)];
    UIButton *upBtn = [UIButton buttonWithframe:CGRectMake(25, 41, kScreenWidth-50, 35) text:@"提交" font:[UIFont systemFontOfSize:13] textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:nil selected:nil];
    upBtn.layer.cornerRadius = 7;
    upBtn.layer.masksToBounds = YES;
    [footerView addSubview:upBtn];
    [upBtn addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];

    
    _tableView.tableFooterView = footerView;
    
    // 选择项数据
    NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
    self.selectArr = selectArr;
    
    NSArray *selectJobArr = [InfoCache unarchiveObjectWithFile:SelectItemJob];;
    self.selectJobArr = selectJobArr;

}

- (void)upAction:(UIButton *)btn
{
    [self.view endEditing:YES];

    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];

    for (NSArray *arr in self.dataArr) {
        
        for (PersonModel *model in arr) {
            
            if (model.text.length == 0) {
                [self.view makeToast:@"您还有内容未填写完整"];
                return;
            }
            
            [paramDic  setValue:model.text forKey:model.key];

        }
        
    }
    
    NSLog(@"%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Add_company_info dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
//        // 登录通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginNotification" object:self.title];
        
        [self.navigationController popToRootViewControllerAnimated:YES];

        
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationItem.leftBarButtonItem.customView.hidden = NO;

    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.section == 0) {
//        
//    }
//    if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//
//        }
//    }
//    if (indexPath.section == 2) {
//        
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
//    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;// 为0无效
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[PersonalMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    }
    PersonModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    cell.selectArr = self.selectArr;
    cell.selectJobArr = self.selectJobArr;
    return cell;
}



@end
