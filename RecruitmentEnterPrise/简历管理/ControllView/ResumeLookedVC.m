//
//  ResumeLookedVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeLookedVC.h"
#import "ResumeReceiveCell.h"
#import "ZFTableViewCell.h"
#import "InviteInterviewVC.h"
#import "EditResumeVC.h"


@interface ResumeLookedVC ()<UITableViewDelegate,UITableViewDataSource,ZFTableViewCellDelegate>

//@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger pageNO;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,assign) BOOL isRefresh;

@end

@implementation ResumeLookedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-37-40) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
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
            [self get_job_viewers];
        }
        
    }];
    
    self.pageNO = 1;
    self.modelArr = [NSMutableArray array];
    
    [self get_job_viewers];

}

- (void)headerRefresh
{
    self.pageNO = 1;
    if (self.modelArr.count > 0) {
        [self.modelArr removeAllObjects];
        
    }
    [self get_job_viewers];
}

- (void)get_job_viewers
{
    
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@p/%ld",Get_job_viewers,self.pageNO];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                                                  type:ZFTableViewCellTypeTwo
                                             rowHeight:100];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    ResumeModel *model = self.modelArr[indexPath.section][indexPath.row];
    cell.model = model;

    return cell;
}

#pragma mark - ZFTableViewCellDelegate
-(void)buttonTouchedOnCell:(ZFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath atButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"row:%ld,buttonIndex:%ld",(long)indexPath.row,(long)buttonIndex);
    
    // 删除简历
    if (buttonIndex == 0){
        NSLog(@"编辑");
    }
    else if (buttonIndex == 1){
        InviteInterviewVC *vc = [[InviteInterviewVC alloc] init];
        vc.title = @"邀请面试";
        [self.navigationController pushViewController:vc animated:YES];
    }
    //把cell复原
    [[NSNotificationCenter defaultCenter] postNotificationName:ZFTableViewCellNotificationChangeToUnexpanded object:nil];
}

@end
