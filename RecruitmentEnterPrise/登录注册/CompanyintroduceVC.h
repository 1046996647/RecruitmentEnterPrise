//
//  Company introduceVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CompanyintroduceBlock)(NSString *text);

@interface CompanyintroduceVC : BaseViewController

@property(nonatomic,strong) NSString *text;

@property(nonatomic,copy) CompanyintroduceBlock block;


@end
