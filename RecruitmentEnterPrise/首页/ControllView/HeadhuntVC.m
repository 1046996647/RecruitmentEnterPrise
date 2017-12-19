//
//  HeadhuntVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/12/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HeadhuntVC.h"

@interface HeadhuntVC ()

@end

@implementation HeadhuntVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImage *image = [UIImage imageNamed:@"公司预览 copy"];
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenWidth*2164.0/750.0) icon:@"Line Copy 2"];
//    imgView.image = image;
    imgView.userInteractionEnabled = YES;
    
    CGFloat height = imgView.height*(124/815.0);
    
    UIButton *phoneBtn1 = [UIButton buttonWithframe:CGRectMake(0, imgView.height-height, kScreenWidth, height/8.0) text:nil font:nil textColor:nil backgroundColor:@"" normal:@"" selected:@""];
    [imgView addSubview:phoneBtn1];
//    phoneBtn1.backgroundColor = [UIColor redColor];
    [phoneBtn1 addTarget:self action:@selector(callAction1) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *phoneBtn2 = [UIButton buttonWithframe:CGRectMake(0, phoneBtn1.bottom, kScreenWidth, 20) text:nil font:nil textColor:nil backgroundColor:@"" normal:@"" selected:@""];
    [imgView addSubview:phoneBtn2];
//    phoneBtn2.backgroundColor = [UIColor redColor];
    [phoneBtn2 addTarget:self action:@selector(callAction2) forControlEvents:UIControlEventTouchUpInside];

    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:imgView];
    
    scrollView.contentSize = CGSizeMake(kScreenWidth, imgView.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callAction1
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"0579-83840599"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
    
}

- (void)callAction2
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"13858924279"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
    
}

@end
