//
//  ContactManageCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableViewCell.h"
#import "AddContactModel.h"


@interface ContactManageCell : ZFTableViewCell

@property(nonatomic,strong) UIButton *chatBtn;
@property(nonatomic,strong) UIButton *bodyBtn;
@property(nonatomic,strong) UIButton *eduBtn;
@property(nonatomic,strong) UILabel *timeLab;

@property(nonatomic,strong) AddContactModel *model;

@end
