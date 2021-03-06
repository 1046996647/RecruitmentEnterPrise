//
//  ResumeSearchVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeSearchVC.h"
#import "HotJobCell.h"
#import "PlaceView.h"
#import "SearchUITableView.h"
#import "ResumeSearchResultVC.h"


@interface ResumeSearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UIView *rightView;
@property(nonatomic,strong) NSArray *dataArr;
//@property(nonatomic,strong) PlaceView *placeView;
@property(nonatomic,strong) SearchUITableView *searchUITableView;
@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UIButton *timeBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) UICollectionView *collectionView;

//@property(nonatomic,strong) NSMutableDictionary *dic;

@end

@implementation ResumeSearchVC

//- (PlaceView *)placeView
//{
//    if (!_placeView) {
//
//        __weak typeof(self) weakSelf = self;
//        _placeView = [[PlaceView alloc] initWithFrame:CGRectMake(0, self.baseView.bottom, kScreenWidth, kScreenHeight-kTopHeight)];
//        _placeView.block = ^(NSString *place) {
//
//
//            [weakSelf.placeView removeFromSuperview];
//            weakSelf.timeBtn.selected = NO;
//            if (place) {
////                [weakSelf.placeBtn setTitle:place forState:UIControlStateNormal];
////                [weakSelf.tableView.mj_header beginRefreshing];
//
//            }
//        };
//    }
//    return _placeView;
//}

- (SearchUITableView *)searchUITableView
{
    if (!_searchUITableView) {
        
        __weak typeof(self) weakSelf =  self;
        _searchUITableView = [[SearchUITableView alloc] initWithFrame:CGRectMake(0, self.baseView.bottom, kScreenWidth, kScreenHeight-kTopHeight)];
        _searchUITableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;// 滑动时收起键盘
        _searchUITableView.backgroundColor = colorWithHexStr(@"#FAE5E8");
        _searchUITableView.block = ^(NSMutableDictionary *dic) {
            
//            self.dic = dic;
            [weakSelf pushAction:weakSelf.tf.text searchType:@"advanced" para:dic];

        };

    }
    return _searchUITableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight)];
    baseView.backgroundColor = colorWithHexStr(@"#D0021B");
    [self.view addSubview:baseView];
    self.baseView = baseView;
    
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_back_normal"] forState:UIControlStateNormal];
    button.frame = CGRectMake(17, kStatusBarHeight+(kNavBarHeight-20)/2, 30, 20);
    //        button.backgroundColor = [UIColor greenColor]
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:button];

    
    //
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-45-8, kStatusBarHeight+(kNavBarHeight-25)/2, 45, 25)];
//    rightView.backgroundColor = [UIColor whiteColor];
    self.rightView = rightView;
    
//    UIButton *timeBtn = [UIButton buttonWithframe:CGRectMake(8, 0, 42, rightView.height) text:@"" font:SystemFont(12) textColor:@"#FFFFFF" backgroundColor:nil normal:@"6" selected:@"4"];
//    [rightView addSubview:timeBtn];
//    timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [timeBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.timeBtn = timeBtn;
    
//    UILabel *timeLab = [UILabel labelWithframe:CGRectMake(0, 0, 26, rightView.height) text:@"不限" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
//    [timeBtn addSubview:timeLab];
    
    UIButton *rightBtn = [UIButton buttonWithframe:CGRectMake((rightView.width-20)/2, 0, 20, rightView.height) text:nil font:nil textColor:@"#FFFFFF" backgroundColor:nil normal:@"5" selected:@""];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = rightBtn;
    
    [baseView addSubview:rightView];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    // 搜索框
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 31, 25)];
    //    leftView1.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView0 = [UIImageView imgViewWithframe:CGRectMake(0, 0, leftView1.width, 12) icon:@"7"];
    imgView0.contentMode = UIViewContentModeScaleAspectFit;
    imgView0.center = leftView1.center;
    
    [leftView1 addSubview:imgView0];
    
    _tf = [UITextField textFieldWithframe:CGRectMake(40, kStatusBarHeight+(kNavBarHeight-25)/2, rightView.left-40, 25) placeholder:@"请输入关键字…" font:[UIFont systemFontOfSize:12] leftView:leftView1 backgroundColor:@"#FFFFFF"];
    [_tf setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [_tf setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
    _tf.layer.cornerRadius = _tf.height/2;
    _tf.layer.masksToBounds = YES;
    _tf.delegate = self;
    _tf.returnKeyType = UIReturnKeySearch;


    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tfView];

    [baseView addSubview:_tf];

    
    UILabel *hotLab = [UILabel labelWithframe:CGRectMake(16, baseView.bottom+ 18, 62, 17) text:@"热门关键字" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
    [self.view addSubview:hotLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(hotLab.left, hotLab.bottom+7, kScreenWidth-hotLab.left*2, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#C7C7C7"];
    [self.view addSubview:line];
    
    //
    CGFloat width = (kScreenWidth-24-23*2)/3;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, 26);
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 12;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, line.bottom+11, kScreenWidth,26*2+12) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //        collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HotJobCell class] forCellWithReuseIdentifier:@"cellID"];
    collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    [self get_hot_keyword];
}

- (void)get_hot_keyword
{

    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_hot_keyword dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        // 热门关键字
        self.dataArr = responseObject[@"data"];
        self.collectionView.height = 26*self.dataArr.count+12;
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)timeAction:(UIButton *)btn
//{
//    self.rightBtn.selected = NO;
//    [self.searchUITableView removeFromSuperview];
//
//
//    btn.selected = !btn.selected;
//
//    if (btn.selected) {
//        [self.view addSubview:self.placeView];
////        self.imgView.image = [UIImage imageNamed:@"箭头"];
//    }
//    else {
//        [self.placeView removeFromSuperview];
////        self.imgView.image = [UIImage imageNamed:@"55"];
//
//    }
//
//}

- (void)rightAction:(UIButton *)btn
{
//    self.timeBtn.selected = NO;
//    [self.placeView removeFromSuperview];
    [self.view endEditing:YES];
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self.view addSubview:self.searchUITableView];
        //        self.imgView.image = [UIImage imageNamed:@"箭头"];
    }
    else {
        [self.searchUITableView removeFromSuperview];
        //        self.imgView.image = [UIImage imageNamed:@"55"];
        
    }
    
}




-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *keyword = self.dataArr[indexPath.item];
    [self pushAction:keyword searchType:@"normal" para:[NSMutableDictionary dictionary]];

    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotJobCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
//    NSDictionary *dic = self.dataArr[indexPath.item];
//    cell.jobLab.text = dic[@"name"];
    cell.jobLab.text = self.dataArr[indexPath.item];
    return cell;
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.rightBtn.selected = NO;
    [self.searchUITableView removeFromSuperview];
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length == 0) {
        [textField resignFirstResponder];

        return YES;
    }

    [textField resignFirstResponder];

    [self pushAction:textField.text searchType:@"normal" para:[NSMutableDictionary dictionary]];
    
    return YES;

}

// 搜索结果
- (void)pushAction:(NSString *)text searchType:(NSString *)searchType para:(NSMutableDictionary *)dic
{
    ResumeSearchResultVC *vc = [[ResumeSearchResultVC alloc] init];
    vc.searchText = text;
    vc.searchType = searchType;
    vc.dic = dic;
//    vc.title = @"简历搜索";
    vc.title = [NSString stringWithFormat:@"简历搜索—%@",text];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
