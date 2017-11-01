//
//  ChangePhoneVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ChangePhoneBlock)(NSString *text);

@interface ChangePhoneVC : BaseViewController


@property(nonatomic,assign) NSInteger mark;

@property(nonatomic,strong) PersonModel *model;
@property(nonatomic,copy) ChangePhoneBlock block;

@end
