//
//  TagViewVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/24.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^TagViewBlock)(NSMutableArray *tagArr);


@interface TagViewVC : BaseViewController

@property(nonatomic,copy) TagViewBlock block;
@property(nonatomic,strong) NSMutableArray *tagArr;


@end
