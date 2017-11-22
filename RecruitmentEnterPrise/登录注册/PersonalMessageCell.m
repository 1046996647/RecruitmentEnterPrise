//
//  EditJobMsgCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalMessageCell.h"
#import "NSStringExt.h"
#import "NSDate+BRAdd.h"
#import "CompanyAddressVC.h"
#import "CompanyintroduceVC.h"


@implementation PersonalMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        
        _tf = [UITextField textFieldWithframe:CGRectMake(48, 0, kScreenWidth-43-30, 40) placeholder:nil font:nil leftView:nil backgroundColor:@"#FFFFFF"];
        _tf.font = [UIFont systemFontOfSize:13];
        [_tf setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
        [_tf setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];

        [self.contentView addSubview:_tf];
        [_tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
        
        UIButton *saveBtn = [UIButton buttonWithframe:_tf.bounds text:nil font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
        [saveBtn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        [_tf addSubview:saveBtn];
        saveBtn.hidden = YES;
        self.saveBtn = saveBtn;
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, (40-12)/2, 6, 12) icon:@"44"];
        [self.contentView addSubview:_imgView];

    }
    return self;
}

- (void)setModel:(PersonModel *)model
{
    _model = model;
    
    self.imageView.image = [UIImage imageNamed:model.image];
    _tf.placeholder = model.title;
    _tf.text = model.text;
    
    if ([_model.title isEqualToString:@"公司名称"] ||
        [_model.title isEqualToString:@"招聘负责人"]||
//        [_model.title isEqualToString:@"点击获取公司地址"]||
//        [_model.title isEqualToString:@"专业名称"]||
//        [_model.title isEqualToString:@"姓名"]||
//        [_model.title isEqualToString:@"意向岗位"]||
//        [_model.title isEqualToString:@"E-mail"]||
//        [_model.title isEqualToString:@"姓名"]||
//        [_model.title isEqualToString:@"身高(选填)"]||
//        [_model.title isEqualToString:@"籍贯"]||

        [_model.title isEqualToString:@"联系电话"]) {
        
        self.saveBtn.hidden = YES;
        self.imgView.hidden = YES;


    }
    else {
        
        self.saveBtn.hidden = NO;
        
        if ([_model.title isEqualToString:@"点击获取公司地址"]) {
            [_tf setValue:[UIColor colorWithHexString:@"#D0021B"] forKeyPath:@"_placeholderLabel.textColor"];
            self.imgView.hidden = YES;

        }
        else {
            self.imgView.hidden = NO;

        }

    }
}

- (void)pushAction
{
    // 收起键盘有效
    [self.viewController.view endEditing:YES];
    
    if ([_model.title isEqualToString:@"点击获取公司地址"]) {
        CompanyAddressVC *vc = [[CompanyAddressVC alloc] init];
        vc.title = @"公司地址";
        [self.viewController.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *text) {
            
            _tf.text = text;
            _model.text = text;
        };
        return;

    }
    
    if ([_model.title isEqualToString:@"公司简介"]) {
        CompanyintroduceVC *vc = [[CompanyintroduceVC alloc] init];
        vc.title = @"公司简介";
        vc.text = _tf.text;
        [self.viewController.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *text) {
            
            _tf.text = text;
            _model.text = text;
        };
        return;
        
    }
        
    
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

        _tf.text = selectValue;
        
        // 岗位类别
        if ([_model.title isEqualToString:@"所属行业"]) {
            for (NSDictionary *dic in self.selectJobArr) {
                
                if ([selectValue isEqualToString:dic[@"name"]]) {
                    _model.text = dic[@"cateId"];
                    
                }
                
            }
        }
        else {
            _model.text = selectValue;

        }

                 

    }];
    
    

}


- (void)changeAction:(UITextField *)tf
{
    _model.text = tf.text;

}

@end
