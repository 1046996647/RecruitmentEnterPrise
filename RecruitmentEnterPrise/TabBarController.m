//
//  RCTabBarController.m
//  ChangeLanguage
//
//  Created by RongCheng on 16/7/21.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "CDTabBar.h"

#import "HomeVC.h"
#import "ResumeManageVC.h"
#import "ReleaseJobVC.h"
#import "ChatVC.h"

#import "ReleaseJob1VC.h"
#import "ResumeManage1VC.h"


@interface TabBarController ()<UITabBarControllerDelegate,UINavigationControllerDelegate>


@end

@implementation TabBarController
+ (void)initialize{
   /**
    * 设置 TabBarItem的字体大小与颜色，可参考UIButton
    */
    
    NSMutableDictionary * tabDic=[NSMutableDictionary dictionary];
    tabDic[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    tabDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary * selectedTabDic=[NSMutableDictionary dictionary];
    selectedTabDic[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    selectedTabDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#D0021B"];
    
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:tabDic forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedTabDic forState:(UIControlStateSelected)];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

//    self.tabBar.backgroundColor = [UIColor colorWithHexString:@"#FEFEFE"];
//    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
//    [self.tabBar setShadowImage:[[UIImage alloc]init]];
    self.delegate = self;
    
    [self setChildViewController:[[HomeVC alloc]init] Title:@"首页" Image:@"56" SelectedImage:@"50"];
    [self setChildViewController:[[ReleaseJobVC alloc]init] Title:@"发布职位" Image:@"51" SelectedImage:@""];

    [self setChildViewController:[[ResumeManageVC alloc]init] Title:@"简历管理" Image:@"52" SelectedImage:@"55"];
    
    [self setChildViewController:[[ChatVC alloc]init] Title:@"约聊" Image:@"53" SelectedImage:@"54"];
    
    CDTabBar *tabBar = [[CDTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    [tabBar setDidSecBtn:^(NSInteger tag) {
        
        if (tag == 0) {
            ReleaseJob1VC *vc = [[ReleaseJob1VC alloc] init];
            vc.title = @"发布新职位";
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
        else {
            ResumeManage1VC *vc = [[ResumeManage1VC alloc] init];
            vc.title = @"简历管理";
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    }];

    
//    [self selectController:2];
    

    
}



- (void)selectController:(NSInteger)index{
    self.selectedIndex=index;
}

/**
 *  初始化控制器
 */
- (void)setChildViewController:(UIViewController*)childVC Title:(NSString*)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage
{
    /**
     *  添加 tabBarItem 上的文字和图片
     */
    childVC.title=title;
    childVC.tabBarItem.image=[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVC];
//    nav.delegate = self;
    [self addChildViewController:nav];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITabBarControllerDelegate
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    viewController = (UINavigationController
//                      *)viewController.childViewControllers[0];
//    if ([viewController isKindOfClass:[HomeVC class]]) {
//        self.btn.selected = YES;
//
//    }
//    else {
//        self.btn.selected = NO;
//
//    }
//}
//#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    BOOL isHomePage = [viewController isKindOfClass:[self class]];
//    
//    [navigationController setNavigationBarHidden:isHomePage animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
