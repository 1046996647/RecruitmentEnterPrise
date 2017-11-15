//
//  WordsVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "WordsVC.h"

@interface WordsVC ()

@property(nonatomic,strong) UITextView *words;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) UITextView *tv;


@end

@implementation WordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kTopHeight)];
    [self.view addSubview:scrollView];
    
    UILabel *titleLab = [UILabel labelWithframe:CGRectMake(29, 15, 150, 19) text:@"收信人：网站管理员" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [scrollView addSubview:titleLab];
    
    UILabel *typeLab = [UILabel labelWithframe:CGRectMake(titleLab.left, titleLab.bottom+21, 50, 19) text:@"类型：" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [scrollView addSubview:typeLab];
    
    CGFloat interval = 12;
    CGFloat aWidth = 52;
//    NSArray *imgArr = @[@"62",@"61",@"60",@"59",@"58"];
//    NSArray *selectedImgArr = @[@"62",@"61",@"60",@"59",@"58"];
    NSArray *titleArr2 = @[@"回复",@"咨询",@"建议",@"投诉",@"其他"];
    for (int i=0; i<titleArr2.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(typeLab.right +(i%4)*(aWidth+interval), typeLab.top+(i/4)*(20+interval), aWidth, 20) text:titleArr2[i] font:SystemFont(13) textColor:@"#333333" backgroundColor:nil normal:@"Group 2 Copy" selected:@"3"];
        [scrollView addSubview:forgetBtn];
        [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.tag = i;
        forgetBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        
        if (i == 0) {
            forgetBtn.selected = YES;
            self.lastBtn = forgetBtn;

        }
    }
    
    _words = [[UITextView alloc] initWithFrame:CGRectMake(22, typeLab.bottom+57, kScreenWidth-44, 329*scaleWidth)];
    _words.backgroundColor = [UIColor whiteColor];
    _words.layer.cornerRadius = 7;
    _words.layer.masksToBounds = YES;
    [scrollView addSubview:_words];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(_words.left, _words.bottom+37, kScreenWidth-_words.left*2, 40) text:@"发送" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [scrollView addSubview:releseBtn];
    [releseBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];

    
//    scrollView.contentSize = CGSizeMake(kScreenWidth, self.forgetBtn2.bottom);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn
{
    self.lastBtn.selected = NO;
    btn.selected = YES;

    self.lastBtn = btn;

}

- (void)sendAction
{
    if (_words.text.length == 0) {
        [self.view makeToast:@"请填写内容"];
        return;
    }
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [paramDic  setValue:self.lastBtn.currentTitle forKey:@"type"];
    [paramDic  setValue:_words.text forKey:@"info"];

    
    [AFNetworking_RequestData requestMethodPOSTUrl:Send_mess_admin dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

@end
