//
//  SettingVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SettingVC.h"
#import "OtherVC.h"
#import "CountMessageVC.h"
#import "BaseMessageVC.h"
#import "CompanyintroduceVC.h"
#import "NSStringExt.h"


@interface SettingVC ()

@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UILabel *contentLab;
@property(nonatomic,strong) UIButton *otherBtn;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) PersonModel *model;


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
    
    UILabel *contentLab = [UILabel labelWithframe:CGRectMake(companyLab.left, lineView.bottom+15, kScreenWidth-companyLab.left*2, 200) text:@"" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    contentLab.numberOfLines = 0;
//    contentLab.backgroundColor = [UIColor greenColor];
    [baseView addSubview:contentLab];
    self.contentLab = contentLab;
    
    baseView.height = contentLab.bottom+10;
    
    // 其他功能
    UIButton *otherBtn = [UIButton buttonWithframe:CGRectMake(0, baseView.bottom+10, kScreenWidth, countBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:otherBtn];
    otherBtn.tag = 3;
    [otherBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.otherBtn = otherBtn;
    
    UILabel *otherLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, countBtn.height) text:@"其他功能" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [otherBtn addSubview:otherLab];
    
    UIImageView *otherView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    msgView.contentMode = UIViewContentModeScaleAspectFit;
    [otherBtn addSubview:otherView];
    
    scrollView.contentSize = CGSizeMake(kScreenWidth, otherBtn.bottom);
    
    [self preview_company_info];
}

- (void)preview_company_info
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Preview_company_info dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        self.model = model;
        
        CGSize size = [NSString textHeight:model.info font:self.contentLab.font width:self.contentLab.width];
        
        self.contentLab.height = size.height;
        self.baseView.height = self.contentLab.bottom+10;
        self.otherBtn.top = self.baseView.bottom+10;
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.otherBtn.bottom);

        
        self.contentLab.text = model.info;
        
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
        vc.text = self.contentLab.text;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *text) {
            
            CGSize size = [NSString textHeight:text font:self.contentLab.font width:self.contentLab.width];
            
            self.contentLab.height = size.height;
            self.baseView.height = self.contentLab.bottom+10;
            self.otherBtn.top = self.baseView.bottom+10;
            self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.otherBtn.bottom);

            self.contentLab.text = text;
        };
    }
    if (btn.tag == 3) {
        OtherVC *vc = [[OtherVC alloc] init];
        vc.title = @"其他功能";
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
