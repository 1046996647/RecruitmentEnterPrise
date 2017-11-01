//
//  ChangePhoneVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ChangePhoneVC.h"
#import "RegexTool.h"
#import "UIViewController+UIViewControllerExt.h"

#define kCountDownForVerifyCode @"CountDownForVerifyCode"

@interface ChangePhoneVC ()

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UITextField *tf1;
@property (nonatomic, strong) UIButton *countDownButton;


@end

@implementation ChangePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *leftLab = [UILabel labelWithframe:CGRectMake(0, 0, 137, 60) text:@"   手机号" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    
    _tf = [UITextField textFieldWithframe:CGRectMake(0, 0, kScreenWidth, leftLab.height) placeholder:@"请输入原号码" font:leftLab.font leftView:leftLab backgroundColor:@"#FFFFFF"];
    [_tf setValue:leftLab.font forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_tf setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_tf];
    
    leftLab = [UILabel labelWithframe:CGRectMake(0, 0, leftLab.width, leftLab.height) text:@"   验证码" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 87+13, leftLab.height)];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 87, 23);
    rightBtn.center = rightView.center;
    rightBtn.layer.cornerRadius = rightBtn.height/2;
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.borderColor = [UIColor colorWithHexString:@"#D0374A"].CGColor;
    rightBtn.layer.borderWidth = .5;
    [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#D0374A"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    self.countDownButton = rightBtn;
    
    _tf1 = [UITextField textFieldWithframe:CGRectMake(0, _tf.bottom+1, kScreenWidth, leftLab.height) placeholder:@"请输入验证码" font:leftLab.font leftView:leftLab backgroundColor:@"#FFFFFF"];
    [_tf1 setValue:leftLab.font forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_tf1 setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_tf1];
    _tf1.rightViewMode = UITextFieldViewModeAlways;
    _tf1.rightView = rightView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, _tf1.bottom, kScreenWidth, 34+40)];
    [self.view addSubview:footerView];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, 17, kScreenWidth-50, 40) text:@"下一步" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    [releseBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.mark == 1) {
        _tf.placeholder = @"请输入新号码";
        [releseBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    //倒计时通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(countDownUpdate:) name:@"CountDownUpdate" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCodeAction
{
    [self.view endEditing:YES];
    
    if (![RegexTool checkPhone:self.tf.text]) {
        [self.view makeToast:@"无效的手机号"];
        return;
    }
    
    // 开始计时
    [CountDownServer startCountDown:10 identifier:kCountDownForVerifyCode];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.tf.text forKey:@"phone"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:VerifyCode dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            NSString *message = [responseObject objectForKey:@"message"];
            [self.view makeToast:message];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)saveAction
{
    [self.view endEditing:YES];
    
    if (self.tf.text.length == 0 ||
        self.tf1.text.length == 0) {
        [self.view makeToast:@"您还有内容未填写完整"];
        return;
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    NSString *url = nil;
    if (self.mark == 0) {
        url = @"";
    }
    else {
        
        url = Alter_phone;

        [paramDic  setValue:self.tf.text forKey:@"phoneNew"];
        [paramDic  setValue:self.tf1.text forKey:@"verify"];
    }

    
    [AFNetworking_RequestData requestMethodPOSTUrl:url dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        if (self.mark == 0) {
            
            ChangePhoneVC *vc = [[ChangePhoneVC alloc] init];
            vc.title = @"修改手机";
            vc.mark = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            [self popViewController:@"CountMessageVC"];

        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark-验证码通知方法
- (void)countDownUpdate:(NSNotification *)noti
{
    NSString *identifier = [noti.userInfo objectForKey:@"CountDownIdentifier"];
    if ([identifier isEqualToString:kCountDownForVerifyCode]) {
        NSNumber *n = [noti.userInfo objectForKey:@"SecondsCountDown"];
        
        [self performSelectorOnMainThread:@selector(updateVerifyCodeCountDown:) withObject:n waitUntilDone:YES];
    }
}

- (void)updateVerifyCodeCountDown:(NSNumber *)num {
    
    if ([num integerValue] == 0){
        
        [self.countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.countDownButton.userInteractionEnabled = YES;
        self.countDownButton.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        self.countDownButton.layer.borderWidth = .5;
        [self.countDownButton setTitleColor:[UIColor colorWithHexString:@"#D0021B"] forState:UIControlStateNormal];
        
    } else {
        [self.countDownButton setTitle:[NSString stringWithFormat:@"%@后重新获取",num] forState:UIControlStateNormal];
        self.countDownButton.userInteractionEnabled = NO;
        self.countDownButton.layer.borderColor = [UIColor colorWithHexString:@"#848484"].CGColor;
        self.countDownButton.layer.borderWidth = .5;
        [self.countDownButton setTitleColor:[UIColor colorWithHexString:@"#848484"] forState:UIControlStateNormal];
    }
}

@end
