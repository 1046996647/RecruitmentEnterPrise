//
//  HomeVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HomeVC.h"
#import "JobManageVC.h"
#import "InviteInterviewRecordVC.h"
#import "WordsVC.h"
#import "MyMailboxVC.h"
#import "ResumeSearchVC.h"
#import "ChatWantedVC.h"
#import "SettingVC.h"
#import "CompanyDetailVC.h"

@interface HomeVC ()

@property(nonatomic,strong) UIButton *forgetBtn;
@property(nonatomic,strong) UIButton *forgetBtn1;
@property(nonatomic,strong) UIButton *forgetBtn2;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kTopHeight)];
    [self.view addSubview:scrollView];
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    baseView.backgroundColor = colorWithHexStr(@"#D0021B");
    [scrollView addSubview:baseView];

    UIButton *logoBtn = [UIButton buttonWithframe:CGRectMake(20, 10, 71, 71) text:nil font:nil textColor:nil backgroundColor:nil normal:nil selected:nil];
    logoBtn.layer.cornerRadius = logoBtn.height/2.0;
    logoBtn.layer.masksToBounds = YES;
    logoBtn.layer.borderColor = [UIColor colorWithHexString:@"#FF8054"].CGColor;
    logoBtn.layer.borderWidth = 5;
    [scrollView addSubview:logoBtn];

    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(logoBtn.right+18, logoBtn.top, kScreenWidth-logoBtn.right-12, 25) text:@"杭州晖鸿科技有限公司" font:SystemFont(18) textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
    [scrollView addSubview:companyLab];
    
    UILabel *nameLab = [UILabel labelWithframe:CGRectMake(companyLab.left, companyLab.bottom+2, 48, 20) text:@"dayday" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
    [scrollView addSubview:nameLab];
    
    UIImageView *levelView = [UIImageView imgViewWithframe:CGRectMake(nameLab.right+7, nameLab.top, 12, 20) icon:@"65"];
    levelView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:levelView];

    UIButton *levelBtn = [UIButton buttonWithframe:CGRectMake(levelView.right+7, nameLab.top, 44+20, nameLab.height) text:@"会员充值" font:SystemFont(11) textColor:@"#F5A623" backgroundColor:nil normal:nil selected:nil];
    levelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [scrollView addSubview:levelBtn];
    
    UIImageView *jiantouView = [UIImageView imgViewWithframe:CGRectMake(levelBtn.width-20, 4, 20, 12) icon:@"Path 3"];
    jiantouView.contentMode = UIViewContentModeScaleAspectFit;
    [levelBtn addSubview:jiantouView];
    
    UILabel *emailLab = [UILabel labelWithframe:CGRectMake(companyLab.left, nameLab.bottom+2, kScreenWidth-logoBtn.right-12, 20) text:@"356335205@qq.com" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
    [scrollView addSubview:emailLab];
    
    NSArray *titleArr = @[@"今日剩余可查看简历",@"天会员到期时间",@"套餐剩余短信条数"];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreenWidth/titleArr.count, baseView.bottom, kScreenWidth/titleArr.count, 68) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [scrollView addSubview:forgetBtn];
        self.forgetBtn = forgetBtn;
        forgetBtn.tag = i;
//        [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, 10, forgetBtn.width, 28) text:@"0" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
//        [_labelArr addObject:label1];
        
        
        UILabel *label2 = [UILabel labelWithframe:CGRectMake(0, label1.bottom+2, forgetBtn.width, 17) text:titleArr[i] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#999999"];
        [forgetBtn addSubview:label2];
        
        
    }
    
    
    NSArray *titleArr1 = @[@"收到简历",@"查看简历",@"收藏人才"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreenWidth/titleArr1.count, self.forgetBtn.bottom+10, kScreenWidth/titleArr1.count, 68) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [scrollView addSubview:forgetBtn];
        self.forgetBtn1 = forgetBtn;
        forgetBtn.tag = i;
//        [forgetBtn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, 10, forgetBtn.width, 28) text:@"0" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        //        [_labelArr addObject:label1];
        
        
        UILabel *label2 = [UILabel labelWithframe:CGRectMake(0, label1.bottom+2, forgetBtn.width, 17) text:titleArr1[i] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#999999"];
        [forgetBtn addSubview:label2];
        
        
    }
    
    CGFloat interval = 1;
    CGFloat aWidth = (kScreenWidth-interval*2)/3;
    NSArray *imgArr = @[@"62",@"61",@"60",@"59",@"58",@"57"];
    NSArray *titleArr2 = @[@"职位管理",@"简历搜索",@"邀请面试记录",@"约聊招聘",@"我的信箱",@"在线投诉/留言"];
    for (int i=0; i<titleArr2.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake((i%3)*(aWidth+interval), self.forgetBtn1.bottom+10+(i/3)*(aWidth+interval), aWidth, aWidth) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [scrollView addSubview:forgetBtn];
        self.forgetBtn2 = forgetBtn;
        [forgetBtn addTarget:self action:@selector(btnAction2:) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.tag = i;
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 29*scaleWidth, forgetBtn.width, 45*scaleWidth) icon:imgArr[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [forgetBtn addSubview:imgView];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, (imgView.bottom+16)*scaleWidth, forgetBtn.width, 20*scaleWidth) text:titleArr2[i] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        
    }
    
    scrollView.contentSize = CGSizeMake(kScreenWidth, self.forgetBtn2.bottom);
    
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20+22+20, 20)];
    
    UIButton *viewBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 20, rightView.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"66" selected:nil];
    [rightView addSubview:viewBtn];
    [viewBtn addTarget:self action:@selector(viewAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *setBtn = [UIButton buttonWithframe:CGRectMake(viewBtn.right+22, viewBtn.top, 20, rightView.height) text:nil font:nil textColor:nil backgroundColor:nil normal:@"67" selected:@""];
    [rightView addSubview:setBtn];
    [setBtn addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}


- (void)btnAction2:(UIButton *)btn
{
    if (btn.tag == 0) {
        JobManageVC *vc = [[JobManageVC alloc] init];
        vc.title = @"职位管理";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        ResumeSearchVC *vc = [[ResumeSearchVC alloc] init];
//        vc.title = @"职位管理";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 2) {
        InviteInterviewRecordVC *vc = [[InviteInterviewRecordVC alloc] init];
        vc.title = @"邀请面试记录";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 3) {
        ChatWantedVC *vc = [[ChatWantedVC alloc] init];
        vc.title = @"约聊招聘";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 4) {
        MyMailboxVC *vc = [[MyMailboxVC alloc] init];
        vc.title = @"我的信箱";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 5) {
        WordsVC *vc = [[WordsVC alloc] init];
        vc.title = @"在线投诉留言";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewAction
{
    CompanyDetailVC *vc = [[CompanyDetailVC alloc] init];
    vc.title = @"首页预览";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setAction
{
    SettingVC *vc = [[SettingVC alloc] init];
    vc.title = @"设置";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
