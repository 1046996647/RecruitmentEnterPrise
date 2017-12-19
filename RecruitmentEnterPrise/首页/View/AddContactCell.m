//
//  AddContactCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AddContactCell.h"
#import "CompanyAddressVC.h"
#import "ContactManageVC.h"

@implementation AddContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(22, 15, 200, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_nameLab];
        
        // 联系人管理
        _contactBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-120-10, _nameLab.center.y-15, 120, 30) text:@"联系人管理" font:[UIFont systemFontOfSize:14] textColor:@"#D0021B" backgroundColor:nil normal:@"" selected:@""];
        [self.contentView addSubview:_contactBtn];
        [_contactBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImageView *imgView1 = [UIImageView imgViewWithframe:CGRectMake(_contactBtn.width-12-6, (_contactBtn.height-12)/2, 6, 12) icon:@"44"];
        [_contactBtn addSubview:imgView1];
        
        //
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 38)];
        
        _tf1 = [UITextField textFieldWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+12, kScreenWidth-_nameLab.left*2, 38) placeholder:@"" font:[UIFont systemFontOfSize:13] leftView:leftView backgroundColor:nil];
//        _tf1.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
//        _tf1.layer.borderWidth = .5;
        [_tf1 setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
        [_tf1 setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        _tf1.layer.cornerRadius = 10;
        _tf1.layer.masksToBounds = YES;
        [self.contentView addSubview:_tf1];
        [_tf1 addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
        
        _tf1.background = [UIImage imageNamed:@"Group"];
        _tf1.rightViewMode = UITextFieldViewModeAlways;
        
        _selectBtn = [UIButton buttonWithframe:_tf1.bounds text:@"" font:nil textColor:nil backgroundColor:nil normal:@"" selected:@""];
        [_tf1 addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];

        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(_selectBtn.width-12-6, (_selectBtn.height-12)/2, 6, 12) icon:@"44"];
        [_selectBtn addSubview:imgView];
        
        _addressBtn = [UIButton buttonWithframe:CGRectMake(0, 0, _tf1.height, _tf1.height) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"40" selected:@""];
        [_addressBtn addTarget:self action:@selector(addressAction) forControlEvents:UIControlEventTouchUpInside];
        

    }
    
    return self;
    
}

- (void)contactAction
{
    ContactManageVC *vc = [[ContactManageVC alloc] init];
    vc.title = @"联系人管理";
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)addressAction
{
    CompanyAddressVC *vc = [[CompanyAddressVC alloc] init];
    vc.title = @"公司地址";
    [self.viewController.navigationController pushViewController:vc animated:YES];
    vc.block = ^(NSString *text) {
        
        _tf1.text = text;
        _model.text = text;
    };
}

- (void)pushAction
{
    // 收起键盘有效
    [self.viewController.view endEditing:YES];
    
    
    if ([_model.title isEqualToString:@"公司性质"]) {
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"user_company"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }
    
    
    // 岗位类别
    if ([_model.title isEqualToString:@"所属行业"]) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dic in self.selectJobArr) {
            
            [arrM addObject:dic[@"name"]];
            
        }
        self.dataSource = arrM;
    }
    
    [BRStringPickerView showStringPickerWithTitle:nil dataSource:self.dataSource defaultSelValue:self.dataSource[0] isAutoSelect:NO resultBlock:^(id selectValue) {
        
        _tf1.text = selectValue;
        _model.text = selectValue;
        
        
    }];
    
    
    
}

- (void)setModel:(AddContactModel *)model
{
    _model = model;
    
    _nameLab.text = model.title;
    _tf1.placeholder = model.placeTitle;
    _tf1.text = model.text;
    
    if ([_model.title isEqualToString:@"所属行业"] || [_model.title isEqualToString:@"公司性质"]) {
        _selectBtn.hidden = NO;

    }
    else {

        _selectBtn.hidden = YES;
    }
    
    if ([_model.title isEqualToString:@"公司地址"]) {
        
        _tf1.rightView = _addressBtn;
        
    }
    else {
        _tf1.rightView = nil;

    }
    
    if ([_model.title isEqualToString:@"招聘负责人"]) {
        
        _contactBtn.hidden = NO;
        
    }
    else {
        _contactBtn.hidden = YES;

    }

}

- (void)changeAction:(UITextField *)tf
{
    _model.text = tf.text;
    
}

@end
