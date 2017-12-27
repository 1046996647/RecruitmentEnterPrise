//
//  HeadhuntVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/12/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HeadhuntVC.h"
#import "HeadhuntDetailVC.h"

@interface HeadhuntVC ()

@end

@implementation HeadhuntVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kTopHeight)];
    [self.view addSubview:scrollView];
//    self.scrollView = scrollView;
    
    // 账号信息
    UIButton *countBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth, 60) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:countBtn];
    countBtn.tag = 0;
    [countBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *countLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, countBtn.height) text:@"猎头简介" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [countBtn addSubview:countLab];
    
    UIImageView *countView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    countView.contentMode = UIViewContentModeScaleAspectFit;
    [countBtn addSubview:countView];
    
    // 基本信息
    UIButton *msgBtn = [UIButton buttonWithframe:CGRectMake(0, countBtn.bottom+10, kScreenWidth, countBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:msgBtn];
    msgBtn.tag = 1;
    [msgBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *msgLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, countBtn.height) text:@"服务行业" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [msgBtn addSubview:msgLab];
    
    UIImageView *msgView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    msgView.contentMode = UIViewContentModeScaleAspectFit;
    [msgBtn addSubview:msgView];
    
    // 投诉建议
    UIButton *otherBtn = [UIButton buttonWithframe:CGRectMake(0, msgBtn.bottom+10, kScreenWidth, countBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:otherBtn];
    otherBtn.tag = 2;
    [otherBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.otherBtn = otherBtn;
    
    UILabel *otherLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, countBtn.height) text:@"收费标准" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [otherBtn addSubview:otherLab];
    
    UIImageView *otherView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    msgView.contentMode = UIViewContentModeScaleAspectFit;
    [otherBtn addSubview:otherView];
    
    // 退出登录
    UIButton *exitBtn = [UIButton buttonWithframe:CGRectMake(otherBtn.left, otherBtn.bottom+ 10, kScreenWidth, otherBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:exitBtn];
    exitBtn.tag = 3;
    [exitBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.exitBtn = exitBtn;
    
    UILabel *exitLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, exitBtn.height) text:@"联系方式" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [exitBtn addSubview:exitLab];
    
    UIImageView *exitView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    exitView.contentMode = UIViewContentModeScaleAspectFit;
    [exitBtn addSubview:exitView];
    
    scrollView.contentSize = CGSizeMake(kScreenWidth, exitBtn.bottom);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        HeadhuntDetailVC *vc = [[HeadhuntDetailVC alloc] init];
        vc.title = @"猎头简介";
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        HeadhuntDetailVC *vc = [[HeadhuntDetailVC alloc] init];
        vc.title = @"服务行业";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 2) {
        HeadhuntDetailVC *vc = [[HeadhuntDetailVC alloc] init];
        vc.title = @"收费标准";
        //        vc.text = self.contentLab.text;
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (btn.tag == 3) {
        HeadhuntDetailVC *vc = [[HeadhuntDetailVC alloc] init];
        vc.title = @"联系方式";
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
