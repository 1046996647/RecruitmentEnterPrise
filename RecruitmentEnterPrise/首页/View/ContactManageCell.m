//
//  ContactManageCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ContactManageCell.h"

@implementation ContactManageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     delegate:(id<ZFTableViewCellDelegate>)delegate
                  inTableView:(UITableView *)tableView
        withRightButtonTitles:(NSArray *)rightButtonTitles
        withRightButtonColors:(NSArray *)rightButtonColors type:(ZFTableViewCellType)type
                    rowHeight:(NSInteger)rowHeight
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier
                       delegate:delegate
                    inTableView:tableView
          withRightButtonTitles:rightButtonTitles
          withRightButtonColors:rightButtonColors
                           type:type
                      rowHeight:(NSInteger)rowHeight];
    
    if (self){
        
        self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
        self.cellContentView.backgroundColor = [UIColor clearColor];
        self.scrollView.scrollEnabled = NO;
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 100)];
        //        baseView.layer.cornerRadius = 10;
        //        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.cellContentView addSubview:baseView];
        
        _delBtn = [UIButton buttonWithframe:CGRectMake(baseView.width-84-6, 10, 84, 29) text:@"删除" font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:@"31" selected:nil];
        _delBtn.tag = 0;
        _delBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        _delBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
        [baseView addSubview:_delBtn];
        [_delBtn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        _delBtn.layer.cornerRadius = 5;
        _delBtn.layer.masksToBounds = YES;
        _delBtn.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        _delBtn.layer.borderWidth = 1;
        
        _modifyBtn = [UIButton buttonWithframe:CGRectMake(baseView.width-84-6, _delBtn.bottom+18, 84, 29) text:@"修改" font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:@"43" selected:nil];
        _modifyBtn.tag = 1;
        _modifyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        _modifyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
        [baseView addSubview:_modifyBtn];
        [_modifyBtn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        _modifyBtn.layer.cornerRadius = 5;
        _modifyBtn.layer.masksToBounds = YES;
        _modifyBtn.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        _modifyBtn.layer.borderWidth = 1;
        
        
//        _timeLab = [UILabel labelWithframe:CGRectMake(baseView.width-68-8, 44, 68, 13) text:@"2015-08-29" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
//        [baseView addSubview:_timeLab];
        
        _bodyBtn = [UIButton buttonWithframe:CGRectMake(20, 17, _delBtn.left-20-10, 17) text:@"陈先生" font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:@"35" selected:nil];
        _bodyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _bodyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _bodyBtn.userInteractionEnabled = NO;
        [baseView addSubview:_bodyBtn];
        
        
        _eduBtn = [UIButton buttonWithframe:CGRectMake(_bodyBtn.left, _bodyBtn.bottom+9, _bodyBtn.width, _bodyBtn.height) text:@"356335205@qq.com" font:SystemFont(13) textColor:@"#999999" backgroundColor:nil normal:@"34" selected:nil];
        _eduBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置UIControlContentHorizontalAlignmentLeft，所以UIEdgeInsetsMake只能设置left
        _eduBtn.titleEdgeInsets = _bodyBtn.titleEdgeInsets;
        _eduBtn.userInteractionEnabled = NO;
        [baseView addSubview:_eduBtn];
        
        
        _chatBtn = [UIButton buttonWithframe:CGRectMake(_bodyBtn.left, _eduBtn.bottom+9, _bodyBtn.width, _bodyBtn.height) text:@"18842682580" font:SystemFont(13) textColor:@"#999999" backgroundColor:nil normal:@"33" selected:nil];
        _chatBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置UIControlContentHorizontalAlignmentLeft，所以UIEdgeInsetsMake只能设置left
        _chatBtn.titleEdgeInsets = _bodyBtn.titleEdgeInsets;
        _chatBtn.userInteractionEnabled = NO;
        [baseView addSubview:_chatBtn];
        
    }
    
    return self;
    
}

- (void)onButton:(UIButton *)btn
{
    if (self.block) {
        self.block(_model, btn.tag);
    }
}

- (void)setModel:(AddContactModel *)model
{
    _model = model;
    
    [_bodyBtn setTitle:model.name forState:UIControlStateNormal];
    [_eduBtn setTitle:model.email forState:UIControlStateNormal];
    [_chatBtn setTitle:model.tele forState:UIControlStateNormal];

}


@end
