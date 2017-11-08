//
//  Company introduceVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CompanyintroduceVC.h"
#import "RegexTool.h"

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
    
    if ([self.title isEqualToString:@"修改邮箱"]) {
        textView.height = 40;
    }

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
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    NSString *url = nil;
    if ([self.title isEqualToString:@"修改邮箱"]) {
        
        if (![RegexTool validateEmail:self.tv.text]) {
            [self.view makeToast:@"邮箱格式错误"];
            return;
        }
        
        [paramDic  setValue:self.tv.text forKey:@"email"];
        url = Update_company_info;
    }
    else {
        [paramDic  setValue:self.tv.text forKey:@"info"];
        url = Edit_info;

    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:url dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        if (self.block) {
            self.block(_tv.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)upAction
{
    if (self.tv.text.length == 0) {
        [self.view makeToast:@"请填写内容"];
        return;
    }
    
    if ([self.title isEqualToString:@"公司介绍"]||
        [self.title isEqualToString:@"修改邮箱"]) {
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
