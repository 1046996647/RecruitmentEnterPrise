//
//  BaseMessageVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseMessageVC.h"
#import "EditHeadImgVC.h"

#import "AddContactCell.h"

@interface BaseMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation BaseMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@{@"title":@"招聘负责人",@"placeTitle":@"请填写招聘负责人",@"text":@"",@"key":@"key"},
                     @{@"title":@"法人代表（选填）",@"placeTitle":@"请填写法人代表",@"text":@"",@"key":@"key"},
                     @{@"title":@"联系电话",@"placeTitle":@"请填写联系电话",@"text":@"",@"key":@"key"},
                     @{@"title":@"传真号码（选填）",@"placeTitle":@"请填写传真号码",@"text":@"",@"key":@"key"},
                     @{@"title":@"公司地址",@"placeTitle":@"请填写公司地址",@"text":@"",@"key":@"key"},
                     @{@"title":@"公司网站（选填）",@"placeTitle":@"请填写公司网站",@"text":@"",@"key":@"key"},
                     @{@"title":@"所属行业",@"placeTitle":@"请选择所属行业",@"text":@"",@"key":@"key"},
                     @{@"title":@"公司性质",@"placeTitle":@"请选择公司性质",@"text":@"",@"key":@"key"}
                     
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    UIButton *userBtn = [UIButton buttonWithframe:CGRectMake((kScreenWidth-75)/2, 28, 75, 75) text:@"" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"Rectangle 14" selected:nil];
    userBtn.layer.cornerRadius = 10;
    userBtn.layer.masksToBounds = YES;
    [headerView addSubview:userBtn];
    [userBtn addTarget:self action:@selector(editImgAction) forControlEvents:UIControlEventTouchUpInside];

    
    UIImageView *edtImg = [UIImageView imgViewWithframe:CGRectMake(userBtn.width-15, userBtn.height-15, 15, 15) icon:@"41"];
    [userBtn addSubview:edtImg];

    
    UILabel *nameLab = [UILabel labelWithframe:CGRectMake(22, userBtn.bottom+44, 58, 17) text:@"公司名称" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headerView addSubview:nameLab];
    
    UILabel *nameLab1 = [UILabel labelWithframe:CGRectMake(kScreenWidth-200-22, nameLab.top, 200, 17) text:@"杭州晖鸿科技有限公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#666666"];
    [headerView addSubview:nameLab1];
    
    headerView.height = nameLab.bottom;
    _tableView.tableHeaderView = headerView;
    
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 46+40+46)];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, 46, kScreenWidth-50, 40) text:@"提交修改内容" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    _tableView.tableFooterView = footerView;// 请保存完善的信息
    
    
}

- (void)editImgAction
{
    EditHeadImgVC *vc  = [[EditHeadImgVC alloc] init];
    vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    //淡出淡入
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //  self.definesPresentationContext = YES; //不盖住整个屏幕
    vc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    [self presentViewController:vc animated:YES completion:nil];
    vc.clickBlock = ^(NSInteger indexRow) {
        
    };
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
        
    }
    AddContactModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    //    cell.selectArr = _selectArr;
    //    cell.selectJobArr = _selectJobArr;
    return cell;
}

@end
