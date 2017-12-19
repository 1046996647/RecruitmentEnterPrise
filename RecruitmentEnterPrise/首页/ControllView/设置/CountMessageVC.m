//
//  CountMessageVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CountMessageVC.h"
#import "CompanyintroduceVC.h"
#import "ChangePhoneVC.h"
#import "ChangePasswordVC.h"

@interface CountMessageVC ()

@property(nonatomic,strong) UILabel *mailLab1;
@property(nonatomic,strong) UILabel *phoneLab;


@end

@implementation CountMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 登录账号
    UIButton *changeBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth, 60) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:changeBtn];
//    changeBtn.tag = 0;
//    [changeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *changeLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, changeBtn.height) text:@"登录账号" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [changeBtn addSubview:changeLab];
    
    // dayday
    UILabel *nameLab = [UILabel labelWithframe:CGRectMake(kScreenWidth-100-20, 0, 100, changeBtn.height) text:@"" font:SystemFont(17) textAlignment:NSTextAlignmentRight textColor:@"#333333"];
    [changeBtn addSubview:nameLab];
    nameLab.text = self.model.cname;
    
    // 手机号
    UIButton *exitBtn = [UIButton buttonWithframe:CGRectMake(changeBtn.left, changeBtn.bottom+ 10, kScreenWidth, changeBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:exitBtn];
    exitBtn.tag = 0;
    [exitBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *exitLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, changeBtn.height) text:@"手机号" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [exitBtn addSubview:exitLab];

    
    UIImageView *exitView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    exitView.contentMode = UIViewContentModeScaleAspectFit;
    [exitBtn addSubview:exitView];
    
    // 18842682580
    UILabel *phoneLab = [UILabel labelWithframe:CGRectMake(exitView.left-200-10, 0, 200, changeBtn.height) text:@"" font:SystemFont(17) textAlignment:NSTextAlignmentRight textColor:@"#333333"];
    [exitBtn addSubview:phoneLab];
//    phoneLab.text = self.model.phone;
    self.phoneLab = phoneLab;
    
    // E-mail
    UIButton *mailBtn = [UIButton buttonWithframe:CGRectMake(changeBtn.left, exitBtn.bottom+ 1, kScreenWidth, changeBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:mailBtn];
    mailBtn.tag = 1;
    [mailBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *mailLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, changeBtn.height) text:@"E-mail" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [mailBtn addSubview:mailLab];
    
    UIImageView *mailView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    mailView.contentMode = UIViewContentModeScaleAspectFit;
    [mailBtn addSubview:mailView];
    
    // 356335205@qq.com
    UILabel *mailLab1 = [UILabel labelWithframe:CGRectMake(mailView.left-200-10, 0, 200, changeBtn.height) text:@"" font:SystemFont(17) textAlignment:NSTextAlignmentRight textColor:@"#333333"];
    [mailBtn addSubview:mailLab1];
    self.mailLab1 = mailLab1;
    mailLab1.text = self.model.email;
    
    // 修改密码
    UIButton *pswBtn = [UIButton buttonWithframe:CGRectMake(changeBtn.left, mailBtn.bottom+ 1, kScreenWidth, changeBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:pswBtn];
    pswBtn.tag = 2;
    [pswBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *pswLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, changeBtn.height) text:@"修改密码" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [pswBtn addSubview:pswLab];
    
    UIImageView *pswView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    pswView.contentMode = UIViewContentModeScaleAspectFit;
    [pswBtn addSubview:pswView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.phoneLab.text = self.model.phone;
}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        ChangePhoneVC *vc = [[ChangePhoneVC alloc] init];
        vc.title = @"修改手机";
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (btn.tag == 1) {

        CompanyintroduceVC *vc = [[CompanyintroduceVC alloc] init];
        vc.title = @"修改邮箱";
        vc.text = self.model.email;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *text) {
            
            self.model.email = text;
            self.mailLab1.text = text;
        };

    }
    if (btn.tag == 2) {
        ChangePasswordVC *vc = [[ChangePasswordVC alloc] init];
        vc.title = @"修改密码";
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
