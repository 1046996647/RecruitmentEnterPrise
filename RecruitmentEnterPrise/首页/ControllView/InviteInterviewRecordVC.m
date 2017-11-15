//
//  InviteInterviewVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "InviteInterviewRecordVC.h"
#import "ResumeReceiveCell.h"
#import "ZFTableViewCell.h"
#import "InviteInterviewVC.h"
#import "EditResumeVC.h"
#import "ReleaseJobModel.h"
#import "BRPickerView.h"

@interface InviteInterviewRecordVC ()<UITableViewDelegate,UITableViewDataSource,ZFTableViewCellDelegate>

//@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger pageNO;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,assign) BOOL isRefresh;
@property(nonatomic,strong) NSMutableArray *selectedArr;// 选择数组

@property (nonatomic,strong) NSArray *jobArr;
@property (nonatomic,assign) BOOL isShow;

@end

@implementation InviteInterviewRecordVC

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
    
    
    //    CGFloat aWidth = (kScreenWidth-selectBtn.width)/2;
        UIButton *delBtn = [UIButton buttonWithframe:CGRectMake(selectBtn.right, 0, kScreenWidth-selectBtn.right, selectBtn.height) text:@"删除选中" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:@"#999999" normal:@"" selected:nil];
        [baseView addSubview:delBtn];
        [delBtn addTarget:self action:@selector(delAction) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIButton *inviteBtn = [UIButton buttonWithframe:CGRectMake(selectBtn.right, 0, kScreenWidth-selectBtn.right, selectBtn.height) text:@"批量邀请面试" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
//    [baseView addSubview:inviteBtn];
//    [inviteBtn addTarget:self action:@selector(inviteAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 58, 17)];
    
    UIButton *viewBtn = [UIButton buttonWithframe:rightView.bounds text:@"职位分类" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [rightView addSubview:viewBtn];
    [viewBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    [self get_position];
    
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self headerRefresh];
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.modelArr.count > 0) {
            // 搜索职位
            [self get_company_invite];
        }
        
    }];
    
    self.pageNO = 1;
    self.modelArr = [NSMutableArray array];
    self.selectedArr = [NSMutableArray array];
    
    [self get_company_invite];
    
}

- (void)selectAction
{
    _isShow = YES;
    if (self.jobArr.count > 0) {
        NSMutableArray *arrM = [NSMutableArray array];
        [arrM addObject:@"不限"];
        for (ReleaseJobModel *model in self.jobArr) {
            
            [arrM addObject:model.title];
        }
        [BRStringPickerView showStringPickerWithTitle:nil dataSource:arrM defaultSelValue:arrM[0] isAutoSelect:NO resultBlock:^(id selectValue) {
            
            self.positionType = selectValue;

            
        }];
    }
    else {
        [self get_position];
        
    }
    
    
}

- (void)get_position
{
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_position dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            ReleaseJobModel *model = [ReleaseJobModel yy_modelWithDictionary:dic];
            [arrM addObject:model];
        }
        self.jobArr = arrM;
        
        if (self.jobArr.count > 0 && _isShow) {
            NSMutableArray *arrM = [NSMutableArray array];
            [arrM addObject:@"不限"];
            for (ReleaseJobModel *model in self.jobArr) {
                
                [arrM addObject:model.title];
            }
            [BRStringPickerView showStringPickerWithTitle:nil dataSource:arrM defaultSelValue:arrM[0] isAutoSelect:NO resultBlock:^(id selectValue) {
                
                self.positionType = selectValue;

                
            }];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
}

- (void)headerRefresh
{
    self.pageNO = 1;
    if (self.modelArr.count > 0) {
        [self.modelArr removeAllObjects];
        
    }
    [self get_company_invite];
}

- (void)get_company_invite
{
    
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@p/%ld",Get_company_invite,self.pageNO];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    if (self.positionType) {
        [paramDic setValue:self.positionType forKey:@"positionType"];
        
    }
    else {
        [paramDic setValue:@"不限" forKey:@"positionType"];
        
    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paramDic showHUD:NO response:YES Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
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
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)delAction
{

    if (self.selectedArr.count == 0) {

        [self.view makeToast:@"请先选择简历"];
        return;
    }


    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];

    NSMutableArray *idArr = [NSMutableArray array];
    for (ResumeModel *model in self.selectedArr) {
        [idArr addObject:model.inviteId];

    }
    NSString *string = [idArr componentsJoinedByString:@","]; //,为分隔符
    [paraDic setValue:string forKey:@"inviteId"];

    [AFNetworking_RequestData requestMethodPOSTUrl:Delete_invite dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
        self.isRefresh = NO;
        [self headerRefresh];


    } failure:^(NSError *error) {


    }];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)inviteAction
//{
//    if (self.selectedArr.count == 0) {
//        [self.view makeToast:@"请先选择简历"];
//
//        return;
//    }
//    InviteInterviewVC *vc = [[InviteInterviewVC alloc] init];
//    vc.title = @"邀请面试";
//    vc.selectedArr = self.selectedArr;
//    [self.navigationController pushViewController:vc animated:YES];
//    vc.block = ^{
//
//        //        [self.selectedArr removeAllObjects];
//        for (NSArray *arr in self.modelArr) {
//
//            for (ResumeModel *model in arr) {
//
//                model.jobstatus = @"3";
//
//            }
//
//        }
//
//
//        [_tableView reloadData];
//    };
//}

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

- (void)setPositionType:(NSString *)positionType
{
    _positionType = positionType;
    self.isRefresh = NO;
    [self headerRefresh];
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
    
    if (model.is_hide.boolValue) {
        [self.view makeToast:@"该用户的简历已被隐藏"];
        return;
    }
    
    if (model.jobstatus.integerValue == 1) {
        model.jobstatus = @"2";
        
    }
    EditResumeVC *vc = [[EditResumeVC alloc] init];
    vc.title = @"详情";
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    UILabel *label = [UILabel labelWithframe:CGRectMake(19, 7, kScreenWidth-19, 17) text:@"2017-08-24" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [view addSubview:label];
    
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
    
    static NSString* identity = @"FDFeedCell";
    
    ResumeReceiveCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        
        cell = [[ResumeReceiveCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identity
                                              delegate:self
                                           inTableView:tableView
                                 withRightButtonTitles:@[@""]
                                 withRightButtonColors:@[[UIColor clearColor]]
                                                  type:ZFTableViewCellTypeFour
                                             rowHeight:100];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.block = ^(ResumeModel *model) {
            if (model.isSelected) {
                [self.selectedArr addObject:model];
                
            }
            else {
                [self.selectedArr removeObject:model];
            }
            
        };
        
    }
    cell.type = 1;
    if (self.modelArr.count > 0) {
        ResumeModel *model = self.modelArr[indexPath.section][indexPath.row];
        cell.model = model;
    }
    
    
    return cell;
}

#pragma mark - ZFTableViewCellDelegate
-(void)buttonTouchedOnCell:(ZFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath atButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"row:%ld,buttonIndex:%ld",(long)indexPath.row,(long)buttonIndex);
    
    ResumeModel *model = self.modelArr[indexPath.section][indexPath.row];
    
    // 删除简历
    if (buttonIndex == 0){
        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
        
        [paraDic setValue:model.inviteId forKey:@"inviteId"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:Delete_invite dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
            
            [self.modelArr removeObjectAtIndex:indexPath.section];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            
            
        }];
    }
    else if (buttonIndex == 1){
        
        NSMutableArray *arrM = [NSMutableArray arrayWithObject:model];
        
        InviteInterviewVC *vc = [[InviteInterviewVC alloc] init];
        vc.title = @"邀请面试内容";
        vc.selectedArr = arrM;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^{
            model.jobstatus = @"3";
        };
        //把cell复原
        [[NSNotificationCenter defaultCenter] postNotificationName:ZFTableViewCellNotificationChangeToUnexpanded object:nil];
    }
    
}

@end
