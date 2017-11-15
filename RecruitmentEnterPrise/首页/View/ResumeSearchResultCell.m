//
//  ResumeSearchResultCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeSearchResultCell.h"
#import "NSStringExt.h"

@implementation ResumeSearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 35, 100) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"Rectangle 11" selected:@"Rectangle 12"];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(_selectBtn.right, 0, kScreenWidth-_selectBtn.right-10, 100)];
        //        baseView.layer.cornerRadius = 10;
        //        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(9, 19, 60, 60) icon:@""];
//        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = _imgView.height/2;
        _imgView.layer.masksToBounds = YES;
        [baseView addSubview:_imgView];
        
        _timeLab = [UILabel labelWithframe:CGRectMake(baseView.width-120-8, 8, 120, 13) text:@"最近登录：2017-09-15" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [baseView addSubview:_timeLab];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(_imgView.right+13, _imgView.top, 46, 17) text:@"凌小慧" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#D0021B"];
        [baseView addSubview:_nameLab];
        
        _bodyBtn = [UIButton buttonWithframe:CGRectMake(_nameLab.right+4, _nameLab.center.y-6, 24, 12) text:@"28" font:SystemFont(9) textColor:@"#FFFFFF" backgroundColor:@"#9AD9EC" normal:@"male" selected:@"female"];
        _bodyBtn.layer.cornerRadius = 2;
        _bodyBtn.layer.masksToBounds = YES;
        _bodyBtn.userInteractionEnabled = NO;
        //        _viewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        _bodyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [baseView addSubview:_bodyBtn];
        
        _jobLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+7, kScreenWidth-_nameLab.left-12, 16) text:@"期望职位 销售类" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [baseView addSubview:_jobLab];
        
        _eduBtn = [UIButton buttonWithframe:CGRectMake(_nameLab.left, _jobLab.bottom+9, 45, 14) text:@"大专" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"28" selected:nil];
        _eduBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置UIControlContentHorizontalAlignmentLeft，所以UIEdgeInsetsMake只能设置left
        _eduBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _eduBtn.userInteractionEnabled = NO;
        [baseView addSubview:_eduBtn];
        
        _jobBtn = [UIButton buttonWithframe:CGRectMake(_eduBtn.right+9, _jobLab.bottom+9, 40, 14) text:@"1年" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"工作经验" selected:nil];
        _jobBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _jobBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _jobBtn.userInteractionEnabled = NO;
        [baseView addSubview:_jobBtn];
        
        _addressBtn = [UIButton buttonWithframe:CGRectMake(_jobBtn.right+9, _jobLab.bottom+9, 200, 14) text:@"杭州" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"籍贯" selected:nil];
        _addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _addressBtn.userInteractionEnabled = NO;
        [baseView addSubview:_addressBtn];
        
        _label = [UILabel labelWithframe:CGRectMake(baseView.width-54-8, baseView.height-3-16, 54, 16) text:@"1223556" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#666666"];
        [baseView addSubview:_label];
    }
    
    return self;
    
}

- (void)selectAction:(UIButton *)btn
{
    _model.isSelected = !_model.isSelected;
    btn.selected = _model.isSelected;
    
    if (self.block) {
        self.block(_model);
    }
}

- (void)setModel:(ResumeModel *)model
{
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"Rectangle 14"]];
    _nameLab.text = model.name;
    _jobLab.text = [NSString stringWithFormat:@"期望职位 %@",model.hopepostion];
    [_eduBtn setTitle:model.education forState:UIControlStateNormal];
    [_jobBtn setTitle:[NSString stringWithFormat:@"%@年",model.jobyear] forState:UIControlStateNormal];
    [_addressBtn setTitle:model.jiguan forState:UIControlStateNormal];
//    [ad setTitle:model.education forState:UIControlStateNormal];
    _timeLab.text = [NSString stringWithFormat:@"最近登录：%@",model.lastTime];
    _label.text = model.workerId;
    
    CGSize size = [NSString textLength:model.name font:_nameLab.font];
    _nameLab.width = size.width;
    _bodyBtn.left = _nameLab.right+4;
    
    [_bodyBtn setTitle:model.age forState:UIControlStateNormal];
    if ([model.sex isEqualToString:@"女"]) {
        _bodyBtn.selected = YES;
        _bodyBtn.backgroundColor = [UIColor colorWithHexString:@"#EC9AA4"];
    }
    else {
        _bodyBtn.selected = NO;
        _bodyBtn.backgroundColor = [UIColor colorWithHexString:@"#9AD9EC"];

    }
    
    _selectBtn.selected = _model.isSelected;


}

@end
