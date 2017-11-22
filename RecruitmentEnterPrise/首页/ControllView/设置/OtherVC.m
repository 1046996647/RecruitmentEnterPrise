//
//  OtherVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "OtherVC.h"
#import "ChangeInfoVC.h"
#import "AppDelegate.h"
#import "NavigationController.h"
#import "LoginVC.h"


@interface OtherVC ()

@end

@implementation OtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 修改资料
    UIButton *changeBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth, 60) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:changeBtn];
    changeBtn.tag = 0;
    [changeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *changeLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, changeBtn.height) text:@"修改资料" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [changeBtn addSubview:changeLab];
    
    UIImageView *changeView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    changeView.contentMode = UIViewContentModeScaleAspectFit;
    [changeBtn addSubview:changeView];
    
    // 退出登录
    UIButton *exitBtn = [UIButton buttonWithframe:CGRectMake(changeBtn.left, changeBtn.bottom+ 10, kScreenWidth, changeBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:exitBtn];
    exitBtn.tag = 1;
    [exitBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *exitLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, changeBtn.height) text:@"退出登录" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [exitBtn addSubview:exitLab];
    
    UIImageView *exitView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    exitView.contentMode = UIViewContentModeScaleAspectFit;
    [exitBtn addSubview:exitView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        ChangeInfoVC *vc = [[ChangeInfoVC alloc] init];
        vc.title = @"修改资料";
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要退出登录吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [InfoCache saveValue:@0 forKey:@"LoginedState"];
            [InfoCache archiveObject:nil toFile:@"token"];

            [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error)
             {
//                 extern NSString *NTESNotificationLogout;
//                 [[NSNotificationCenter defaultCenter] postNotificationName:NTESNotificationLogout object:nil];
             }];
            
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            LoginVC *loginVC = [[LoginVC alloc] init];
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:loginVC];
            delegate.window.rootViewController = nav;
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

@end
