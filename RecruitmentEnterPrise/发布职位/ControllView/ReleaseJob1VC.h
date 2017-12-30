//
//  ReleaseJob1VC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BasePresentViewController.h"
#import "ReleaseJobModel.h"

typedef void(^ReleaseJob1Block)(void);

@interface ReleaseJob1VC : BasePresentViewController

@property(nonatomic,copy) ReleaseJob1Block block;
@property (nonatomic,strong) ReleaseJobModel *model;
@property (nonatomic,assign) NSInteger mark;


@end
