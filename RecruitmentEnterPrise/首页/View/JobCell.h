//
//  JobTableViewCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableViewCell.h"
#import "ReleaseJobModel.h"
#import "BRPickerView.h"

typedef void(^JobSendModelBlock)(ReleaseJobModel *model, NSInteger type);

@interface JobCell : ZFTableViewCell

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) UIButton *viewBtn;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *orderLab;
@property(nonatomic,strong) UILabel *stateLab;

@property(nonatomic,strong) ReleaseJobModel *model;
@property(nonatomic,copy) JobSendModelBlock block;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) NSMutableArray *dataArr;


@end
