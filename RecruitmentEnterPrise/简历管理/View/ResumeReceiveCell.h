//
//  ResumeReceiveCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/17.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableViewCell.h"


@interface ResumeReceiveCell : ZFTableViewCell

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) UIButton *bodyBtn;
@property(nonatomic,strong) UIButton *eduBtn;
@property(nonatomic,strong) UIButton *jobBtn;
@property(nonatomic,strong) UIButton *msgBtn;
@property(nonatomic,strong) UIButton *viewBtn;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *jobLab;
//@property(nonatomic,strong) UILabel *stateLab;

@end
