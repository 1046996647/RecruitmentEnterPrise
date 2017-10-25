//
//  AddressSearchVC.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/24.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>


@interface AddressSearchVC : BaseViewController

@property (nonatomic,strong) BMKUserLocation *userLocation;

@end
