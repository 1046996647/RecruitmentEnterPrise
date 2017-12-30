//
//  ResumeSearchResultVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeSearchResultVC.h"
#import "ResumeSearchResultCell.h"
#import "EditResumeVC.h"
#import "InviteInterviewVC.h"

@interface ResumeSearchResultVC ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger pageNO;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,assign) BOOL isRefresh;
@property(nonatomic,strong) NSMutableArray *selectedArr;// 选择数组

@end

@implementation ResumeSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-40) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // 底部按钮
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.bottom, kScreenWidth, 40)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    UIButton *selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 100, 40) text:@"全选" font:SystemFont(14) textColor:@"#333333" backgroundColor:nil normal:@"" selected:nil];
    [baseView addSubview:selectBtn];
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

    
    CGFloat aWidth = kScreenWidth-selectBtn.width;
    
    UIButton *inviteBtn = [UIButton buttonWithframe:CGRectMake(selectBtn.right, 0, aWidth, selectBtn.height) text:@"批量邀请面试" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    [baseView addSubview:inviteBtn];
    [inviteBtn addTarget:self action:@selector(inviteAction) forControlEvents:UIControlEventTouchUpInside];

    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.modelArr.count > 0) {
            // 搜索职位
            [self searchAction];
        }
        
    }];
    
    self.pageNO = 1;
    self.modelArr = [NSMutableArray array];
    self.selectedArr = [NSMutableArray array];
    
    [self searchAction];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [_tableView reloadData];
}

- (void)inviteAction
{
    if (self.selectedArr.count == 0) {
        [self.view makeToast:@"请先选择简历"];
        
        return;
    }
    
    for (ResumeModel *model in self.selectedArr) {
        
        if (model.invite.integerValue == 0) {
            [self.view makeToast:@"选择的简历中有未查看过的简历"];
            
            return;
        }
        
    }
    
    InviteInterviewVC *vc = [[InviteInterviewVC alloc] init];
    vc.title = @"邀请面试";
    vc.selectedArr = self.selectedArr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectAction:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"全选"]) {
        [btn setTitle:@"全不选" forState:UIControlStateNormal];
        
        for (NSArray *arr in self.modelArr) {
            
            for (ResumeModel *model in arr) {
                
                model.isSelected = YES;
                
                if (![self.selectedArr containsObject:model]) {
                    [self.selectedArr addObject:model];
                }
            }

        }

    }
    else {
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        for (NSArray *arr in self.modelArr) {
            
            for (ResumeModel *model in arr) {
                model.isSelected = NO;
            }
            
        }
        [self.selectedArr removeAllObjects];

    }
    
    [_tableView reloadData];
}


- (void)searchAction
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    if ([self.searchType isEqualToString:@"advanced"]) {
        
        // 高级搜索
        if (self.searchText.length == 0) {
            [_dic setValue:@"" forKey:@"key"];
        }
        else {
            [_dic setValue:self.searchText forKey:@"key"];
            
        }
    }
    else {
        // 快速搜索

        [_dic setValue:self.searchText forKey:@"key"];

    }
    
    [_dic setValue:self.searchType forKey:@"searchType"];

    NSLog(@"%@",_dic);

    NSString *urlStr = [NSString stringWithFormat:@"%@p/%ld/size/10",Search_resume,self.pageNO];

    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:_dic showHUD:NO response:YES Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
//        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *arr = responseObject[@"data"];
        if ([arr count]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                
                NSMutableArray *arrM1 = [NSMutableArray array];
                ResumeModel *model = [ResumeModel yy_modelWithJSON:dic];
                [arrM1 addObject:model];
                [arrM addObject:arrM1];
            }

            [self.modelArr addObjectsFromArray:arrM];
            
            self.pageNO++;
        }
        else {
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
//        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.modelArr count];
//    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modelArr[section] count];
//    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ResumeModel *model = self.modelArr[indexPath.section][indexPath.row];

    EditResumeVC *vc = [[EditResumeVC alloc] init];
    vc.title = @"详情";
    vc.model1 = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
//    UILabel *label = [UILabel labelWithframe:CGRectMake(19, 7, kScreenWidth-19, 17) text:@"2017-08-24" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
//    [view addSubview:label];
    
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
    
    ResumeSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[ResumeSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.block = ^(ResumeModel *model) {
            if (model.isSelected) {
                [self.selectedArr addObject:model];
                
            }
            else {
                [self.selectedArr removeObject:model];
            }
            
        };
    }
    ResumeModel *model = self.modelArr[indexPath.section][indexPath.row];
    cell.model = model;
    //    cell.selectArr = _selectArr;
    //    cell.selectJobArr = _selectJobArr;
    return cell;
}

@end
