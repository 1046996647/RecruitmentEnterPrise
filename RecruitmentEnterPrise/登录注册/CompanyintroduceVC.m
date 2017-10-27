//
//  Company introduceVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CompanyintroduceVC.h"

@interface CompanyintroduceVC ()

@property(nonatomic,strong) UITextView *tv;


@end

@implementation CompanyintroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(23, 16, kScreenWidth-23*2, 329*scaleWidth)];
    [self.view addSubview:textView];
    textView.layer.cornerRadius = 7;
    textView.layer.masksToBounds = YES;
    self.tv = textView;
    textView.text = self.text;

    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(textView.left, (textView.bottom+102)*scaleWidth, kScreenWidth-textView.left*2, 40) text:@"提交" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [self.view addSubview:releseBtn];
    [releseBtn addTarget:self action:@selector(upAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeAction
{
    if (self.tv.text.length == 0) {
        [self.view makeToast:@"请填写公司介绍"];
        return;
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.tv.text forKey:@"info"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Edit_info dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        if (self.block) {
            self.block(_tv.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)upAction
{
    if ([self.title isEqualToString:@"公司介绍"]) {
        [self changeAction];
    }
    else {
        if (self.block) {
            self.block(_tv.text);
        }
        [self.navigationController popViewControllerAnimated:YES];

    }

}

@end
