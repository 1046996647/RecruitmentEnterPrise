//
//  AddressSearchVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/24.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>

typedef void(^AddressSearchBlock)(NSString *text);

@interface AddressSearchVC : BaseViewController

@property (nonatomic,strong) BMKUserLocation *userLocation;
@property(nonatomic,copy) AddressSearchBlock block;


@end
