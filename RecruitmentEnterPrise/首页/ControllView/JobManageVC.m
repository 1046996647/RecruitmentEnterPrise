//
//  JobManageVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobManageVC.h"
#import "JobCell.h"


@interface JobManageVC ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation JobManageVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-kTabBarHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24+13+24, 24)];
    [self.view addSubview:rightView];
    
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, rightView.height, rightView.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"105" selected:nil];
    [rightView addSubview:viewBtn];
    //    [viewBtn addTarget:self action:@selector(viewAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *setBtn = [UIButton buttonWithframe:CGRectMake(viewBtn.right+13, viewBtn.top, rightView.height, rightView.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"104" selected:@""];
    [rightView addSubview:setBtn];
    //    [setBtn addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    // 底部按钮
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-52-kTopHeight, kScreenWidth, 52)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    UIView *baseView1 = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-(105+5+222))/2, 6, 105+5+222, 40)];
    [baseView addSubview:baseView1];
    
    UIButton *delBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 105, 40) text:@"删除选中" font:SystemFont(16) textColor:@"#D0021B" backgroundColor:nil normal:@"" selected:nil];
    delBtn.layer.cornerRadius = 7;
    delBtn.layer.masksToBounds = YES;
    delBtn.layer.borderColor = [UIColor colorWithHexString:@"#CB4F5E"].CGColor;
    delBtn.layer.borderWidth = 1;
    [baseView1 addSubview:delBtn];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(delBtn.right+5, 0, 222, 40) text:@"发布新职位" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#CB4F5E" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [baseView1 addSubview:releseBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    return [self.dataArr count];
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return [self.dataArr[section] count];
    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    UILabel *label = [UILabel labelWithframe:CGRectMake(19, 7, kScreenWidth-19, 17) text:@"2017-08-24" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [view addSubview:label];
    
    return view;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    //    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
    //    cell.model = model;
    //    cell.selectArr = _selectArr;
    //    cell.selectJobArr = _selectJobArr;
    return cell;
}

@end
