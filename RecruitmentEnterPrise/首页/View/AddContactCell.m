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
        
        _nameLab = [UILabel labelWithframe:CGRectMake(22, 15, 100, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_nameLab];
        
        _tf1 = [UITextField textFieldWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+12, kScreenWidth-_nameLab.left*2, 38) placeholder:@"" font:[UIFont systemFontOfSize:13] leftView:nil backgroundColor:@"#FFFFFF"];
        _tf1.keyboardType = UIKeyboardTypeNumberPad;
        _tf1.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        _tf1.layer.borderWidth = .5;
        [_tf1 setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
        [_tf1 setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        _tf1.layer.cornerRadius = 10;
        _tf1.layer.masksToBounds = YES;
        [self.contentView addSubview:_tf1];
        

        
        
    }
    
    return self;
    
}

@end
