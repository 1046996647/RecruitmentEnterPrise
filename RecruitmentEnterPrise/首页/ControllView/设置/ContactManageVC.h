//
//  ContactManageVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import "AddContactModel.h"

typedef void(^ContactManageBlock)(AddContactModel *model);

@interface ContactManageVC : BaseViewController

@property(nonatomic,copy) ContactManageBlock block;
@property(nonatomic,assign) NSInteger mark;


@end
