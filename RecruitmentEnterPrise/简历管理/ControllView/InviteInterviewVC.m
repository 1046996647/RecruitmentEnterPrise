//
//  InviteInterviewVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/23.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "InviteInterviewVC.h"
#import "InviteInterviewCell.h"
#import "ResDetailCollectionViewCell.h"
#import "ContactManageVC.h"
#import "ReleaseJobModel.h"
#import "BRPickerView.h"


@interface InviteInterviewVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *jobArr;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation InviteInterviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake((kScreenWidth-341*scaleWidth)/2, 20, 341*scaleWidth, 560*scaleWidth) icon:@"Combined Shape"];
    [self.view addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    
    
    // 表视图
    self.dataArr = @[@{@"image":@"19",@"title":@"请选择联系人",@"text":@"",@"key":@"company_name"},
                     @{@"image":@"18",@"title":@"请填写联系人",@"text":@"",@"key":@"position"},
                     @{@"image":@"17",@"title":@"请填写联系方式",@"text":@"",@"key":@"position"},
                     @{@"image":@"16",@"title":@"请填写地址",@"text":@"",@"key":@"position"},
                     @{@"image":@"15",@"title":@"输入邀请内容",@"text":@"",@"key":@"position"}];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArr) {
        
        ContactModel *model = [ContactModel yy_modelWithJSON:dic];
        [arrM addObject:model];
    }
    
    self.dataArr = arrM;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, imgView.width, imgView.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [imgView addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    // 头视图
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(_tableView.left, 0, _tableView.width, 0)];
    [imgView addSubview:baseView];
    
//    UIImageView *userImg = [UIImageView imgViewWithframe:CGRectMake((imgView.width-50)/2, 15, 50, 50) icon:@""];
//    userImg.backgroundColor = [UIColor redColor];
//    userImg.layer.cornerRadius = userImg.height/2;
//    userImg.layer.masksToBounds = YES;
//    [baseView addSubview:userImg];
    
    CGFloat width = (self.selectedArr.count+1)*12+self.selectedArr.count*50;
    
    if (width > baseView.width) {
        width = baseView.width;
    }

    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(50, 74);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 12;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake((baseView.width-width)/2, 15, width,74) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //        collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[ResDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [baseView addSubview:collectionView];
    
    
    UIButton *selectBtn = [UIButton buttonWithframe:CGRectMake(0, collectionView.bottom+12, imgView.width, 17) text:@"选择面试职位" font:[UIFont systemFontOfSize:14] textColor:@"#D0021B" backgroundColor:nil normal:nil selected:nil];
    [selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:selectBtn];
    
    
    baseView.height = selectBtn.bottom;

    _tableView.tableHeaderView = baseView;

    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 108+40+17)];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(26, 108, footerView.width-26*2, 40) text:@"发送面试邀请" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    [releseBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView.tableFooterView = footerView;
    
    
    [self get_position];
}

- (void)selectAction
{
    NSMutableArray *arrM = [NSMutableArray array];
    for (ReleaseJobModel *model in self.jobArr) {
        
        [arrM addObject:model.title];
    }
    [BRStringPickerView showStringPickerWithTitle:nil dataSource:arrM defaultSelValue:arrM[0] isAutoSelect:NO resultBlock:^(id selectValue) {
        
//        _tf.text = selectValue;
//        _model.text = selectValue;
        
        //        if ([_model.leftTitle isEqualToString:@"工作年限"]||
        //            [_model.leftTitle isEqualToString:@"工作经验"]) {
        //
        //            _model.text = [_model.text substringToIndex:_model.text.length-1];
        //            NSLog(@"-----%@",selectValue);
        //
        //        }
        
    }];
}

- (void)btnAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已成功发送面试邀请" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [okAction setValue:[UIColor colorWithHexString:@"#D0021B"] forKey:@"_titleTextColor"];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)get_position
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_position dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            ReleaseJobModel *model = [ReleaseJobModel yy_modelWithDictionary:dic];
            [arrM addObject:model];
        }
        self.jobArr = arrM;
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    return [self.dataArr count];
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.dataArr count];
//    return 2;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        return 103;

    }
    else {
        return 40;

    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        ContactManageVC *vc = [[ContactManageVC alloc] init];
        vc.title = @"联系人管理";
        vc.mark = 1;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(AddContactModel *model) {

            for (ContactModel *model1 in self.dataArr) {
                
                if ([model1.title isEqualToString:@"请填写联系人"]) {
                    model1.text = model.name;
                }
                if ([model1.title isEqualToString:@"请填写联系方式"]) {
                    model1.text = model.tele;
                }
            }
            
            [_tableView reloadData];
        };
    }

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InviteInterviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[InviteInterviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" tableView:tableView];
        
    }
    ContactModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    //    cell.selectArr = _selectArr;
    //    cell.selectJobArr = _selectJobArr;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.selectedArr.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ResDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    ResumeModel *model = self.selectedArr[indexPath.item];
    cell.model = model;
    return cell;
    
}

@end
