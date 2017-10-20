//
//  ChatWantedCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ChatWantedCell.h"

@implementation ChatWantedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 100)];
        //        baseView.layer.cornerRadius = 10;
        //        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(9, 19, 60, 60) icon:@""];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = _imgView.height/2;
        _imgView.layer.masksToBounds = YES;
        [baseView addSubview:_imgView];
        
        _timeLab = [UILabel labelWithframe:CGRectMake(baseView.width-120-8, 8, 120, 13) text:@"期望薪资：2.5-3k" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentRight textColor:@"#D0021B"];
        [baseView addSubview:_timeLab];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(_imgView.right+13, _imgView.top, 44, 17) text:@"凌小慧" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#D0021B"];
        [baseView addSubview:_nameLab];
        
        _bodyBtn = [UIButton buttonWithframe:CGRectMake(_nameLab.right+4, _nameLab.center.y-6, 24, 12) text:@"28" font:SystemFont(9) textColor:@"#FFFFFF" backgroundColor:@"#9AD9EC" normal:@"male" selected:nil];
        _bodyBtn.layer.cornerRadius = 2;
        _bodyBtn.layer.masksToBounds = YES;
        _bodyBtn.userInteractionEnabled = NO;
        //        _viewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        _bodyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [baseView addSubview:_bodyBtn];
        
        _jobLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+7, 100, 16) text:@"应聘职位 销售类" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#666666"];
        [baseView addSubview:_jobLab];
        
        _eduBtn = [UIButton buttonWithframe:CGRectMake(_nameLab.left, _jobLab.bottom+9, 45, 14) text:@"大专" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"28" selected:nil];
        _eduBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置UIControlContentHorizontalAlignmentLeft，所以UIEdgeInsetsMake只能设置left
        _eduBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _eduBtn.userInteractionEnabled = NO;
        [baseView addSubview:_eduBtn];
        
        _jobBtn = [UIButton buttonWithframe:CGRectMake(_eduBtn.right+9, _jobLab.bottom+9, 45, 14) text:@"会计" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"27" selected:nil];
        _jobBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _jobBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _jobBtn.userInteractionEnabled = NO;
        [baseView addSubview:_jobBtn];
        
        _chatBtn = [UIButton buttonWithframe:CGRectMake(baseView.width-35, _jobLab.top, 35, 24) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"26" selected:@""];
        [baseView addSubview:_chatBtn];
        
    }
    
    return self;
    
}

@end
