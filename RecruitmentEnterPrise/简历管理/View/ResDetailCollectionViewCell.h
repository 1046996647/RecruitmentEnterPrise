//
//  ResDetailCollectionViewCell.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResumeModel.h"

@interface ResDetailCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *nameLab;

@property(nonatomic,strong) ResumeModel *model;

@end
