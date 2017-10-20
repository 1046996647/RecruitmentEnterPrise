//
//  AddContactVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AddContactVC.h"
#import "AddContactCell.h"

@interface AddContactVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation AddContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@{@"title":@"姓名",@"placeTitle":@"请填写姓名",@"text":@"",@"key":@"key"},
                     @{@"title":@"E-mail（选填）",@"placeTitle":@"请填写E-mail",@"text":@"",@"key":@"key"},
                     @{@"title":@"电话",@"placeTitle":@"请填写联系电话",@"text":@"",@"key":@"key"},
                     @{@"title":@"传真（选填）",@"placeTitle":@"请填写传真号码",@"text":@"",@"key":@"key"},
                     @{@"title":@"公司地址",@"placeTitle":@"请填写公司地址",@"text":@"",@"key":@"key"}
                     
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
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 87+40+83)];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, 87, kScreenWidth-50, 40) text:@"增加" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    _tableView.tableFooterView = footerView;
    
    if ([self.title isEqualToString:@"修改联系人"]) {
        [releseBtn setTitle:@"修改" forState:UIControlStateNormal];
    }
    
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
