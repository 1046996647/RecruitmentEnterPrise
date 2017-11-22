//
//  SessionListViewController.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SessionListViewController.h"
#import "NTESSessionViewController.h"

@interface SessionListViewController ()

@end

@implementation SessionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
//    self.navigationItem.title = @"会话";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSession)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSelectedRecent:(NIMRecentSession *)recent
             atIndexPath:(NSIndexPath *)indexPath
{
    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:recent.session];
    vc.title = @"聊天";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addSession
{
    //构造会话
    NIMSession *session = [NIMSession session:@"comp_21792" type:NIMSessionTypeP2P];
    NTESSessionViewController *sessionVC = [[NTESSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:sessionVC animated:YES];
}



@end
