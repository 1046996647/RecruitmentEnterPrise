//
//  LoginVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetPassword1VC.h"
#import "AppDelegate.h"
#import "RegexTool.h"


#define kCountDownForVerifyCode @"CountDownForVerifyCode"


@interface LoginVC ()

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;
@property(nonatomic,strong) UITextField *validate;
@property (nonatomic, strong) UIButton *countDownButton;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight) icon:@"110"];
    [self.view addSubview:imgView];
    
    UIButton *backBtn = [UIButton buttonWithframe:CGRectMake(20, kStatusBarHeight+(44-30)/2, 30, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"" selected:nil];
    [self.view addSubview:backBtn];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *label = [UILabel labelWithframe:CGRectMake((kScreenWidth-200)/2, backBtn.bottom-15, 200, 18) text:@"登录" font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#000000"];
    [self.view addSubview:label];
    

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 40)];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, leftView.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];

    UIImageView *imgView1 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"86"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    imgView1.center = leftView1.center;

    [leftView1 addSubview:imgView1];
    [leftView addSubview:leftView1];
    
    _phone = [UITextField textFieldWithframe:CGRectMake(25, label.bottom+41, kScreenWidth-50, leftView.height) placeholder:@"请输入手机号" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    _phone.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _phone.layer.masksToBounds = YES;
    [self.view addSubview:_phone];

    
    _phone.text = [InfoCache unarchiveObjectWithFile:@"phone"];

    
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, leftView.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, leftView.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView2 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"85"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    imgView2.center = leftView1.center;

    [leftView1 addSubview:imgView2];
    [leftView addSubview:leftView1];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, _phone.height)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
//    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"88"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];

    
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+15, _phone.width, _phone.height) placeholder:@"请输入密码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = rightView;
    _password.secureTextEntry = YES;
    
    // 验证码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, _phone.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, _phone.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView3 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"84"];
    imgView3.contentMode = UIViewContentModeScaleAspectFit;
    imgView3.center = leftView1.center;
    
    [leftView1 addSubview:imgView3];
    [leftView addSubview:leftView1];
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 87+13, _phone.height)];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    self.countDownButton = rightBtn;
    [self.countDownButton addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];

    
    _validate = [UITextField textFieldWithframe:CGRectMake(_phone.left, _password.bottom+15, _phone.width, _phone.height) placeholder:@"请输入验证码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _validate.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _validate.layer.masksToBounds = YES;
    [self.view addSubview:_validate];
    _validate.rightViewMode = UITextFieldViewModeAlways;
    _validate.rightView = rightView;

    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, _validate.bottom+33, _phone.width, _phone.height) text:@"登录" font:[UIFont systemFontOfSize:16] textColor:@"FFFFFF" backgroundColor:@"#D0021B" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(loginBtn.left+5, loginBtn.bottom+16, 50, 14) text:@"立即注册" font:[UIFont systemFontOfSize:12] textColor:@"FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(loginBtn.right-registerBtn.width-5, registerBtn.top, registerBtn.width, registerBtn.height) text:@"忘记密码" font:[UIFont systemFontOfSize:12] textColor:@"FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    
    //倒计时通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(countDownUpdate:) name:@"CountDownUpdate" object:nil];
    
    // 登录通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifLoginAction) name:@"kLoginNotification" object:nil];
    
    // 获取选择项数据
    [self getCities];
    [self getSelectItems];
    [self getSelectItemJob];
    [self getSelectItemJob1];

}

- (void)viewAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _password.secureTextEntry = NO;
    }
    else {
        _password.secureTextEntry = YES;
        
    }
}


- (void)loginAction
{
    
    [self.view endEditing:YES];
    
    
    if (self.phone.text.length == 0 ||
        self.password.text.length == 0||
        self.validate.text.length == 0) {
        [self.view makeToast:@"您还有内容未填写完整"];
        return;
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"phone"];
    [paramDic  setValue:self.password.text forKey:@"passwd"];
    [paramDic  setValue:self.validate.text forKey:@"verify"];
    [paramDic  setValue:[InfoCache unarchiveObjectWithFile:@"pushToken"] forKey:@"deviceToken"];
    [paramDic  setValue:@"ios" forKey:@"deviceType"];

    [AFNetworking_RequestData requestMethodPOSTUrl:Login dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        
        [InfoCache archiveObject:responseObject[@"token"] toFile:@"token"];
        [InfoCache archiveObject:responseObject[@"data"][@"userid"] toFile:@"userid"];
        [InfoCache archiveObject:responseObject[@"data"][@"siteId"] toFile:@"siteId"];
        [InfoCache archiveObject:self.phone.text toFile:@"phone"];

        
        // 云信
        [InfoCache archiveObject:responseObject[@"data"][@"accToken"] toFile:@"accToken"];
        [InfoCache archiveObject:responseObject[@"data"][@"accid"] toFile:@"accid"];
        [[NIMSDK sharedSDK].loginManager login:responseObject[@"data"][@"accid"] token:responseObject[@"data"][@"accToken"] completion:^(NSError *error) {
            if (!error) {
                NSLog(@"登录成功");
                [InfoCache saveValue:@1 forKey:@"LoginedState"];

                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                TabBarController *tabVC = [[TabBarController alloc] init];
                delegate.tabVC = tabVC;
                delegate.window.rootViewController = tabVC;
                
            }else{
                NSLog(@"登录失败");
            }
        }];

    } failure:^(NSError *error) {
        
    }];
    
}

- (void)getCodeAction
{
    [self.view endEditing:YES];
    
    if (![RegexTool checkPhone:self.phone.text]) {
        [self.view makeToast:@"无效的手机号"];
        return;
    }
    
    // 开始计时
    [CountDownServer startCountDown:60 identifier:kCountDownForVerifyCode];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"phone"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:VerifyCode dic:paramDic showHUD:YES response:YES Succed:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            NSString *message = [responseObject objectForKey:@"message"];
            [self.view makeToast:message];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)forgetAction
{
    ForgetPassword1VC *vc = [[ForgetPassword1VC alloc] init];
    vc.title = @"忘记密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerAction
{
    RegisterVC *vc = [[RegisterVC alloc] init];
    vc.title = @"注册";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    _phone.text = [InfoCache unarchiveObjectWithFile:@"phone"];

    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// 获取分站数据
- (void)getCities
{
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_sites dic:nil showHUD:NO response:NO  Succed:^(id responseObject) {
        
        NSArray *cityArr = responseObject[@"data"];
        [InfoCache archiveObject:cityArr toFile:SelectItemCity];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)getSelectItems
{
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_setting dic:nil showHUD:NO response:NO Succed:^(id responseObject) {
        
        NSArray *selectArr = responseObject[@"data"];
        [InfoCache archiveObject:selectArr toFile:SelectItem];
        
    } failure:^(NSError *error) {
        
    }];
    
}

// 获取行业数据
- (void)getSelectItemJob
{
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_jobs_cate dic:nil showHUD:NO response:NO Succed:^(id responseObject) {
        
        NSArray *selectArr = responseObject[@"data"];
        [InfoCache archiveObject:selectArr toFile:SelectItemJob];
        
    } failure:^(NSError *error) {
        
    }];
    
}

// 获取职位类别数据
- (void)getSelectItemJob1
{
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_jobs_cate1 dic:nil showHUD:NO response:NO Succed:^(id responseObject) {
        
        NSArray *selectArr = responseObject[@"data"];
        [InfoCache archiveObject:selectArr toFile:SelectItemJob1];
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
