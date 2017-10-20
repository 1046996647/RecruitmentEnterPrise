//
//  ResumeSearchResultCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResumeSearchResultCell : UITableViewCell

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) UIButton *bodyBtn;
@property(nonatomic,strong) UIButton *eduBtn;
@property(nonatomic,strong) UIButton *jobBtn;
@property(nonatomic,strong) UIButton *addressBtn;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *jobLab;
@property(nonatomic,strong) UILabel *label;

@end
