//
//  AppDelegate.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "LoginVC.h"
#import "NavigationController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <UserNotifications/UserNotifications.h>


#import "NTESCellLayoutConfig.h"
#define NIMSDKAppKey @"a99978b70ffcf627c58dcada5eb78921"
#define NIMSDKCerName @"EnterPrise"

// 友盟推送
#import "UMessage.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif

#define USHARE_DEMO_APPKEY @"5a7532c9f29d9843980002dc"


@interface AppDelegate ()<BMKGeneralDelegate>

@property (strong, nonatomic) BMKMapManager *mapManager;


@end

@implementation AppDelegate

+ (AppDelegate *)share
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self.window makeKeyAndVisible];
    
    // 状态栏为白色
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; 
    
//    [NSThread sleepForTimeInterval:1];


    // 键盘遮盖处理第三方库
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"dGYZTiv81Sat6jmIuGZidVbP62li7hWj"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    // 云信
    [[NIMSDKConfig sharedConfig] setEnabledHttpsForInfo:NO];

    //注册APP，请将 NIMSDKAppKey 换成您自己申请的App Key
    [[NIMSDK sharedSDK] registerWithAppID:NIMSDKAppKey cerName:NIMSDKCerName];
    
//    //需要自定义消息时使用
//    [NIMCustomObject registerCustomDecoder:[[NTESAttachmentDecoder alloc]init]];
    
    //开启控制台调试
    [[NIMSDK sharedSDK] enableConsoleLog];
    
    //注入 NIMKit 布局管理器
    [[NIMKit sharedKit] registerLayoutConfig:[NTESCellLayoutConfig new]];
    
    // 推送注册
    [self registerPushService];

    // 友盟推送
    [UMessage startWithAppkey:USHARE_DEMO_APPKEY launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];

    
    // 判断登录状态
    [self isLoginedState];
    
    return YES;
}

// 判断登录状态
- (void)isLoginedState
{
    if (![[InfoCache getValueForKey:@"LoginedState"] integerValue]) {
        LoginVC *loginVC = [[LoginVC alloc] init];
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
    }
    else {
        
        NSString *account = [InfoCache unarchiveObjectWithFile:@"accid"];
        NSString *token = [InfoCache unarchiveObjectWithFile:@"accToken"];
        
//        NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc] init];
//        loginData.account = account;
//        loginData.token = token;
//        [[[NIMSDK sharedSDK] loginManager] autoLogin:loginData];
        
        [[[NIMSDK sharedSDK] loginManager] autoLogin:account token:token];
         
        TabBarController *tabVC = [[TabBarController alloc] init];
        self.tabVC = tabVC;
        self.window.rootViewController = tabVC;
    }
}

#pragma mark - misc
- (void)registerPushService
{
    if (@available(iOS 11.0, *))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!granted)
            {
//                [[UIApplication sharedApplication].keyWindow makeToast:@"请开启推送功能否则无法收到推送通知" duration:2.0 position:CSToastPositionCenter];
            }
        }];
    }
    else
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    //pushkit
//    PKPushRegistry *pushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
//    pushRegistry.delegate = self;
//    pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    
}



- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];

    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken:  %@", deviceToken);
    NSString *pushToken = [self stringDevicetoken:deviceToken];
    NSLog(@"deviceToken:%@",pushToken);
    
    [InfoCache archiveObject:pushToken toFile:@"pushToken"];

}

#pragma mark 以下的
-(NSString *)stringDevicetoken:(NSData *)deviceToken
{
    NSString *token = [deviceToken description];
    NSString *pushToken = [[[token stringByReplacingOccurrencesOfString:@"<"withString:@""]                   stringByReplacingOccurrencesOfString:@">"withString:@""] stringByReplacingOccurrencesOfString:@" "withString:@""];
    return pushToken;
}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    NSString *pushValue = userInfo[@"type"];
    
    //收到简历
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kResumeNotification" object:nil];
    
    //    if ([pushValue isEqualToString:@"interview"]) {
    //        //面试邀请
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"KInterviewNotification" object:nil];
    //    }
    //    else {
    //        // 我的信箱通知
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"kIs_mess_newNotification" object:nil];
    //
    //
    //    }
    
    //    if ([pushValue isEqualToString:@"ArriveOrder"]) {
    //        //完成订单通知事件(弹出评价视图)
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"kFinishOrderNotification" object:userInfo[@"orderId"]];
    //    }
    
    //    self.userInfo = userInfo;
    //定制自定的的弹出框
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
        //                                                                message:@"Test On ApplicationStateActive"
        //                                                               delegate:self
        //                                                      cancelButtonTitle:@"确定"
        //                                                      otherButtonTitles:nil];
        //
        //            [alertView show];
        
        //            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeSuccess];
        
    }
}



//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        //收到简历
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kResumeNotification" object:nil];

        //        NSString *pushValue = userInfo[@"type"];
        
        //        if ([pushValue isEqualToString:@"interview"]) {
        //            //面试邀请
        //            [[NSNotificationCenter defaultCenter] postNotificationName:@"KInterviewNotification" object:nil];
        //        }
        //        else {
        //            // 我的信箱通知
        //            [[NSNotificationCenter defaultCenter] postNotificationName:@"kIs_mess_newNotification" object:nil];
        //
        //
        //        }
        
        //        //定制自定的的弹出框
        //        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        //        {
        //            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeSuccess];
        //
        //        }
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    //    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge);
    
}

//iOS10后新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //收到简历
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kResumeNotification" object:nil];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
