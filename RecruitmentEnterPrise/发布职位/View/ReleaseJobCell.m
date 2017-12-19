//
//  ReleaseJobCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReleaseJobCell.h"
#import "ContactManageVC.h"
#import "TagViewVC.h"

@implementation ReleaseJobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        
        _leftLab = [UILabel labelWithframe:CGRectMake(12, 14, 100, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_leftLab];
        
        _tf = [UITextField textFieldWithframe:CGRectMake(_leftLab.right+10, 0, kScreenWidth-(_leftLab.right+10)-12, 44) placeholder:nil font:nil leftView:nil backgroundColor:@"#FFFFFF"];
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
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(saveBtn.width-6, 15, 6, 12) icon:@"44"];
        [self.saveBtn addSubview:_imgView];
        
//        _line = [[UIView alloc] initWithFrame:CGRectMake(_leftLab.left, 44-1, kScreenWidth-_leftLab.left, .5)];
//        _line.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
//        [self.contentView addSubview:_line];
        
        //
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-100, 0, 100, 44)];
        [self.contentView addSubview:_baseView];
        
        _tf1 = [UITextField textFieldWithframe:CGRectMake(0, (_baseView.height-18)/2, 25, 18) placeholder:@"" font:[UIFont systemFontOfSize:12] leftView:nil backgroundColor:@"#FFFFFF"];
        _tf1.keyboardType = UIKeyboardTypeNumberPad;
        _tf1.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        _tf1.layer.borderWidth = .5;
        _tf1.clearButtonMode = UITextFieldViewModeNever;
        _tf1.textAlignment = NSTextAlignmentCenter;
        [_baseView addSubview:_tf1];
        [_tf1 addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];


        _label1 = [UILabel labelWithframe:CGRectMake(_tf1.right+2, _tf1.top, 26, _tf1.height) text:@"岁至" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [_baseView addSubview:_label1];
        
        _tf2 = [UITextField textFieldWithframe:CGRectMake(_label1.right+2, _tf1.top, _tf1.width, _tf1.height) placeholder:@"" font:[UIFont systemFontOfSize:12] leftView:nil backgroundColor:@"#FFFFFF"];
        _tf2.keyboardType = UIKeyboardTypeNumberPad;
        _tf2.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        _tf2.layer.borderWidth = .5;
        _tf2.clearButtonMode = UITextFieldViewModeNever;
        _tf2.textAlignment = NSTextAlignmentCenter;
        [_baseView addSubview:_tf2];
        [_tf2 addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];

        
        _label2 = [UILabel labelWithframe:CGRectMake(_tf2.right+2, _tf1.top, 26, _tf1.height) text:@"岁" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [_baseView addSubview:_label2];
        
        //
        _baseView1 = [[UIView alloc] initWithFrame:CGRectMake(_tf.left-10, 0, _tf.width, 103)];
//        _baseView1.layer.cornerRadius = 4;
//        _baseView1.layer.masksToBounds = YES;
//        _baseView1.layer.borderColor = [UIColor colorWithHexString:@"#DCDCDC"].CGColor;
//        _baseView1.layer.borderWidth = .5;
//        _baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_baseView1];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 7, _baseView1.width-8, _baseView1.height-7)];
        textView.font = [UIFont systemFontOfSize:13];
        [_baseView1 addSubview:textView];
        textView.delegate = self;
        self.tv = textView;
        
        _remindLabel = [UILabel labelWithframe:CGRectMake(3, 7, 100, 16) text:@"请填写(选填)" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
        [textView addSubview:_remindLabel];
        
        [self.contentView addSubview:self.tagsView];

        

    }
    
    return self;
    
}

- (HXTagsView *)tagsView
{
    if (!_tagsView) {
//        NSArray *tagAry = @[@"薪假",@"公游",@"保险"];
        //    单行不需要设置高度,内部根据初始化参数自动计算高度
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(110, 0, kScreenWidth-33-110, 0)];
        _tagsView.type = 0;
        _tagsView.tagHorizontalSpace = 8.0;
        _tagsView.showsHorizontalScrollIndicator = NO;
        _tagsView.tagHeight = 22;
        _tagsView.titleSize = 12.0;
        _tagsView.tagOriginX = 0.0;
        _tagsView.titleColor = [UIColor colorWithHexString:@"#666666"];
        _tagsView.cornerRadius = 5;
        _tagsView.userInteractionEnabled = NO;
        _tagsView.backgroundColor = [UIColor clearColor];
        _tagsView.borderColor = [UIColor colorWithHexString:@"#979797"];
//        [_tagsView setTagAry:tagAry delegate:nil];
    }
    
    return _tagsView;
}



- (void)setModel:(ReleaseJobModel *)model
{
    _model = model;
    
    _leftLab.text = model.leftTitle;
    _tf.placeholder = model.rightTitle;
    _tf.text = model.text;
    
    if ([_model.leftTitle isEqualToString:@"职位名称"] ||
        [_model.leftTitle isEqualToString:@"户口要求"]||
        [_model.leftTitle isEqualToString:@"年龄要求"]||
        [_model.leftTitle isEqualToString:@"岗位要求"]||
        [_model.leftTitle isEqualToString:@"求职者期望职位"]||
        [_model.leftTitle isEqualToString:@"求职者编号"]||
        [_model.leftTitle isEqualToString:@"籍贯"]||
        [_model.leftTitle isEqualToString:@"姓名"]||
        [_model.leftTitle isEqualToString:@"求职者专业"]||
        [_model.leftTitle isEqualToString:@"求职者年龄"]||
        [_model.leftTitle isEqualToString:@"求职者工作经历"]||
        
        [_model.leftTitle isEqualToString:@"招聘人数"]) {
        
        self.saveBtn.hidden = YES;
        
        
    }
    else {
        
        self.saveBtn.hidden = NO;
        
    }
    
    if ([_model.leftTitle isEqualToString:@"招聘人数"]) {
        
        if ([_model.text isEqualToString:@"0"]) {
            _tf.text = @"";
        }
        _tf.keyboardType = UIKeyboardTypeNumberPad;

    }
    else {
        _tf.keyboardType = UIKeyboardTypeDefault;

    }
    
    if ([_model.leftTitle isEqualToString:@"求职者年龄"]) {
        _baseView.hidden = NO;
        _tf.hidden = YES;

        _tf1.keyboardType = UIKeyboardTypeNumberPad;
        _tf2.keyboardType = UIKeyboardTypeNumberPad;
    }
    else {
        _baseView.hidden = YES;
        _tf.hidden = NO;

    }
    
    if ([_model.leftTitle isEqualToString:@"岗位要求"]) {
        
        self.baseView1.hidden = NO;
        _tv.text = model.text;
        
        if (model.text.length == 0) {
            _remindLabel.hidden = NO;
        }
        else {
            _remindLabel.hidden = YES;
        }
    }
    else {
        self.baseView1.hidden = YES;
        
    }
    
    if ([_model.leftTitle isEqualToString:@"公司福利"]) {
        
        _tagsView.hidden = NO;
        
        _tf.text = @"";
        if (model.text.length == 0) {
            _tf.placeholder = @"请选择(选填)";
        }
        else {
            _tf.placeholder = @"";
            
            NSArray *tagArr = [model.text componentsSeparatedByString:@","];
            
//            if (self.tagArr.count == 0) {
//                self.tagArr = tagArr.mutableCopy;
//
//            }
            if (model.tagArr.count == 0) {
                model.tagArr = tagArr.mutableCopy;
                
            }
        }
        
        [_tagsView setTagAry:model.tagArr delegate:nil];

        if (model.cellHeight>0) {
            _tagsView.height = model.cellHeight;

        }
        else {
            _model.cellHeight = _tagsView.height;

        }

    }
    else {
        _tagsView.hidden = YES;

    }
    NSLog(@"-------_tagArr:%@",_tagArr);
    NSLog(@"-------cellHeight:%ld",model.cellHeight);

}

- (void)pushAction
{
    // 收起键盘有效
    [self.viewController.view endEditing:YES];

    if ([_model.leftTitle isEqualToString:@"联系人"]) {
        ContactManageVC *vc = [[ContactManageVC alloc] init];
        vc.title = @"联系人管理";
        vc.mark = 1;
        [self.viewController.navigationController pushViewController:vc animated:YES];
        vc.block = ^(AddContactModel *model) {

            _tf.text = [NSString stringWithFormat:@"%@%@",model.name, model.tele];
            _model.text = _tf.text;
            _model.contactId = model.contactId;
        };
        return;
        
    }
    
    if ([_model.leftTitle isEqualToString:@"公司福利"]) {
        
        
        TagViewVC *vc = [[TagViewVC alloc] init];
        vc.title = @"公司福利";
        vc.tagArr = _model.tagArr;
        [self.viewController.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSMutableArray *tagArr) {
            
            _model.tagArr = tagArr;
            NSString *tag = [tagArr componentsJoinedByString:@","];

            _model.text = tag;
        
            [_tagsView removeFromSuperview];
            _tagsView = nil;
            [self.contentView addSubview:self.tagsView];
            [_tagsView setTagAry:tagArr delegate:nil];
            _model.cellHeight = _tagsView.height;
            if (self.block) {
                self.block();
            }
            NSLog(@"-------_tagArr:%@",_model.tagArr);
            NSLog(@"-------_tagsView:%ld",_tagsView.height);


        };
        return;
        
    }
    
    
    if ([_model.leftTitle isEqualToString:@"性别要求"]||
        [_model.leftTitle isEqualToString:@"求职者性别"]) {
        self.dataSource = @[@"男",@"女"];
        
    }
    
    if ([_model.leftTitle isEqualToString:@"有无照片"]) {
        self.dataSource = @[@"有",@"无"];
        
    }
    
    if ([_model.leftTitle isEqualToString:@"最近上网日期"]) {
        self.dataSource = @[@"一天内",@"三天内",@"一周内",@"半月内",@"一个月内",@"三个月内",@"半年内",@"一年内"];
        
    }
    
    if ([_model.leftTitle isEqualToString:@"学历要求"]||
        [_model.leftTitle isEqualToString:@"求职者学历"]) {
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_edu"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }

    
    if ([_model.leftTitle isEqualToString:@"工作经验"]) {
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_years"]) {
                
                NSString *str = dic[@"data"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                
                for (NSString *s in arr) {
//                    NSString *s1 = [NSString stringWithFormat:@"%@年",s];
                    [arrM addObject:s];
                }
                self.dataSource = arrM;
                break;
            }
        }
        
    }
    if ([_model.leftTitle isEqualToString:@"月薪"]) {
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_pay"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }
    
    
    if ([_model.leftTitle isEqualToString:@"工作类型"]) {
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_jobs"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }
    
    if ([_model.leftTitle isEqualToString:@"应聘方式"]) {
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"user_tele"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }
    
    if ([_model.leftTitle isEqualToString:@"住房要求"]) {
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_house"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }
    
    
    if ([_model.leftTitle isEqualToString:@"工作地点"]||
        [_model.leftTitle isEqualToString:@"期望工作地点"]) {
        
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"citys"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }
    
    // 岗位类别
    if ([_model.leftTitle isEqualToString:@"职位类别"]) {
        
        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@0, @0] isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {
            _tf.text = selectAddressArr[0];
            _model.text = selectAddressArr[0];
//            weakSelf.addressTF.text = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
        }];
        return;
    }
    
    NSMutableArray *arrM = self.dataSource.mutableCopy;
    if (!([_model.leftTitle isEqualToString:@"月薪"]||
          [_model.leftTitle isEqualToString:@"学历要求"]||
          [_model.leftTitle isEqualToString:@"住房要求"]||
        [_model.leftTitle isEqualToString:@"应聘方式"])) {
        
        [arrM insertObject:@"不限" atIndex:0];
    }

    [BRStringPickerView showStringPickerWithTitle:nil dataSource:arrM defaultSelValue:arrM[0] isAutoSelect:NO resultBlock:^(id selectValue) {

        _tf.text = selectValue;
        _model.text = selectValue;

//        if ([_model.leftTitle isEqualToString:@"工作年限"]||
//            [_model.leftTitle isEqualToString:@"工作经验"]) {
//
//            _model.text = [_model.text substringToIndex:_model.text.length-1];
//            NSLog(@"-----%@",selectValue);
//
//        }

    }];
    
    
    
}

- (void)changeAction:(UITextField *)tf
{
    if ([_model.leftTitle isEqualToString:@"求职者年龄"]) {
        
        _model.minAge = _tf1.text;
        _model.maxAge = _tf2.text;

    }
    else {
        _model.text = tf.text;

    }
    
    if ([_model.leftTitle isEqualToString:@"招聘人数"]) {
        
        if (tf.text.length > 6) {
            NSString *subStr = [tf.text substringToIndex:6];
            tf.text = subStr;
            _model.text = tf.text;
        }

//        if ([_model.text isEqualToString:@"0"]) {
//            tf.text = @"";
//        }
    }
    
}

/**
 内容将要发生改变编辑 限制输入文本长度 监听TextView 点击了ReturnKey 按钮
 
 @param textView textView
 @param range    范围
 @param text     text
 
 @return BOOL
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 500)
    {
        return  YES;
        
    } else  if ([textView.text isEqualToString:@"\n"]) {
        
        //这里写按了ReturnKey 按钮后的代码
        return NO;
    }
    
    if (textView.text.length == 500) {
        
        return NO;
    }
    
    return YES;
    
}


/**
 内容发生改变编辑 自定义文本框placeholder
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
 @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length < 1) {
        self.remindLabel.hidden = NO;
    }
    else {
        self.remindLabel.hidden = YES;
        
    }
    _model.text = textView.text;
}

@end
