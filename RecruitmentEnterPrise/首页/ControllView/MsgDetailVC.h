//
//  MsgDetailVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import "ReceiveMsgModel.h"

@interface MsgDetailVC : BaseViewController

@property (nonatomic,strong) ReceiveMsgModel *model;
@property (nonatomic,assign) NSInteger mark;


@end
