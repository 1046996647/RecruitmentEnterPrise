//
//  EditHeadImgVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ClickBlock)(NSInteger);


@interface EditHeadImgVC : BaseViewController
@property (nonatomic,copy) ClickBlock clickBlock;


@end
