//
//  Company introduceVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CompanyintroduceVC.h"
#import "RegexTool.h"
#import "IQKeyboardManager.h"


@interface CompanyintroduceVC ()<UITextViewDelegate>

@property(nonatomic,strong) UITextView *tv;


@end

@implementation CompanyintroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(23, 16, kScreenWidth-23*2, (329-70)*scaleWidth)];
    [self.view addSubview:textView];
    textView.layer.cornerRadius = 7;
    textView.layer.masksToBounds = YES;
    textView.delegate = self;
    self.tv = textView;
    textView.text = self.text;
    
    CGSize constraintSize = CGSizeMake(self.tv.width, MAXFLOAT);
    CGSize size = [self.tv sizeThatFits:constraintSize];
    if (size.height+16 > kScreenHeight-kTopHeight) {
        self.tv.height = kScreenHeight-kTopHeight-16;
    }
    else {
        
        if (size.height+16 < (329-70)*scaleWidth) {
            self.tv.height = (329-70)*scaleWidth;

        }
        else {
            self.tv.height = size.height;

        }
    }
    
    if ([self.title isEqualToString:@"修改邮箱"]) {
        textView.height = 40;
    }

//    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(textView.left, (textView.bottom+102)*scaleWidth, kScreenWidth-textView.left*2, 40) text:@"提交" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
//    releseBtn.layer.cornerRadius = 7;
//    releseBtn.layer.masksToBounds = YES;
//    [self.view addSubview:releseBtn];
//    [releseBtn addTarget:self action:@selector(upAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 40, 40) text:@"提交" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:nil normal:@"" selected:nil];
    [releseBtn addTarget:self action:@selector(upAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releseBtn];
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
    [self.view endEditing:YES];
    
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

#pragma mark - keyboardHight
-(void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
    [IQKeyboardManager sharedManager].enable = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [IQKeyboardManager sharedManager].enable = YES;
    
}
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWillShown:(NSNotification*)aNotification
{
    
//    NSDictionary *info = [aNotification userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
    
//    _words.height = kScreenHeight-_words.top-keyboardSize.height-kTopHeight;
    _tv.height = (329-70)*scaleWidth;

}
//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
//    _words.height = (329-70)*scaleWidth;
    CGSize constraintSize = CGSizeMake(self.tv.width, MAXFLOAT);
    CGSize size = [self.tv sizeThatFits:constraintSize];
    if (size.height+16 > kScreenHeight-kTopHeight) {
        self.tv.height = kScreenHeight-kTopHeight-16;
    }
    else {
        
        if (size.height+16 < (329-70)*scaleWidth) {
            self.tv.height = (329-70)*scaleWidth;
            
        }
        else {
            self.tv.height = size.height;
            
        }
        
    }
    
}

@end
