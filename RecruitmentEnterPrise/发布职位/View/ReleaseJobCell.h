//
//  ReleaseJobCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReleaseJobModel.h"

@interface ReleaseJobCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *leftLab;
@property(nonatomic,strong) UILabel *rightLab;

@property(nonatomic,strong) ReleaseJobModel *model;


//
@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UITextField *tf1;
@property(nonatomic,strong) UITextField *tf2;
@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong) UILabel *label2;

@end
