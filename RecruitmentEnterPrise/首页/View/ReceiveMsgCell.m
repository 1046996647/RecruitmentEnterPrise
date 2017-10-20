//
//  ReceiveMsgCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReceiveMsgCell.h"

@implementation ReceiveMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 35, 100) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"Rectangle 11" selected:@"Rectangle 12"];
        [self.contentView addSubview:_selectBtn];
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(_selectBtn.right, 0, kScreenWidth-_selectBtn.right-10, 100)];
        //        baseView.layer.cornerRadius = 10;
        //        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        
        _timeLab = [UILabel labelWithframe:CGRectMake(baseView.width-50-8, 8, 50, 13) text:@"12:18:30" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [baseView addSubview:_timeLab];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(19, 19, 44, 17) text:@"凌小慧" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#D0021B"];
        [baseView addSubview:_nameLab];

        
        _typeLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+7, 100, 16) text:@"应聘职位 销售类" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#666666"];
        [baseView addSubview:_typeLab];
        
        _contenLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _typeLab.bottom+7, 120, 16) text:@"信息内容：知道了，谢谢您！" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#666666"];
        [baseView addSubview:_contenLab];
        
    }
    
    return self;
    
}

@end
