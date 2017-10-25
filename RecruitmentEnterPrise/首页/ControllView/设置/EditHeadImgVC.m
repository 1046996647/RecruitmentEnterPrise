//
//  EditHeadImgVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditHeadImgVC.h"

@interface EditHeadImgVC ()


@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UIButton *forgetBtn1;


@end

@implementation EditHeadImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 167)];
    _baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseView];
    
    NSArray *imgArr = @[@"39",@"38"];
    NSArray *titleArr1 = @[@"拍摄照片",@"相册照片"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreenWidth/2, 0, kScreenWidth/2, 125) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [_baseView addSubview:forgetBtn];
        self.forgetBtn1 = forgetBtn;
        [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.tag = i;
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 23, forgetBtn.width, 65) icon:imgArr[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [forgetBtn addSubview:imgView];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, imgView.bottom+8, forgetBtn.width, 17) text:titleArr1[i] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.forgetBtn1.bottom, kScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
    [_baseView addSubview:line];
    
    UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(0, line.bottom, kScreenWidth, 40) text:@"取消" font:[UIFont systemFontOfSize:17] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [_baseView addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    //延迟1秒执行这个方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self delayAction];
    });
    
}

- (void)cancelAction
{
    [UIView animateWithDuration:.35 animations:^{
        _baseView.top = kScreenHeight;
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)delayAction
{
    [UIView animateWithDuration:.5 animations:^{
        _baseView.top = kScreenHeight-_baseView.height;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (_clickBlock) {
            _clickBlock(btn.tag);
        }
        
    }];
}

//点击蒙版 蒙版退下
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([touches anyObject].view == self.view) {
        
        [UIView animateWithDuration:.35 animations:^{
            _baseView.top = kScreenHeight;
        } completion:^(BOOL finished) {
            
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
    
}

@end
