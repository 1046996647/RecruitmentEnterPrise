//
//  AddContactCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AddContactCell.h"

@implementation AddContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(22, 15, 200, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_nameLab];
        
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
        
        _selectBtn = [UIButton buttonWithframe:_tf1.bounds text:@"" font:nil textColor:nil backgroundColor:nil normal:@"" selected:@""];
        [_tf1 addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];

        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(_selectBtn.width-12-6, (_selectBtn.height-12)/2, 6, 12) icon:@"44"];
        [_selectBtn addSubview:imgView];
        
    }
    
    return self;
    
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

}

- (void)changeAction:(UITextField *)tf
{
    _model.text = tf.text;
    
}

@end
