//
//  AddContactCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddContactModel.h"
#import "BRPickerView.h"


@interface AddContactCell : UITableViewCell


@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UITextField *tf1;
@property(nonatomic,strong) UIButton *selectBtn;

@property(nonatomic,strong) AddContactModel *model;

@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSArray *selectJobArr;
@property(nonatomic,strong) NSArray *dataSource;


@end
