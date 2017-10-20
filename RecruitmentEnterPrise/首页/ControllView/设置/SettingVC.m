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

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kTopHeight)];
    [self.view addSubview:scrollView];
    
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
    
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, 47) text:@"公司介绍" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#D0021B"];
    [baseView addSubview:companyLab];
    
    UIButton *companyBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-12-25, companyLab.center.y-15, 30, 30) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:@"30" selected:nil];
    [baseView addSubview:companyBtn];
    companyBtn.tag = 2;
    [companyBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(companyLab.left, companyLab.bottom, kScreenWidth-companyLab.left*2, .5)];
    lineView.backgroundColor = colorWithHexStr(@"#FFF5F7");
    [baseView addSubview:lineView];
    
    UILabel *contentLab = [UILabel labelWithframe:CGRectMake(companyLab.left, lineView.bottom+15, kScreenWidth-companyLab.left*2, 200) text:@"     杭州晖鸿科技有限公司隶属于杭州鸿鹄电子有限公司，是公司专业从事软件技术开发、信息化建设的高新技术团队。公司研发团队坐落于中国杭州核心互联网区域未来科技城内，拥有行业内最顶尖的人才和软硬件基础，同时秉承着鸿鹄电子优良的企业传统，融合时下最新的互联网技术和概念，为各行各业的客户提供优质、高科技含量的产品和技术支持，满足不同客户在信息化时代的发展需要。\n     公司由80、90后中青年组成，涵盖JAVA、PHP、.NET、HTML5、Android、IOS、微信等市面主流技术和研发能力。由10年以上开发经验工程师带队，结合各大高校优质毕业生，结合打造一支年轻又富有潜力，全面又不失专精的高质量技术团队" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    contentLab.numberOfLines = 0;
//    contentLab.backgroundColor = [UIColor greenColor];
    [baseView addSubview:contentLab];
    
    baseView.height = contentLab.bottom;
    
    // 其他功能
    UIButton *otherBtn = [UIButton buttonWithframe:CGRectMake(0, baseView.bottom+10, kScreenWidth, countBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [scrollView addSubview:otherBtn];
    otherBtn.tag = 3;
    [otherBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *otherLab = [UILabel labelWithframe:CGRectMake(18, 0, 100, countBtn.height) text:@"其他功能" font:SystemFont(17) textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [otherBtn addSubview:otherLab];
    
    UIImageView *otherView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 24, 6, 12) icon:@"44"];
    msgView.contentMode = UIViewContentModeScaleAspectFit;
    [otherBtn addSubview:otherView];
    
    scrollView.contentSize = CGSizeMake(kScreenWidth, otherBtn.bottom);
    
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
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        BaseMessageVC *vc = [[BaseMessageVC alloc] init];
        vc.title = @"编辑基本信息";
        [self.navigationController pushViewController:vc animated:YES];
    }
//    if (btn.tag == 2) {
//        InviteInterviewVC *vc = [[InviteInterviewVC alloc] init];
//        vc.title = @"邀请面试记录";
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    if (btn.tag == 3) {
        OtherVC *vc = [[OtherVC alloc] init];
        vc.title = @"其他功能";
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
