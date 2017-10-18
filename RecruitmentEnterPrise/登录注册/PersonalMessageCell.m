//
//  EditJobMsgCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalMessageCell.h"
#import "NSStringExt.h"
//#import "ChangePhoneVC.h"
#import "NSDate+BRAdd.h"


@implementation PersonalMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        
        _tf = [UITextField textFieldWithframe:CGRectMake(48, 0, kScreenWidth-43-12, 40) placeholder:nil font:nil leftView:nil backgroundColor:@"#FFFFFF"];
        _tf.font = [UIFont systemFontOfSize:13];
        [_tf setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
        [_tf setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];

        [self.contentView addSubview:_tf];
        [_tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
        
        UIButton *saveBtn = [UIButton buttonWithframe:_tf.bounds text:nil font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
        [saveBtn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:saveBtn];
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
        [_model.title isEqualToString:@"点击获取公司地址"]||
//        [_model.title isEqualToString:@"专业名称"]||
//        [_model.title isEqualToString:@"姓名"]||
//        [_model.title isEqualToString:@"意向岗位"]||
//        [_model.title isEqualToString:@"E-mail"]||
//        [_model.title isEqualToString:@"姓名"]||
//        [_model.title isEqualToString:@"身高(选填)"]||
//        [_model.title isEqualToString:@"籍贯"]||
//        [_model.title isEqualToString:@"证件号码(选填)"]||
//        [_model.title isEqualToString:@"体重(选填)"]||
//        [_model.title isEqualToString:@"期望职位"]||
//        [_model.title isEqualToString:@"相关证书(选填)"]||
//        [_model.title isEqualToString:@"其他能力(选填)"]||
////        [_model.title isEqualToString:@"手机"]||
//        [_model.title isEqualToString:@"电话(选填)"]||
//        [_model.title isEqualToString:@"QQ号码(选填)"]||
//        [_model.title isEqualToString:@"邮箱(选填)"]||
//        [_model.title isEqualToString:@"联系地址"]||
        [_model.title isEqualToString:@"联系电话"]) {
        
        self.saveBtn.hidden = YES;
        self.imgView.hidden = YES;

        if ([_model.title isEqualToString:@"点击获取公司地址"]) {
            [_tf setValue:[UIColor colorWithHexString:@"#D0021B"] forKeyPath:@"_placeholderLabel.textColor"];
            
        }
    }
    else {
        
        self.saveBtn.hidden = NO;
        self.imgView.hidden = NO;
        
        

    }
}

- (void)pushAction
{
    // 收起键盘有效
    [self.viewController.view endEditing:YES];
    
    if ([_model.title isEqualToString:@"手机"]) {
//        ChangePhoneVC *vc = [[ChangePhoneVC alloc] init];
//        vc.title = @"修改手机";
//        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else {
        if ([_model.title isEqualToString:@"入职时间"]||
            [_model.title isEqualToString:@"离职时间"]||
            [_model.title isEqualToString:@"入学时间"]||
            [_model.title isEqualToString:@"毕业时间"]||
            [_model.title isEqualToString:@"出生日期"]||
            [_model.title isEqualToString:@"生日"]) {
            
//            [BRDatePickerView showDatePickerWithTitle:nil dateType:UIDatePickerModeDate defaultSelValue:_tf.text minDateStr:@"" maxDateStr:[NSDate currentDateString] isAutoSelect:NO resultBlock:^(NSString *selectValue) {
//                _tf.text = selectValue;
//
//                _model.text = _tf.text;
//
//            }];
            
            return;
            
        }
        
        
        if ([_model.title isEqualToString:@"性别"]) {
            self.dataSource = @[@"男",@"女"];
            
        }
        
        if ([_model.title isEqualToString:@"人才类型"]) {
            self.dataSource = @[@"往届",@"应届"];
            
        }
        
        if ([_model.title isEqualToString:@"最高学历"]||
            [_model.title isEqualToString:@"学历"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_edu"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"第一外语"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_lang"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"外语水平"]||
            [_model.title isEqualToString:@"计算机水平"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_level"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"工作年限"]||
            [_model.title isEqualToString:@"工作经验"]) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_years"]) {
                    
                    NSString *str = dic[@"data"];
                    NSArray *arr = [str componentsSeparatedByString:@","];
                    
                    for (NSString *s in arr) {
                        NSString *s1 = [NSString stringWithFormat:@"%@年",s];
                        [arrM addObject:s1];
                    }
                    self.dataSource = arrM;
                    break;
                }
            }
            
        }
        if ([_model.title isEqualToString:@"期望月薪"]||
            [_model.title isEqualToString:@"待遇要求"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_pay"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"民族"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_nation"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
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
        
        if ([_model.title isEqualToString:@"婚姻状况"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_marry"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"证件类型(选填)"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_cred"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"政治面貌(选填)"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_political"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"工作类型"]||
            [_model.title isEqualToString:@"求职类型"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_jobs"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        if ([_model.title isEqualToString:@"到岗状况"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_times"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"住房要求"]) {
            for (NSDictionary *dic in self.selectArr) {
                if ([dic[@"name"] isEqualToString:@"comp_house"]) {
                    
                    NSString *str = dic[@"data"];
                    self.dataSource = [str componentsSeparatedByString:@","];
                    break;
                }
            }
        }
        
        if ([_model.title isEqualToString:@"意向城市"]||
            [_model.title isEqualToString:@"所在地"]||
            [_model.title isEqualToString:@"期望地区"]) {
            self.dataSource = @[@"义乌市", @"东阳市", @"金华市",@"浦江县",@"永康市",@"慈溪市",@"余姚市"];
        }
        
        // 岗位类别
        if ([_model.title isEqualToString:@"岗位类别"]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            for (NSDictionary *dic in self.selectJobArr) {
                
                [arrM addObject:dic[@"name"]];
                
            }
            self.dataSource = arrM;
        }
        
//        [BRStringPickerView showStringPickerWithTitle:nil dataSource:self.dataSource defaultSelValue:self.dataSource[0] isAutoSelect:NO resultBlock:^(id selectValue) {
//
//            _tf.text = selectValue;
//            _model.text = selectValue;
//
//            if ([_model.title isEqualToString:@"工作年限"]||
//                [_model.title isEqualToString:@"工作经验"]) {
//
//                _model.text = [_model.text substringToIndex:_model.text.length-1];
//                NSLog(@"-----%@",selectValue);
//
//            }
//            ////        if ([_model.title isEqualToString:@"性别"] ||
//            ////            [_model.title isEqualToString:@"人才类型"]||
//            ////            [_model.title isEqualToString:@"意向城市"]||
//            ////            [_model.title isEqualToString:@"所在地"]||
//            ////            [_model.title isEqualToString:@"期望地区"]) {
//            //        if ([_model.title isEqualToString:@"意向城市"]||
//            //            [_model.title isEqualToString:@"所在地"]||
//            //            [_model.title isEqualToString:@"期望地区"]||
//            //            [_model.title isEqualToString:@"公司性质"]) {
//            //
//            //
//            //            _model.text = selectValue;
//            //
//            //        }
//            //        else {
//            //            _model.text = [NSString stringWithFormat:@"%ld",[self.dataSource indexOfObject:selectValue]+1];
//
//            //        }
//
//        }];
    }
    
    

}


- (void)changeAction:(UITextField *)tf
{
    _model.text = tf.text;

}

@end
