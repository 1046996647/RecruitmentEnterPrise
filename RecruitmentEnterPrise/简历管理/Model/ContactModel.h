//
//  ContactModel.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/23.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
"name": "23123",
"tele": "Fdsfdefdsfd",
"address": "Dgfgh234",
"info": "Rwetete423435",
"jobName": "Dewrdscs"
A*/

@interface ContactModel : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *image;

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *tele;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *jobName;
@property(nonatomic,strong) NSString *info;

@end
