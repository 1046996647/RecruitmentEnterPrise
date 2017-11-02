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
#import "UILabel+WLAttributedString.h"
#import "PersonalMessageVC.h"
#import "NSStringExt.h"


@interface HomeVC ()

@property(nonatomic,strong) UIButton *forgetBtn;
@property(nonatomic,strong) UIButton *forgetBtn1;
@property(nonatomic,strong) UIButton *forgetBtn2;
@property(nonatomic,strong) NSMutableArray *labelArr;
@property(nonatomic,strong) NSMutableArray *labelArr1;
@property(nonatomic,strong) UIButton *logoBtn;
@property(nonatomic,strong) UILabel *companyLab;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UIImageView *levelView;
@property(nonatomic,strong) UILabel *emailLab;
@property(nonatomic,strong) UIButton *levelBtn;
@property(nonatomic,strong) PersonModel *model;


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

    UIButton *logoBtn = [UIButton buttonWithframe:CGRectMake(20, 10, 71, 71) text:nil font:nil textColor:nil backgroundColor:nil normal:@"Rectangle 14" selected:nil];
    logoBtn.layer.cornerRadius = logoBtn.height/2.0;
    logoBtn.layer.masksToBounds = YES;
    logoBtn.layer.borderColor = [UIColor colorWithHexString:@"#FF8054"].CGColor;
    logoBtn.layer.borderWidth = 5;
    [scrollView addSubview:logoBtn];
    self.logoBtn = logoBtn;

    // 杭州晖鸿科技有限公司
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(logoBtn.right+18, logoBtn.top, kScreenWidth-logoBtn.right-12, 25) text:@"" font:SystemFont(18) textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
    [scrollView addSubview:companyLab];
    self.companyLab = companyLab;
    
    // dayday
    UILabel *nameLab = [UILabel labelWithframe:CGRectMake(companyLab.left, companyLab.bottom+2, 48, 20) text:@"" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
    [scrollView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UIImageView *levelView = [UIImageView imgViewWithframe:CGRectMake(nameLab.right+7, nameLab.top, 12, 20) icon:@""];
    levelView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:levelView];
    self.levelView = levelView;
//    levelView.backgroundColor = [UIColor yellowColor];

    UIButton *levelBtn = [UIButton buttonWithframe:CGRectMake(levelView.right+7, nameLab.top, 44+20, nameLab.height) text:@"会员充值" font:SystemFont(11) textColor:@"#F5A623" backgroundColor:nil normal:nil selected:nil];
    levelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [scrollView addSubview:levelBtn];
    [levelBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    self.levelBtn = levelBtn;
    
    UIImageView *jiantouView = [UIImageView imgViewWithframe:CGRectMake(levelBtn.width-20, 4, 20, 12) icon:@"Path 3"];
    jiantouView.contentMode = UIViewContentModeScaleAspectFit;
    [levelBtn addSubview:jiantouView];
    
    UILabel *emailLab = [UILabel labelWithframe:CGRectMake(companyLab.left, nameLab.bottom+2, kScreenWidth-logoBtn.right-12, 20) text:@"356335205@qq.com" font:SystemFont(14) textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
    [scrollView addSubview:emailLab];
    self.emailLab = emailLab;
    
    _labelArr = [NSMutableArray array];
    NSArray *titleArr = @[@"今日剩余可查看简历",@"天会员到期时间",@"套餐剩余短信条数"];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreenWidth/titleArr.count, baseView.bottom, kScreenWidth/titleArr.count, 68) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [scrollView addSubview:forgetBtn];
        self.forgetBtn = forgetBtn;
        forgetBtn.tag = i;
        [forgetBtn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];

        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, 10, forgetBtn.width, 28) text:@"0" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        [_labelArr addObject:label1];
        
        
        UILabel *label2 = [UILabel labelWithframe:CGRectMake(0, label1.bottom+2, forgetBtn.width, 17) text:titleArr[i] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#999999"];
        [forgetBtn addSubview:label2];
        
        
        if (i == 2) {
            
            label1.textColor = [UIColor colorWithHexString:@"#D0021B"];
            label1.text = @"0+0";
            
            // 该方法是从后往前查找
            [label1 wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#417504"] changeText:@"0"];
            [label1 wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#333333"] changeText:@"+"];
            
        }
        
    }
    
    _labelArr1 = [NSMutableArray array];
    NSArray *titleArr1 = @[@"收到简历",@"查看简历",@"收藏人才"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreenWidth/titleArr1.count, self.forgetBtn.bottom+10, kScreenWidth/titleArr1.count, 68) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [scrollView addSubview:forgetBtn];
        self.forgetBtn1 = forgetBtn;
        forgetBtn.tag = i;
//        [forgetBtn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, 10, forgetBtn.width, 28) text:@"0" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        [_labelArr1 addObject:label1];
        
        
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

// 个人信息是否填写过
- (void)isComplete
{
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];

    [AFNetworking_RequestData requestMethodPOSTUrl:Is_complete dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
  
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            [self get_ui_info];

        }
        else {
            PersonalMessageVC *vc = [[PersonalMessageVC alloc] init];
            vc.title = @"个人信息";
            [self.navigationController pushViewController:vc animated:YES];
        }

        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self isComplete];

}

// 返回用户表该用户相关信息
- (void)get_ui_info
{

    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];

    [AFNetworking_RequestData requestMethodPOSTUrl:Get_ui_info dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {

        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
//        [InfoCache archiveObject:model toFile:Person];
        self.model = model;

        self.companyLab.text = model.title;
        
        CGSize size = [NSString textLength:model.cname font:self.nameLab.font];
        self.nameLab.width = size.width;
        self.nameLab.text = model.cname;
        
        self.emailLab.text = model.email;
        
        if (model.img.length > 0) {
            [self.logoBtn sd_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal];

        }

        
        self.levelView.frame = CGRectMake(self.nameLab.right+7, self.nameLab.top, 12, 20);
        if (model.vipLevel.integerValue == 0) {
            self.levelView.frame = CGRectMake(self.nameLab.right+7, self.nameLab.center.y-7, 20, 15);
            self.levelView.image = [UIImage imageNamed:@"63"];
        }
        if (model.vipLevel.integerValue == 1) {
            self.levelView.image = [UIImage imageNamed:@"65"];
        }
        if (model.vipLevel.integerValue == 2) {
            self.levelView.image = [UIImage imageNamed:@"64"];
        }

        self.levelBtn.left = self.levelView.right+7;
        //
        NSString *msgStr = [NSString stringWithFormat:@"%@+%@",model.msgReceive, model.msgSend];
        NSArray *titleArr = @[model.resumeLeft,model.vipTime,msgStr];
        int i=0;
        for (UILabel *label in _labelArr) {
            label.text = titleArr[i];
            
            if (i == 2) {
                
                // 该方法是从后往前查找
                [label wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#417504"] changeText:@"0"];
                [label wl_changeColorWithTextColor:[UIColor colorWithHexString:@"#333333"] changeText:@"+"];
            }

            i++;
        }
        
        //
        NSArray *titleArr1 = @[model.receiveResume,model.viewResume,model.favs];
        int j=0;
        for (UILabel *label in _labelArr1) {
            label.text = titleArr1[j];
            
            j++;
        }


    } failure:^(NSError *error) {

    }];
}

- (void)btnAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您已成功通知客服" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [okAction setValue:[UIColor colorWithHexString:@"#D0021B"] forKey:@"_titleTextColor"];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)btnAction1:(UIButton *)btn
{
    if (btn.tag == 2) {
        
        [self.view makeToast:[NSString stringWithFormat:@"接收%@条，发送%@条",self.model.msgReceive, self.model.msgSend]];
    }
    
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
    vc.title = @"公司详情";
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
