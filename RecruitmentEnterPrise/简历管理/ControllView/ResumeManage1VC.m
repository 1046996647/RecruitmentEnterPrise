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
#import "ReleaseJobModel.h"
#import "BRPickerView.h"

@interface ResumeManage1VC ()<MJCSegmentDelegate>

@property (nonatomic,strong) NSArray *jobArr;
@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,assign) NSInteger tag;

@property (nonatomic,strong) ResumeReceiveVC *vc1;
@property (nonatomic,strong) ResumeCheckedVC *vc2;
@property (nonatomic,strong) ResumeLookedVC *vc3;
@property (nonatomic,strong) ResumeCollectionVC *vc4;
@property (nonatomic,strong) UIButton *viewBtn;


@end

@implementation ResumeManage1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    ResumeReceiveVC *vc1 = [[ResumeReceiveVC alloc] init];
    self.vc1 = vc1;
    
    ResumeCheckedVC *vc2 = [[ResumeCheckedVC alloc] init];
    self.vc2 = vc2;

    ResumeLookedVC *vc3 = [[ResumeLookedVC alloc]init];
    self.vc3 = vc3;

    ResumeCollectionVC *vc4 = [[ResumeCollectionVC alloc]init];
    self.vc4 = vc4;

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
    lala.selectedSegmentIndex = self.selectedSegmentIndex;
    lala.indicatorColor = colorWithHexStr(@"#D0021B");
    lala.isIndicatorsAnimals = YES;
    lala.itemTextFontSize = 12;
    lala.isChildScollEnabled = NO;
//    lala.selectedSegmentIndex = 2;
    lala.indicatorStyles = MJCIndicatorItemTextStyle;
    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
    [lala intoChildControllerArray:vcarrr];
    lala.delegate  = self;
    
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 58, 17)];
    
    UIButton *viewBtn = [UIButton buttonWithframe:rightView.bounds text:@"职位分类" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [rightView addSubview:viewBtn];
    [viewBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    self.viewBtn = viewBtn;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    [self get_position];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectAction
{
    _isShow = YES;
    if (self.jobArr.count > 0) {
        NSMutableArray *arrM = [NSMutableArray array];
        [arrM addObject:@"不限"];
        for (ReleaseJobModel *model in self.jobArr) {
            
            [arrM addObject:model.title];
        }
        [BRStringPickerView showStringPickerWithTitle:nil dataSource:arrM defaultSelValue:arrM[0] isAutoSelect:NO resultBlock:^(id selectValue) {
            
            if (_tag == 0) {
                self.vc1.positionType = selectValue;
            }
//            if (_tag == 1) {
//                self.vc1.positionType = selectValue;
//            }
            if (_tag == 2) {
                self.vc3.positionType = selectValue;
            }
            if (_tag == 3) {
                self.vc4.positionType = selectValue;
            }
            
        }];
    }
    else {
        [self get_position];

    }
    

}

- (void)get_position
{
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_position dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSMutableArray *arrM = [NSMutableArray array];

        for (NSDictionary *dic in responseObject[@"data"]) {
            
            ReleaseJobModel *model = [ReleaseJobModel yy_modelWithDictionary:dic];
            [arrM addObject:model];
        }
        self.jobArr = arrM;
        
        if (self.jobArr.count > 0 && _isShow) {
            NSMutableArray *arrM = [NSMutableArray array];
            [arrM addObject:@"不限"];
            for (ReleaseJobModel *model in self.jobArr) {
                
                [arrM addObject:model.title];
            }
            [BRStringPickerView showStringPickerWithTitle:nil dataSource:arrM defaultSelValue:arrM[0] isAutoSelect:NO resultBlock:^(id selectValue) {
                                
                if (_tag == 0) {
                    self.vc1.positionType = selectValue;
                }
                //            if (_tag == 1) {
                //                self.vc1.positionType = selectValue;
                //            }
                if (_tag == 2) {
                    self.vc3.positionType = selectValue;
                }
                if (_tag == 3) {
                    self.vc4.positionType = selectValue;
                }
                
                
            }];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)mjc_ClickEvent:(UIButton *)tabItem childViewController:(UIViewController *)childViewController segmentInterface:(MJCSegmentInterface *)segmentInterface
{
    _tag = tabItem.tag;
    NSLog(@"%ld",_tag);
    
    if (_tag == 1) {
        self.viewBtn.hidden =  YES;
    }
    else {
        self.viewBtn.hidden =  NO;

    }
}

@end
