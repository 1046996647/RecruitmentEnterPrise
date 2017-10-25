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

    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(textView.left, (textView.bottom+102)*scaleWidth, kScreenWidth-textView.left*2, 40) text:@"提交" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [self.view addSubview:releseBtn];
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
