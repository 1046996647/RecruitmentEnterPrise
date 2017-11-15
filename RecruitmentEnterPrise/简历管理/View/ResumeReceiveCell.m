//
//  ResumeReceiveCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeReceiveCell.h"

@implementation ResumeReceiveCell

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
        
        _selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 35, 100) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"Rectangle 11" selected:@"Rectangle 12"];
        [self.cellContentView addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(_selectBtn.right, 0, kScreenWidth-_selectBtn.right-10, 100)];
//        baseView.layer.cornerRadius = 10;
//        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.cellContentView addSubview:baseView];
        self.baseView = baseView;
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(9, 19, 60, 60) icon:@""];
//        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = _imgView.height/2;
        _imgView.layer.masksToBounds = YES;
        [baseView addSubview:_imgView];

        _timeLab = [UILabel labelWithframe:CGRectMake(baseView.width-50-8, 8, 50, 13) text:@"12:18:30" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
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
        
        _jobLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+7, kScreenWidth-_nameLab.left-12, 16) text:@"应聘职位 销售类" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [baseView addSubview:_jobLab];
        
        _eduBtn = [UIButton buttonWithframe:CGRectMake(_nameLab.left, _jobLab.bottom+9, 45, 14) text:@"大专" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"28" selected:nil];
        _eduBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置UIControlContentHorizontalAlignmentLeft，所以UIEdgeInsetsMake只能设置left
        _eduBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _eduBtn.userInteractionEnabled = NO;
        [baseView addSubview:_eduBtn];
        
        _jobBtn = [UIButton buttonWithframe:CGRectMake(_eduBtn.right+9, _jobLab.bottom+9, 100, 14) text:@"会计" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"27" selected:nil];
        _jobBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _jobBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _jobBtn.userInteractionEnabled = NO;
        [baseView addSubview:_jobBtn];
        
        _viewBtn = [UIButton buttonWithframe:CGRectMake(baseView.width-8-20, _jobLab.top, 20, 20) text:@"" font:nil textColor:@"" backgroundColor:nil normal:@"12" selected:nil];
        [baseView addSubview:_viewBtn];
        
        _msgBtn = [UIButton buttonWithframe:CGRectMake(baseView.width-8-20, _jobBtn.top, 20, 20) text:@"" font:nil textColor:@"" backgroundColor:nil normal:@"10" selected:nil];
        [baseView addSubview:_msgBtn];

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

    

    [_eduBtn setTitle:model.education forState:UIControlStateNormal];
    [_jobBtn setTitle:[NSString stringWithFormat:@"%@",model.speciality] forState:UIControlStateNormal];
    _timeLab.text = [NSString stringWithFormat:@"%@",model.addTime];
    
    CGSize size = [NSString textLength:model.name font:_nameLab.font];
    _nameLab.width = size.width;
    _bodyBtn.left = _nameLab.right+4;
    
    _selectBtn.selected = _model.isSelected;

    
    [_bodyBtn setTitle:model.age forState:UIControlStateNormal];
    if ([model.sex isEqualToString:@"女"]) {
        _bodyBtn.selected = YES;
        _bodyBtn.backgroundColor = [UIColor colorWithHexString:@"#EC9AA4"];
    }
    else {
        _bodyBtn.selected = NO;
        _bodyBtn.backgroundColor = [UIColor colorWithHexString:@"#9AD9EC"];
        
    }
    
    if ([model.is_hide integerValue] == 0) {
        _viewBtn.hidden = YES;
    }
    else {
        _viewBtn.hidden = NO;
        
    }
    
    
    if (model.jobName || model.hopepostion) {
        
        if (model.jobName) {
            _jobLab.text = [NSString stringWithFormat:@"应聘岗位 %@",model.jobName];
            
            // 面试记录
            if (model.inviteStatus) {
                if ([model.inviteStatus integerValue] == 0) {
                    
                    _msgBtn.hidden = NO;
                    
                    
                }
                else {
                    _msgBtn.hidden = YES;

                }
            }
            // 简历管理
            else {
                UIButton *btn = self.buttons[1];
                if ([model.jobstatus integerValue] == 3 || [model.jobstatus integerValue] == 2) {
                    
                    _msgBtn.hidden = YES;
                    
                    if ([model.jobstatus integerValue] == 3) {
                        btn.userInteractionEnabled = NO;
                        [btn setTitle:@"已邀请" forState:UIControlStateNormal];
                        
                    }
                    
                }
                else {
                    _msgBtn.hidden = NO;
                    btn.userInteractionEnabled = YES;
                    [btn setTitle:@"邀请面试" forState:UIControlStateNormal];
                }
            }

        }
        else {
            
            
            _jobLab.text = [NSString stringWithFormat:@"期望职位 %@",model.hopepostion];
            _msgBtn.hidden = YES;
            
            if (self.type == 1) {
                self.scrollView.userInteractionEnabled = NO;

            }


        }
        
        _selectBtn.hidden = NO;
        
        self.baseView.frame = CGRectMake(_selectBtn.right, 0, kScreenWidth-_selectBtn.right-10, 100);


    }
    else {
        _jobLab.text = [NSString stringWithFormat:@"查看岗位 %@",model.viewJobName];
        _selectBtn.hidden = YES;
        _msgBtn.hidden = YES;
        
        self.baseView.frame = CGRectMake(10, 0, kScreenWidth-20, 100);
        self.scrollView.userInteractionEnabled = NO;

    }
    _timeLab.frame = CGRectMake(self.baseView.width-50-8, 8, 50, 13);
    _viewBtn.frame = CGRectMake(self.baseView.width-8-20, _jobLab.top, 20, 20);
    
    _selectBtn.selected = _model.isSelected;
    
    
}

@end
