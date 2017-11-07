//
//  InviteInterviewCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/23.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "InviteInterviewCell.h"

@implementation InviteInterviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _leftImgView = [UIImageView imgViewWithframe:CGRectMake(26, (40-14)/2, 16, 14) icon:@""];
        _leftImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_leftImgView];
        
        _tf = [UITextField textFieldWithframe:CGRectMake(_leftImgView.right+10, 0, tableView.width-(_leftImgView.right+10)-_leftImgView.left, 40) placeholder:nil font:nil leftView:nil backgroundColor:@"#FFFFFF"];
        _tf.font = [UIFont systemFontOfSize:11];
        [_tf setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
        [_tf setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
//        _tf.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_tf];
        [_tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
        
        UIButton *saveBtn = [UIButton buttonWithframe:_tf.bounds text:nil font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
//        [saveBtn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        saveBtn.userInteractionEnabled = NO;
        [_tf addSubview:saveBtn];
        self.saveBtn = saveBtn;
//        saveBtn.backgroundColor = [UIColor yellowColor];

        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(saveBtn.width-7, (40-12)/2, 7, 12) icon:@"37"];
        [saveBtn addSubview:_imgView];
        
        
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(_tf.left, 1, _tf.width, 102)];
        _baseView.layer.cornerRadius = 4;
        _baseView.layer.masksToBounds = YES;
        _baseView.layer.borderColor = [UIColor colorWithHexString:@"#DCDCDC"].CGColor;
        _baseView.layer.borderWidth = .5;
        _baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_baseView];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, _baseView.width-8, _baseView.height)];
        textView.font = [UIFont systemFontOfSize:11];
        [_baseView addSubview:textView];
        textView.delegate = self;
        self.tv = textView;
//        textView.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _remindLabel = [UILabel labelWithframe:CGRectMake(3, 5, 100, 16) text:@"输入邀请内容" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
        [textView addSubview:_remindLabel];

    }
    
    return self;
}
- (void)changeAction:(UITextField *)tf
{
    _model.text = tf.text;
    
}

- (void)setModel:(ContactModel *)model
{
    _model = model;
    
    self.leftImgView.image = [UIImage imageNamed:model.image];
    _tf.placeholder = model.title;
    _tf.text = model.text;
    
    if ([_model.title isEqualToString:@"请选择联系人"]) {
        self.saveBtn.hidden = NO;
        _tf.enabled = NO;
    }
    else {
        self.saveBtn.hidden = YES;
        _tf.enabled = YES;

    }
    
    if ([_model.title isEqualToString:@"输入邀请内容"]) {
        
        _imgView.frame = CGRectMake(0, 0, 16, 14);
        self.baseView.hidden = NO;
        _tv.text = model.text;

        
        if (model.text.length == 0) {
            _remindLabel.hidden = NO;
        }
        else {
            _remindLabel.hidden = YES;
        }
    }
    else {
        self.baseView.hidden = YES;
        
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
    //    count.text = [NSString stringWithFormat:@"%lu/100", textView.text.length  ];
}

@end
