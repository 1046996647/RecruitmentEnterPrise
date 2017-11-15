//
//  InviteInterviewVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/23.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^InviteInterviewBlock)(void);

@interface InviteInterviewVC : BaseViewController

@property(nonatomic,strong) NSMutableArray *selectedArr;// 选择数组
@property(nonatomic,strong) InviteInterviewBlock block;


@end
