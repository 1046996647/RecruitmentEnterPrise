//
//  ReleaseJobCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReleaseJobCell.h"

@implementation ReleaseJobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        _imgView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 15, 6, 12) icon:@"44"];
        [self.contentView addSubview:_imgView];
        
        _leftLab = [UILabel labelWithframe:CGRectMake(12, 14, 100, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_leftLab];
        
        _rightLab = [UILabel labelWithframe:CGRectMake(_imgView.left-6-58, 15, 58, 14) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#D0021B"];
        [self.contentView addSubview:_rightLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(_leftLab.left, 45-1, kScreenWidth-_leftLab.left, .5)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
        [self.contentView addSubview:_line];
        
        //
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-100, 0, 100, 44)];
        [self.contentView addSubview:_baseView];
        
        _tf1 = [UITextField textFieldWithframe:CGRectMake(0, (_baseView.height-18)/2, 25, 18) placeholder:@"" font:[UIFont systemFontOfSize:12] leftView:nil backgroundColor:@"#FFFFFF"];
        _tf1.keyboardType = UIKeyboardTypeNumberPad;
        _tf1.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        _tf1.layer.borderWidth = .5;
        _tf1.clearButtonMode = UITextFieldViewModeNever;
        [_baseView addSubview:_tf1];

        _label1 = [UILabel labelWithframe:CGRectMake(_tf1.right+2, _tf1.top, 26, _tf1.height) text:@"岁至" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [_baseView addSubview:_label1];
        
        _tf2 = [UITextField textFieldWithframe:CGRectMake(_label1.right+2, _tf1.top, _tf1.width, _tf1.height) placeholder:@"" font:[UIFont systemFontOfSize:12] leftView:nil backgroundColor:@"#FFFFFF"];
        _tf2.keyboardType = UIKeyboardTypeNumberPad;
        _tf2.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        _tf2.layer.borderWidth = .5;
        _tf2.clearButtonMode = UITextFieldViewModeNever;
        [_baseView addSubview:_tf2];
        
        _label2 = [UILabel labelWithframe:CGRectMake(_tf2.right+2, _tf1.top, 26, _tf1.height) text:@"岁" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [_baseView addSubview:_label2];
        
    }
    
    return self;
    
}

- (void)setModel:(ReleaseJobModel *)model
{
    _model = model;
    
    _leftLab.text = model.leftTitle;
    
    if (model.text.length == 0) {
        _rightLab.text = model.rightTitle;
        _rightLab.textColor = colorWithHexStr(@"#D0021B");
    }
    else {
        _rightLab.text = model.text;
        _rightLab.textColor = colorWithHexStr(@"#999999");

    }
    
    if ([_model.leftTitle isEqualToString:@"求职者年龄"]) {
        _rightLab.hidden = YES;
        _imgView.hidden = YES;
        _baseView.hidden = NO;
    }
    else {
        _rightLab.hidden = NO;
        _imgView.hidden = NO;
        _baseView.hidden = YES;
    }
    

}

@end
