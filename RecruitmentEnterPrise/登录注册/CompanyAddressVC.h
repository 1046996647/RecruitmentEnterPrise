//
//  CompanyAddressVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/23.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CompanyAddressBlock)(NSString *text);


@interface CompanyAddressVC : BaseViewController

@property(nonatomic,copy) CompanyAddressBlock block;


@end
