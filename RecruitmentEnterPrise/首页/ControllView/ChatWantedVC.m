//
//  ChatWantedVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ChatWantedVC.h"
#import "ChatWantedCell.h"
#import "EditResumeVC.h"

@interface ChatWantedVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ChatWantedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    // 右上角按钮
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 58, 17)];
//
//    UIButton *viewBtn = [UIButton buttonWithframe:rightView.bounds text:@"职位分类" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:nil normal:nil selected:nil];
//    [rightView addSubview:viewBtn];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    [self get_chat_resume];

}

- (void)get_chat_resume
{
    NSArray *recentSessions = [NIMSDK sharedSDK].conversationManager.allRecentSessions;
    NSLog(@"recentSessions:%@",recentSessions);
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NIMRecentSession *recentSession in recentSessions) {
        [arrM addObject:recentSession.session.sessionId];
    }
    NSString *idStr = [arrM componentsJoinedByString:@","];
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic setValue:idStr forKey:@"accid"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_chat_resume dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        NSMutableArray *arrM = [NSMutableArray array];

        for (NSDictionary *dic in responseObject[@"data"]) {
            
            ResumeModel *model = [ResumeModel yy_modelWithJSON:dic];
            [arrM addObject:model];
        }
        self.dataArr = arrM;
        [_tableView reloadData];
        
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
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ResumeModel *model = self.dataArr[indexPath.row];
    
    EditResumeVC *vc = [[EditResumeVC alloc] init];
    vc.title = @"详情";
    vc.model1 = model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatWantedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[ChatWantedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    ResumeModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

@end
