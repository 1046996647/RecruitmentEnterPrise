//
//  PostsJobVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PostsJobVC.h"
#import "CompanyintroduceVC.h"

@interface PostsJobVC ()

@property(nonatomic,strong) UILabel *mailLab1;
@property(nonatomic,strong) UILabel *phoneLab;

@end

@implementation PostsJobVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 手机号
    UIButton *exitBtn = [UIButton buttonWithframe:CGRectMake(0, 10, kScreenWidth, 50) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:exitBtn];
    exitBtn.tag = 0;
    [exitBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *exitBtn1 = [UIButton buttonWithframe:CGRectMake(20, 0, 90, exitBtn.height) text:@"分配职位" font:SystemFont(13) textColor:@"#999999" backgroundColor:@"#FFFFFF" normal:@"14" selected:nil];
    [exitBtn addSubview:exitBtn1];
    exitBtn1.userInteractionEnabled = NO;
    exitBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    exitBtn1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    exitBtn1.backgroundColor = [UIColor redColor];
    
    UIImageView *exitView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, exitBtn1.center.y-6, 6, 12) icon:@"44"];
    exitView.contentMode = UIViewContentModeScaleAspectFit;
    [exitBtn addSubview:exitView];
    
    // 18842682580
    UILabel *phoneLab = [UILabel labelWithframe:CGRectMake(110, 0, exitView.left-110-10, exitBtn.height) text:@"" font:SystemFont(13) textAlignment:NSTextAlignmentRight textColor:@"#999999"];
    [exitBtn addSubview:phoneLab];
    //    phoneLab.text = self.model.phone;
    self.phoneLab = phoneLab;
    
    // E-mail
    UIButton *mailBtn = [UIButton buttonWithframe:CGRectMake(exitBtn.left, exitBtn.bottom+ 1, kScreenWidth, exitBtn.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [self.view addSubview:mailBtn];
    mailBtn.tag = 1;
    [mailBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *mailBtn1 = [UIButton buttonWithframe:CGRectMake(20, 0, 90, exitBtn.height) text:@"备注" font:SystemFont(13) textColor:@"#999999" backgroundColor:@"#FFFFFF" normal:@"13" selected:nil];
    [mailBtn addSubview:mailBtn1];
    mailBtn1.userInteractionEnabled = NO;
    mailBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    mailBtn1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    UIImageView *mailView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, mailBtn1.center.y-6, 6, 12) icon:@"44"];
    mailView.contentMode = UIViewContentModeScaleAspectFit;
    [mailBtn addSubview:mailView];
    
    // 356335205@qq.com
    UILabel *mailLab1 = [UILabel labelWithframe:CGRectMake(110, 0, exitView.left-110-10, exitBtn.height) text:@"" font:SystemFont(13) textAlignment:NSTextAlignmentRight textColor:@"#999999"];
    [mailBtn addSubview:mailLab1];
    self.mailLab1 = mailLab1;
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, (mailBtn.bottom+38)*scaleWidth, kScreenWidth-50, 40) text:@"提交" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [self.view addSubview:releseBtn];
//    [releseBtn addTarget:self action:@selector(upAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {

        
    }
    if (btn.tag == 1) {
        
        CompanyintroduceVC *vc = [[CompanyintroduceVC alloc] init];
        vc.title = @"备注";
        vc.text = self.mailLab1.text;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *text) {
            
            self.mailLab1.text = text;
        };
        
    }
    
    
}

@end
