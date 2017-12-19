//
//  SettingVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SettingVC.h"
#import "WordsVC.h"
#import "CountMessageVC.h"
#import "BaseMessageVC.h"
#import "CompanyintroduceVC.h"
#import "NSStringExt.h"
#import "AppDelegate.h"
#import "NavigationController.h"
#import "LoginVC.h"

@interface SettingVC ()

@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UILabel *contentLab;
@property(nonatomic,strong) UIButton *otherBtn;
@property(nonatomic,strong) UIButton *exitBtn;

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) PersonModel *model;
@property(nonatomic,strong) UIScrollView *scrollView1;
@property(nonatomic,strong) UITextView *textView;


@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kTopHeight)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 账号信息
    UIButton *countBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth, 60) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:countBtn];
    countBtn.tag = 0;
    [countBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *countLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, countBtn.height) text:@"账号信息" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [countBtn addSubview:countLab];

    UIImageView *countView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    countView.contentMode = UIViewContentModeScaleAspectFit;
    [countBtn addSubview:countView];
    
    // 基本信息
    UIButton *msgBtn = [UIButton buttonWithframe:CGRectMake(0, countBtn.bottom+10, kScreenWidth, countBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:msgBtn];
    msgBtn.tag = 1;
    [msgBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *msgLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, countBtn.height) text:@"基本信息" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [msgBtn addSubview:msgLab];
    
    UIImageView *msgView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    msgView.contentMode = UIViewContentModeScaleAspectFit;
    [msgBtn addSubview:msgView];
    
    // 公司介绍
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, msgBtn.bottom+10, kScreenWidth, 47)];
    baseView.backgroundColor = colorWithHexStr(@"#FFFFFF");
    [scrollView addSubview:baseView];
    self.baseView = baseView;
    
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, 47) text:@"公司介绍" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#D0021B"];
    [baseView addSubview:companyLab];
    
    UIButton *companyBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-12-25, companyLab.center.y-15, 30, 30) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:@"30" selected:nil];
    [baseView addSubview:companyBtn];
    companyBtn.tag = 2;
    [companyBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(companyLab.left, companyLab.bottom, kScreenWidth-companyLab.left*2, .5)];
    lineView.backgroundColor = colorWithHexStr(@"#FFF5F7");
    [baseView addSubview:lineView];
    
//    UIScrollView *scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(companyLab.left, lineView.bottom+15, kScreenWidth-companyLab.left*2, 200)];
//    [baseView addSubview:scrollView1];
//    self.scrollView1 = scrollView1;
    
//    UILabel *contentLab = [UILabel labelWithframe:scrollView1.bounds text:@"" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
//    contentLab.numberOfLines = 0;
////    contentLab.backgroundColor = [UIColor greenColor];
//    [scrollView1 addSubview:contentLab];
//    self.contentLab = contentLab;
    
//    baseView.height = contentLab.bottom+10;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(companyLab.left, lineView.bottom+15, kScreenWidth-companyLab.left*2, 200)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = colorWithHexStr(@"#999999");
    [baseView addSubview:textView];
    self.textView = textView;
    textView.editable = NO;

    baseView.height = textView.bottom+10;

    // 投诉建议
    UIButton *otherBtn = [UIButton buttonWithframe:CGRectMake(0, baseView.bottom+10, kScreenWidth, countBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:otherBtn];
    otherBtn.tag = 3;
    [otherBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.otherBtn = otherBtn;
    
    UILabel *otherLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, countBtn.height) text:@"投诉建议" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [otherBtn addSubview:otherLab];
    
    UIImageView *otherView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    msgView.contentMode = UIViewContentModeScaleAspectFit;
    [otherBtn addSubview:otherView];
    
    // 退出登录
    UIButton *exitBtn = [UIButton buttonWithframe:CGRectMake(otherBtn.left, otherBtn.bottom+ 10, kScreenWidth, otherBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:exitBtn];
    exitBtn.tag = 1;
    [exitBtn addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
    self.exitBtn = exitBtn;
    
    UILabel *exitLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, exitBtn.height) text:@"退出登录" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [exitBtn addSubview:exitLab];
    
    UIImageView *exitView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    exitView.contentMode = UIViewContentModeScaleAspectFit;
    [exitBtn addSubview:exitView];
    
    scrollView.contentSize = CGSizeMake(kScreenWidth, exitBtn.bottom);
    
    [self preview_company_info];
}

- (void)exitAction:(UIButton *)btn
{
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

- (void)preview_company_info
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Preview_company_info dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        self.model = model;
        
//        CGSize size = [NSString textHeight:model.info font:self.contentLab.font width:self.contentLab.width];
//
//        self.contentLab.height = size.height;
//        self.baseView.height = self.contentLab.bottom+10;
//        self.otherBtn.top = self.baseView.bottom+10;
//        self.exitBtn.top = self.otherBtn.bottom+10;
//        self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.exitBtn.bottom);

        
//        self.contentLab.text = model.info;
        self.textView.text = model.info;

        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        CountMessageVC *vc = [[CountMessageVC alloc] init];
        vc.title = @"账号信息";
        vc.model = self.model;

        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        BaseMessageVC *vc = [[BaseMessageVC alloc] init];
        vc.title = @"编辑基本信息";
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 2) {
        CompanyintroduceVC *vc = [[CompanyintroduceVC alloc] init];
        vc.title = @"公司介绍";
//        vc.text = self.contentLab.text;
        vc.text = self.textView.text;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *text) {
            
//            CGSize size = [NSString textHeight:text font:self.contentLab.font width:self.contentLab.width];
//
//            self.contentLab.height = size.height;
//            self.baseView.height = self.contentLab.bottom+10;
//            self.otherBtn.top = self.baseView.bottom+10;
//            self.exitBtn.top = self.otherBtn.bottom+10;
//            self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.exitBtn.bottom);

//            self.scrollView1.contentSize = CGSizeMake(kScreenWidth, size.height);
//            self.contentLab.text = text;
            self.textView.text = text;
        };
    }
    if (btn.tag == 3) {
        WordsVC *vc = [[WordsVC alloc] init];
        vc.title = @"投诉建议";
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
