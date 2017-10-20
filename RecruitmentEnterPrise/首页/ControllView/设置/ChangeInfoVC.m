//
//  ChangeInfoVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ChangeInfoVC.h"
#import "ContactManageVC.h"
#import "ChangePasswordVC.h"

@interface ChangeInfoVC ()

@end

@implementation ChangeInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 联系人管理
    UIButton *changeBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth, 60) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:changeBtn];
    changeBtn.tag = 0;
    [changeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *changeLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, changeBtn.height) text:@"联系人管理" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [changeBtn addSubview:changeLab];
    
    UIImageView *changeView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    changeView.contentMode = UIViewContentModeScaleAspectFit;
    [changeBtn addSubview:changeView];
    
    // 修改密码
    UIButton *exitBtn = [UIButton buttonWithframe:CGRectMake(changeBtn.left, changeBtn.bottom+ 10, kScreenWidth, changeBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:exitBtn];
    exitBtn.tag = 1;
    [exitBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *exitLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, changeBtn.height) text:@"修改密码" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
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
        ContactManageVC *vc = [[ContactManageVC alloc] init];
        vc.title = @"联系人管理";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        ChangePasswordVC *vc = [[ChangePasswordVC alloc] init];
        vc.title = @"修改密码";
        [self.navigationController pushViewController:vc animated:YES];
    }

    
}

@end
