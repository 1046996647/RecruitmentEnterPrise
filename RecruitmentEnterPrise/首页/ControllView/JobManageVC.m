//
//  JobManageVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobManageVC.h"
#import "JobCell.h"
#import "ZFTableViewCell.h"
#import "ReleaseJob1VC.h"
#import "ReleaseJobModel.h"
#import "NavigationController.h"

@interface JobManageVC ()<UITableViewDelegate,UITableViewDataSource,ZFTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *selectedArr;// 选择数组
@property(nonatomic,strong) NSMutableArray *orderArr;// 排序数组
@property (nonatomic,assign) BOOL isRefresh;


@end

@implementation JobManageVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-kTabBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self headerRefresh];
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, rightView.height, rightView.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"105" selected:nil];
    [rightView addSubview:viewBtn];
    [viewBtn addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIButton *setBtn = [UIButton buttonWithframe:CGRectMake(viewBtn.right+13, viewBtn.top, rightView.height, rightView.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"104" selected:@""];
//    [rightView addSubview:setBtn];
//    [setBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    // 底部按钮
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-52-kTopHeight, kScreenWidth, 52)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    UIView *baseView1 = [[UIView alloc] initWithFrame:CGRectMake(12, 6, kScreenWidth-24, 40)];
    [baseView addSubview:baseView1];
    
    UIButton *delBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 105*scaleWidth, 40) text:@"删除选中" font:SystemFont(16) textColor:@"#D0021B" backgroundColor:nil normal:@"" selected:nil];
    delBtn.layer.cornerRadius = 7;
    delBtn.layer.masksToBounds = YES;
    delBtn.layer.borderColor = [UIColor colorWithHexString:@"#CB4F5E"].CGColor;
    delBtn.layer.borderWidth = 1;
    [baseView1 addSubview:delBtn];
    [delBtn addTarget:self action:@selector(delAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *refreshBtn = [UIButton buttonWithframe:CGRectMake(delBtn.right+5, 0, (baseView1.width-delBtn.right-10)/2, 40) text:@"刷新职位" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    refreshBtn.layer.cornerRadius = 7;
    refreshBtn.layer.masksToBounds = YES;
    [baseView1 addSubview:refreshBtn];
    [refreshBtn addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(refreshBtn.right+5, 0, refreshBtn.width, 40) text:@"发布新职位" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [baseView1 addSubview:releseBtn];
    [releseBtn addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];

    self.selectedArr = [NSMutableArray array];
    self.orderArr = [NSMutableArray array];

    
    [self get_position];
}

- (void)headerRefresh
{

    [self get_position];
}


// 2.8    职位显示顺序修改
- (void)orderAction
{
    if (self.orderArr.count == 0) {
        [self.view makeToast:@"请先修改排序"];
        return;
    }
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    // 职位id
    NSMutableArray *idArr = [NSMutableArray array];
    for (ReleaseJobModel *model in self.orderArr) {
        [idArr addObject:model.jobId];
        
    }
    NSString *string = [idArr componentsJoinedByString:@","]; //,为分隔符
    [paraDic setValue:string forKey:@"jobId"];
    
    // 排序id
    NSMutableArray *orderArr = [NSMutableArray array];
    for (ReleaseJobModel *model in self.orderArr) {
        [orderArr addObject:model.ordid];
        
    }
    NSString *string1 = [orderArr componentsJoinedByString:@","]; //,为分隔符
    [paraDic setValue:string1 forKey:@"ordid"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Update_order dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {

        [self get_position];


    } failure:^(NSError *error) {


    }];
}

// 2.7    刷新职位
- (void)refreshAction
{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];

    [AFNetworking_RequestData requestMethodPOSTUrl:Refresh_position dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {

        if (self.vipLevel.integerValue == 0) {

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请联系客服充值会员" message:ServerPhone preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"联系客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",ServerPhone];
                UIWebView *callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            return ;
        }
        
        [self.view makeToast:@"刷新成功"];
        [self get_position];

    } failure:^(NSError *error) {


    }];
}

- (void)delAction
{

    if (self.selectedArr.count == 0) {
        
        [self.view makeToast:@"请先选择职位"];
        return;
    }
    
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    // 职位id
    NSMutableArray *idArr = [NSMutableArray array];
    for (ReleaseJobModel *model in self.selectedArr) {
        [idArr addObject:model.jobId];
        
    }
    NSString *string = [idArr componentsJoinedByString:@","]; //,为分隔符
    [paraDic setValue:string forKey:@"jobId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Delete_position dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {

        [self.view makeToast:@"删除成功"];

        [self get_position];


    } failure:^(NSError *error) {


    }];
    
    
 
}

- (void)releaseAction
{
    ReleaseJob1VC *vc = [[ReleaseJob1VC alloc] init];
    vc.title = @"发布新职位";
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    vc.block = ^{
        [self get_position];

    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)get_position
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_position dic:paramDic showHUD:NO response:YES Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        
        if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
                
                NSMutableArray *arrM1 = [NSMutableArray array];
                
                ReleaseJobModel *model = [ReleaseJobModel yy_modelWithDictionary:dic];
                [arrM1 addObject:model];
                [arrM addObject:arrM1];
            }
            self.dataArr = arrM;
            [_tableView reloadData];
        }

        
    } failure:^(NSError *error) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
//    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
//    return 1;
    
    
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
    ReleaseJobModel *model = self.dataArr[section][0];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    UILabel *label = [UILabel labelWithframe:CGRectMake(19, 7, kScreenWidth-19, 17) text:model.update_time font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
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

    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        
        cell = [[JobCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identity
                                              delegate:self
                                           inTableView:tableView
                                 withRightButtonTitles:@[@""]
                                 withRightButtonColors:@[[UIColor clearColor]]
                                                  type:ZFTableViewCellTypeOne
                                             rowHeight:60];
        cell.block = ^(ReleaseJobModel *model, NSInteger type) {
            
            // 选中或改变状态
            if (type == 0) {
                if (model) {
                    if (model.isSelected) {
                        [self.selectedArr addObject:model];
                        
                    }
                    else {
                        [self.selectedArr removeObject:model];
                    }
                }
                [_tableView reloadData];
            }
            // 排序
            else if (type == 1) {
                if (![self.orderArr containsObject:model]) {
                    [self.orderArr addObject:model];
                    
                }
            }
            else {
//                [self get_position];

                ReleaseJob1VC *vc = [[ReleaseJob1VC alloc] init];
                vc.title = @"修改职位";
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }

        };
        
    }
    
    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    cell.dataArr = _dataArr;
    cell.vipLevel = self.vipLevel;
    //    cell.selectJobArr = _selectJobArr;
    return cell;
}

#pragma mark - ZFTableViewCellDelegate
-(void)buttonTouchedOnCell:(ZFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath atButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"row:%ld,buttonIndex:%ld",(long)indexPath.row,(long)buttonIndex);
    
    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];

    // 编辑
    if (buttonIndex == 0){
        NSLog(@"编辑");
        ReleaseJob1VC *vc = [[ReleaseJob1VC alloc] init];
        vc.title = @"修改职位";
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
        //把cell复原
        [[NSNotificationCenter defaultCenter] postNotificationName:ZFTableViewCellNotificationChangeToUnexpanded object:nil];
    }
    else if (buttonIndex == 1){
        NSLog(@"删除");

        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
        
        [paraDic setValue:model.jobId forKey:@"jobId"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:Delete_position dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
            
            [self.dataArr removeObjectAtIndex:indexPath.section];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            
            
        }];
        
    }
    

}

@end
