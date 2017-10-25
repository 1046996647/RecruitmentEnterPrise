//
//  ForgetPasswordVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ForgetPasswordVC.h"

@interface ForgetPasswordVC ()

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;
@property(nonatomic,strong) UITextField *validate;


@end

@implementation ForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat screenHeight = 0;
    CGFloat statusBar = 0;
    
    if (Device_Is_iPhoneX) {
        screenHeight  = kScreenHeight+24;
        statusBar  = 44;
    }
    else {
        screenHeight  = kScreenHeight;
        statusBar  = 20;
        
    }
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, kScreenWidth, screenHeight) icon:@"110"];
    [self.view addSubview:imgView];
    
    UIButton *backBtn = [UIButton buttonWithframe:CGRectMake(20, statusBar+(44-30)/2, 30, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"49" selected:nil];
    [self.view addSubview:backBtn];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [UILabel labelWithframe:CGRectMake((kScreenWidth-200)/2, backBtn.bottom-15, 200, 18) text:self.title font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#000000"];
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
    _phone.leftViewMode = UITextFieldViewModeAlways;
    _phone.leftView = leftView;
    
    _phone.text = [InfoCache unarchiveObjectWithFile:@"userid"];
    
    
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
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = leftView;
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
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.borderColor = [UIColor colorWithHexString:@"#D0374A"].CGColor;
    rightBtn.layer.borderWidth = .5;
    [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#D0374A"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [rightView addSubview:rightBtn];
    
    _validate = [UITextField textFieldWithframe:CGRectMake(_phone.left, _password.bottom+15, _phone.width, _phone.height) placeholder:@"请输入验证码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _validate.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _validate.layer.masksToBounds = YES;
    [self.view addSubview:_validate];
    _validate.rightViewMode = UITextFieldViewModeAlways;
    _validate.rightView = rightView;
    _validate.leftViewMode = UITextFieldViewModeAlways;
    _validate.leftView = leftView;
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, _validate.bottom+33, _phone.width, _phone.height) text:@"确认" font:[UIFont systemFontOfSize:16] textColor:@"FFFFFF" backgroundColor:@"#D0021B" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    

    
    
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
    

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
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

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
