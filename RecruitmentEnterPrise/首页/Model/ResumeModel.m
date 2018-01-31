//
//  ResumeModel.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeModel.h"

@implementation ResumeModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSString *timeStr = [[dic[@"lastTime"] componentsSeparatedByString:@" "] firstObject];
    _lastTime = timeStr;
    
    NSString *timeStr1 = [[dic[@"addTime"] componentsSeparatedByString:@" "] lastObject];
    _addTime = timeStr1;
    
    NSString *timeStr2 = [[dic[@"addTime"] componentsSeparatedByString:@" "] firstObject];
    _addTime1 = timeStr2;
    
    return YES;
}

@end
