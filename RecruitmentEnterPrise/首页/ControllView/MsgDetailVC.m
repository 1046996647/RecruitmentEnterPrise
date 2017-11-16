//
//  MsgDetailVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MsgDetailVC.h"
#import "NSStringExt.h"

@interface MsgDetailVC ()

@end

@implementation MsgDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake((kScreenWidth-341*scaleWidth)/2, 20, 341*scaleWidth, 560*scaleWidth) icon:@"Combined Shape"];
    [self.view addSubview:imgView];
    
    UIButton *postBtn = [UIButton buttonWithframe:CGRectMake(30, 24, imgView.width-30-12, 17) text:@"发件人：众信人才网" font:SystemFont(12) textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"19" selected:nil];
    [imgView addSubview:postBtn];
    postBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    postBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    
    UIButton *receiveBtn = [UIButton buttonWithframe:CGRectMake(postBtn.left, postBtn.bottom+21, postBtn.width, postBtn.height) text:@"收件人：陈先生" font:SystemFont(12) textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"18" selected:nil];
    [imgView addSubview:receiveBtn];
    receiveBtn.contentHorizontalAlignment = postBtn.contentHorizontalAlignment;
    receiveBtn.titleEdgeInsets = postBtn.titleEdgeInsets;
    
    NSString *userid = [InfoCache unarchiveObjectWithFile:@"userid"];

    if (_mark == 0) {
        [postBtn setTitle:[NSString stringWithFormat:@"发件人：%@",_model.name] forState:UIControlStateNormal];
        [receiveBtn setTitle:[NSString stringWithFormat:@"收件人：%@",userid] forState:UIControlStateNormal];
    }
    else {
        [postBtn setTitle:[NSString stringWithFormat:@"发件人：%@",userid] forState:UIControlStateNormal];
        [receiveBtn setTitle:[NSString stringWithFormat:@"收件人：%@",_model.name] forState:UIControlStateNormal];
    }
    
    UIButton *typeBtn = [UIButton buttonWithframe:CGRectMake(postBtn.left, receiveBtn.bottom+21, postBtn.width, postBtn.height) text:[NSString stringWithFormat:@"类型：%@",_model.type] font:SystemFont(12) textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"2" selected:nil];
    [imgView addSubview:typeBtn];
    typeBtn.contentHorizontalAlignment = postBtn.contentHorizontalAlignment;
    typeBtn.titleEdgeInsets = postBtn.titleEdgeInsets;
    
    UIButton *contentBtn = [UIButton buttonWithframe:CGRectMake(postBtn.left, typeBtn.bottom+21, 16, postBtn.height) text:@"" font:SystemFont(12) textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"1" selected:nil];
    [imgView addSubview:contentBtn];
    
    UILabel *contentLab = [UILabel labelWithframe:CGRectMake(contentBtn.right+12, contentBtn.top, imgView.width-(contentBtn.right+12)-12, postBtn.height) text:[NSString stringWithFormat:@"内容：%@",_model.info] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    contentLab.numberOfLines = 0;
    [imgView addSubview:contentLab];
    
    CGSize size = [NSString textHeight:contentLab.text font:contentLab.font width:contentLab.width];
    contentLab.height = size.height;
    
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
