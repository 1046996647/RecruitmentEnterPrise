//
//  ResumeManageVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeManage1VC.h"
#import "MJCSegmentInterface.h"
#import "ResumeLookedVC.h"
#import "ResumeReceiveVC.h"
#import "ResumeCheckedVC.h"
#import "ResumeCollectionVC.h"

@interface ResumeManage1VC ()


@end

@implementation ResumeManage1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    ResumeReceiveVC *vc1 = [[ResumeReceiveVC alloc] init];
    ResumeCheckedVC *vc2 = [[ResumeCheckedVC alloc] init];
    ResumeLookedVC *vc3 = [[ResumeLookedVC alloc]init];
    ResumeCollectionVC *vc4 = [[ResumeCollectionVC alloc]init];
    NSArray *vcarrr = @[vc1,vc2,vc3,vc4];
    NSArray *titlesArr = @[@"收到的简历",@"查看过的简历",@"谁看了我",@"人才收藏夹"];
    for (int i = 0 ; i < vcarrr.count; i++) {//赋值标题
        UIViewController *vc = vcarrr[i];
        vc.title = titlesArr[i];
    }

    //以下是我的控件中的代码
    MJCSegmentInterface *lala = [[MJCSegmentInterface alloc]init];
    lala.titleBarStyles = MJCTitlesClassicStyle;
    lala.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight);
    lala.titlesViewFrame = CGRectMake(0, 0, 0, 37);
    lala.itemBackColor =  [UIColor clearColor];
    lala.itemTextNormalColor = colorWithHexStr(@"#EFCBD0");;
    lala.itemTextSelectedColor = colorWithHexStr(@"#D0021B");;
    lala.selectedSegmentIndex = 0;
    lala.indicatorColor = colorWithHexStr(@"#D0021B");
    //    lala.isIndicatorFollow = YES;
    lala.itemTextFontSize = 12;
    lala.isChildScollEnabled = NO;
//    lala.selectedSegmentIndex = 2;
    lala.indicatorStyles = MJCIndicatorItemTextStyle;
    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
    [lala intoChildControllerArray:vcarrr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
