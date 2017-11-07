//
//  ReleaseJobModel.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReleaseJobModel : NSObject

@property(nonatomic,strong) NSString *leftTitle;
@property(nonatomic,strong) NSString *rightTitle;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *contactId;
@property(nonatomic,strong) NSString *minAge;
@property(nonatomic,strong) NSString *maxAge;

@property (nonatomic,assign) BOOL isSelected;


// 职位管理
@property(nonatomic,strong) NSString *hits;
@property(nonatomic,strong) NSString *jobId;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *update_time;
@property(nonatomic,strong) NSString *ordid;

// 职位详情
@property(nonatomic,strong) NSString *contactName;
@property(nonatomic,strong) NSString *area;
@property(nonatomic,strong) NSString *edu;
@property(nonatomic,strong) NSString *jobs;
@property(nonatomic,strong) NSString *info;
@property(nonatomic,strong) NSString *ages;
@property(nonatomic,strong) NSString *pay;
@property(nonatomic,strong) NSString *years;
@property(nonatomic,strong) NSString *hukou;
@property(nonatomic,strong) NSString *gender;
@property(nonatomic,strong) NSString *house;
@property(nonatomic,strong) NSString *nums;
@property(nonatomic,strong) NSString *cateName;
@property(nonatomic,strong) NSString *tele;

@end
