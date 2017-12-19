//
//  TagViewVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/24.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "TagViewVC.h"
#import "HXTagsView.h"


@interface TagViewVC ()<HXTagsViewDelegate>
@property(nonatomic,strong) HXTagsView *tagsView;

@end

@implementation TagViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 40, 40) text:@"完成" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:nil normal:@"" selected:nil];
    [releseBtn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releseBtn];
    
    // 标签数组
    if (!self.tagArr) {
        self.tagArr = [NSMutableArray array];

    }
    
    [self get_tags];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishAction
{
//    if (self.selectedArr.count == 0) {
////        [self.view makeToast:@"请选择标签"];
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
    
    if (self.block) {
        self.block(self.tagArr);

    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)get_tags
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_tags dic:paramDic showHUD:NO response:NO Succed:^(id responseObject) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            [arrM addObject:dic[@"content"]];
        }
//        NSArray *tagAry = @[@"薪假",@"公游",@"保险"];
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _tagsView.type = 0;
        _tagsView.tagHorizontalSpace = 10.0;
        _tagsView.showsHorizontalScrollIndicator = NO;
        _tagsView.tagHeight = 26;
        _tagsView.tagSpace = 26;
        _tagsView.titleSize = 14.0;
        _tagsView.tagOriginX = 10.0;
        _tagsView.titleColor = [UIColor colorWithHexString:@"#333333"];
        _tagsView.cornerRadius = 5;
        _tagsView.userInteractionEnabled = YES;
        _tagsView.backgroundColor = [UIColor clearColor];
        _tagsView.borderColor = [UIColor colorWithHexString:@"#979797"];
        [_tagsView setTagAry:arrM delegate:self];
        [self.view addSubview:_tagsView];
        
        // 是否是已选中的button
        for (UIButton *btn in _tagsView.btnArr) {
            
            btn.backgroundColor = [UIColor whiteColor];

            for (NSString *tag in self.tagArr) {
                if ([btn.currentTitle isEqualToString:tag]) {
                    btn.selected = YES;
//                    btn.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
                    btn.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
                    [btn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
                }
            }

        }
        
        UILabel *countLab = [UILabel labelWithframe:CGRectMake(0, _tagsView.bottom+5, kScreenWidth, 17) text:@"最多选八个" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#999999"];
        [self.view addSubview:countLab];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender;
{
    
    if (sender.selected) {
//        sender.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
        sender.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
        [sender setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];

        [self.tagArr addObject:sender.currentTitle];
        
        if (self.tagArr.count > 8) {
            [self.tagArr removeObject:sender.currentTitle];
            sender.selected = NO;
//            sender.layer.borderColor = [UIColor colorWithHexString:@"#979797"].CGColor;
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            
            [self.view makeToast:@"最多选八个"];
        }
    }
    else {
//        sender.layer.borderColor = [UIColor colorWithHexString:@"#979797"].CGColor;
        sender.backgroundColor = [UIColor whiteColor];
        [sender setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self.tagArr removeObject:sender.currentTitle];
    }
    
    
    
}

@end
