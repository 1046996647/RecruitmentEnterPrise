//
//  LoginVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RegisterVC.h"
#import "PersonalMessageVC.h"
#import "RegexTool.h"
#import "BRPickerView.h"

//#define kCountDownForVerifyCodeRegister @"CountDownForVerifyCode"
#define kCountDownForVerifyCodeRegister @"kCountDownForVerifyCodeRegister"

@interface RegisterVC ()

@property(nonatomic,strong) UITextField *user;
@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;
@property(nonatomic,strong) UITextField *okPassword;
@property(nonatomic,strong) UITextField *validate;
@property(nonatomic,strong) UITextField *selectCity;
@property (nonatomic, strong) UIButton *countDownButton;

@property(nonatomic,strong) NSArray *cityArr;
@property(nonatomic,strong) NSString *cityID;



@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight) icon:@"110"];
    [self.view addSubview:imgView];
    
    UIButton *backBtn = [UIButton buttonWithframe:CGRectMake(20, kStatusBarHeight+(44-30)/2, 30, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"49" selected:nil];
    [self.view addSubview:backBtn];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [UILabel labelWithframe:CGRectMake((kScreenWidth-200)/2, backBtn.bottom-15, 200, 18) text:@"注册" font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#000000"];
    [self.view addSubview:label];
    
    // 用户名
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 40)];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, leftView.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView0 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"82"];
    imgView0.contentMode = UIViewContentModeScaleAspectFit;
    imgView0.center = leftView1.center;
    
    [leftView1 addSubview:imgView0];
    [leftView addSubview:leftView1];
    
    _user = [UITextField textFieldWithframe:CGRectMake(25, label.bottom+41, kScreenWidth-50, leftView.height) placeholder:@"请输入用户名" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
//    _user.keyboardType = UIKeyboardTypeNumberPad;
    _user.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _user.layer.masksToBounds = YES;
    [self.view addSubview:_user];

    
    // 手机号
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 40)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, leftView.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView1 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"86"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    imgView1.center = leftView1.center;
    
    [leftView1 addSubview:imgView1];
    [leftView addSubview:leftView1];
    
    _phone = [UITextField textFieldWithframe:CGRectMake(25, _user.bottom+15, kScreenWidth-50, leftView.height) placeholder:@"请输入手机号" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    _phone.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _phone.layer.masksToBounds = YES;
    [self.view addSubview:_phone];

    
    
    // 验证码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, _phone.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, _phone.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView3 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"84"];
    imgView3.contentMode = UIViewContentModeScaleAspectFit;
    imgView3.center = leftView1.center;
    
    [leftView1 addSubview:imgView3];
    [leftView addSubview:leftView1];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 87+13, _phone.height)];
    
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
    
    _validate = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+15, _phone.width, _phone.height) placeholder:@"请输入验证码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _validate.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _validate.layer.masksToBounds = YES;
    [self.view addSubview:_validate];
    _validate.rightViewMode = UITextFieldViewModeAlways;
    _validate.rightView = rightView;

    
    // 密码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, leftView.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, leftView.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView2 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"85"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    imgView2.center = leftView1.center;
    
    [leftView1 addSubview:imgView2];
    [leftView addSubview:leftView1];
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, _phone.height)];
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
    //    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"88"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _validate.bottom+15, _phone.width, _phone.height) placeholder:@"请输入6-16位密码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = rightView;
    _password.secureTextEntry = YES;
    
    // 确认密码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, leftView.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, leftView.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView4 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"85"];
    imgView4.contentMode = UIViewContentModeScaleAspectFit;
    imgView4.center = leftView1.center;
    
    [leftView1 addSubview:imgView4];
    [leftView addSubview:leftView1];
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, _phone.height)];
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
    //    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"88"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _okPassword = [UITextField textFieldWithframe:CGRectMake(_phone.left, _password.bottom+15, _phone.width, _phone.height) placeholder:@"请确认密码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _okPassword.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _okPassword.layer.masksToBounds = YES;
    [self.view addSubview:_okPassword];
    _okPassword.rightViewMode = UITextFieldViewModeAlways;
    _okPassword.rightView = rightView;
    _okPassword.secureTextEntry = YES;
    
    // 选择城市
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, leftView.height)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, leftView.height)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView5 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"address"];
    imgView5.contentMode = UIViewContentModeScaleAspectFit;
    imgView5.center = leftView1.center;
    
    [leftView1 addSubview:imgView5];
    [leftView addSubview:leftView1];
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, _phone.height)];
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
    //    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"37"] forState:UIControlStateNormal];
//    [rightBtn setImage:[UIImage imageNamed:@"37"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    
    
    _selectCity = [UITextField textFieldWithframe:CGRectMake(_phone.left, _okPassword.bottom+15, _phone.width, _phone.height) placeholder:@"请选择城市" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _selectCity.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _selectCity.layer.masksToBounds = YES;
    [self.view addSubview:_selectCity];
    _selectCity.rightViewMode = UITextFieldViewModeAlways;
    _selectCity.rightView = rightView;
//    _selectCity.secureTextEntry = YES;
    [_selectCity setValue:[UIColor colorWithHexString:@"#D0021B"] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 替代
    UIButton *selectBtn = [UIButton buttonWithframe:_selectCity.bounds text:nil font:nil textColor:nil backgroundColor:nil normal:nil selected:nil];
    [_selectCity addSubview:selectBtn];
    [selectBtn addTarget:self action:@selector(cityAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, _selectCity.bottom+33, _phone.width, _phone.height) text:@"下一步" font:[UIFont systemFontOfSize:16] textColor:@"FFFFFF" backgroundColor:@"#D0021B" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];

    
    if ([self.title isEqualToString:@"注册"]) {
        UILabel *agreeLabel = [UILabel labelWithframe:CGRectMake(_password.left, loginBtn.bottom+16, 90, 14) text:@"注册即表示同意" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
        [self.view addSubview:agreeLabel];
        
        UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(agreeLabel.right, agreeLabel.top, 74, agreeLabel.height) text:@"《用户协议》" font:[UIFont systemFontOfSize:12] textColor:@"#D0021B" backgroundColor:nil normal:nil selected:nil];
        [self.view addSubview:registerBtn];
    }
    else {
        [loginBtn setTitle:@"确定" forState:UIControlStateNormal];

    }
    //倒计时通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(countDownUpdate:) name:@"CountDownUpdate" object:nil];
    
    // 选择项数据
    NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItemCity];;
    self.cityArr = selectArr;

}

- (void)cityAction
{
    [self.view endEditing:YES];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dic in self.cityArr) {
        [arrM addObject:dic[@"name"]];
    }
    
    [BRStringPickerView showStringPickerWithTitle:nil dataSource:arrM defaultSelValue:arrM[0] isAutoSelect:NO resultBlock:^(id selectValue) {
        
        _selectCity.text = selectValue;
        for (NSDictionary *dic in self.cityArr) {

            if ([selectValue isEqualToString:dic[@"name"]]) {
                self.cityID = dic[@"siteId"];
                break;
            }
        }
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
    [CountDownServer startCountDown:60 identifier:kCountDownForVerifyCodeRegister];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"phone"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:VerifyCode dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            NSString *message = [responseObject objectForKey:@"message"];
            [self.view makeToast:message];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
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


- (void)nextAction
{
    if ([self.title isEqualToString:@"注册"]) {

        [self.view endEditing:YES];

        if (self.user.text.length == 0 ||
            self.phone.text.length == 0||
            self.validate.text.length == 0||
            self.password.text.length == 0||
            self.selectCity.text.length == 0) {
            [self.view makeToast:@"您还有内容未填写完整"];
            return;
        }
        
        if (![self.password.text isEqualToString:self.okPassword.text]) {
            [self.view makeToast:@"密码不一致"];
            return;

        }
        
        NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
        [paramDic  setValue:self.user.text forKey:@"userid"];
        [paramDic  setValue:self.phone.text forKey:@"phone"];
        [paramDic  setValue:self.validate.text forKey:@"verify"];
        [paramDic  setValue:self.password.text forKey:@"passwd"];
        [paramDic  setValue:self.cityID forKey:@"siteId"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:Regist dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
            
            [InfoCache archiveObject:responseObject[@"data"][@"userid"] toFile:@"userid"];
            [InfoCache archiveObject:responseObject[@"data"][@"siteId"] toFile:@"siteId"];
            [InfoCache archiveObject:responseObject[@"token"] toFile:@"token"];
            [InfoCache archiveObject:self.phone.text toFile:@"phone"];
            
            //                // 登录通知
            //                [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginNotification" object:self.title];
            
            PersonalMessageVC *vc = [[PersonalMessageVC alloc] init];
            vc.title = @"个人信息";
            [self.navigationController pushViewController:vc animated:YES];

  
        } failure:^(NSError *error) {
            
        }];
        
        

    }
    else {
        
    }
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


#pragma mark-验证码通知方法
- (void)countDownUpdate:(NSNotification *)noti
{
    NSString *identifier = [noti.userInfo objectForKey:@"CountDownIdentifier"];
    if ([identifier isEqualToString:kCountDownForVerifyCodeRegister]) {
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

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
