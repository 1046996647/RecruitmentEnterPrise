//
//  ReleaseJobModel.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReleaseJobModel.h"

@implementation ReleaseJobModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSString *timeStr = [[dic[@"update_time"] componentsSeparatedByString:@" "] firstObject];
    _update_time = timeStr;
    
    return YES;
}

@end
