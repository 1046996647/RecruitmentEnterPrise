//
//  ForgetPassword1VC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/12/1.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ForgetPassword1VC.h"

@interface ForgetPassword1VC ()

@end

@implementation ForgetPassword1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake((kScreenWidth-185)/2, 30, 185, 185) icon:@"Group-1"];
    [self.view addSubview:imgView];
    
    UILabel *titleLab = [UILabel labelWithframe:CGRectMake(0, imgView.bottom+25, kScreenWidth, 20) text:@"忘记密码请致电客服重置" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#666666"];
    [self.view addSubview:titleLab];
    
    UILabel *phoneLab = [UILabel labelWithframe:CGRectMake(0, titleLab.bottom+6, kScreenWidth, 20) text:@"0579-85129191" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#666666"];
    [self.view addSubview:phoneLab];
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(23, phoneLab.bottom+15, kScreenWidth-46, 40) text:@"确定" font:[UIFont systemFontOfSize:16] textColor:@"FFFFFF" backgroundColor:@"#D0021B" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab1 = [UILabel labelWithframe:CGRectMake(0, kScreenHeight-kTopHeight-33-18, kScreenWidth, 18) text:@"义乌市众信人才开发有限公司" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#666666"];
    [self.view addSubview:lab1];
    
    UILabel *lab2 = [UILabel labelWithframe:CGRectMake(0, lab1.bottom+4, kScreenWidth, 18) text:@"Yiwu Zhongxin Talent development Co.Ltd." font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#666666"];
    [self.view addSubview:lab2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)okAction
{
    //    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.tele];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"0579-85129191"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}

@end
