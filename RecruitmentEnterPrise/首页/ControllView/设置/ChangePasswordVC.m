//
//  ChangePasswordVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "AddContactCell.h"

@interface ChangePasswordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@{@"title":@"旧密码",@"placeTitle":@"请填写原密码",@"text":@"",@"key":@"passwd"},
                     @{@"title":@"新密码",@"placeTitle":@"请填写新密码",@"text":@"",@"key":@"passwdNew"},
                     @{@"title":@"确认密码",@"placeTitle":@"请确认新密码",@"text":@"",@"key":@"passwdNew"}
                     
                     ];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArr) {
        
        AddContactModel *model = [AddContactModel yy_modelWithJSON:dic];
        [arrM addObject:model];
        
    }
    
    self.dataArr = arrM;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];

    UILabel *nameLab = [UILabel labelWithframe:CGRectMake(22, 15, 58, 17) text:@"用户名：" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headerView addSubview:nameLab];
    
    // dayday
    UILabel *nameLab1 = [UILabel labelWithframe:CGRectMake(nameLab.right+5, 15, 58, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headerView addSubview:nameLab1];
    _tableView.tableHeaderView = headerView;
    nameLab1.text = self.model.cname;
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 46+40+46)];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, 46, kScreenWidth-50, 40) text:@"修改" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    [releseBtn addTarget:self action:@selector(upAction) forControlEvents:UIControlEventTouchUpInside];

    
    _tableView.tableFooterView = footerView;
    
    
}

- (void)upAction
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (AddContactModel *model in self.dataArr) {
        
        if (model.text.length == 0) {
            [self.view makeToast:@"您还有必填项未填写"];
            return;
        }

        [paramDic  setValue:model.text forKey:model.key];
        [arrM addObject:model.text];
    }
    
    if (![arrM[1] isEqualToString:arrM[2]]) {
        [self.view makeToast:@"密码不一致"];
        return;
        
    }
    
    
    NSLog(@"%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Alter_passwd dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    return [self.dataArr count];
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
    //    return 2;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[AddContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([self.title isEqualToString:@"修改密码"]) {
        cell.tf1.secureTextEntry = YES;
    }
    AddContactModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    //    cell.selectArr = _selectArr;
    //    cell.selectJobArr = _selectJobArr;
    return cell;
}

@end
