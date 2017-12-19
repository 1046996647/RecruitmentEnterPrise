//
//  ContactManageVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ContactManageVC.h"
#import "ContactManageCell.h"
#import "AddContactVC.h"
#import "NavigationController.h"

#import "ZFTableViewCell.h"

@interface ContactManageVC ()<UITableViewDelegate,UITableViewDataSource,ZFTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ContactManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 右上角按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    UIButton *viewBtn = [UIButton buttonWithframe:rightView.bounds text:@"" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:nil normal:@"32" selected:nil];
    [rightView addSubview:viewBtn];
    viewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [viewBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self get_contact];
}

// 获取联系人
- (void)get_contact
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    
    NSLog(@"%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_contact dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            NSMutableArray *arrM1 = [NSMutableArray array];

            AddContactModel *model = [AddContactModel yy_modelWithDictionary:dic];
            [arrM1 addObject:model];
            [arrM addObject:arrM1];
        }
        self.dataArr = arrM;
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

// 删除联系人
- (void)delete_contact:(AddContactModel *)model
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic setValue:model.contactId forKey:@"contactId"];
    
    NSLog(@"%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Delete_contact dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
    
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)addAction
{
    
    AddContactVC *vc = [[AddContactVC alloc] init];
    vc.title = @"增加联系人";
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
//    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
//    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
    
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.mark == 1) {
        AddContactModel *model = self.dataArr[indexPath.section][indexPath.row];
        
        if (self.block) {
            self.block(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;// 为0无效
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0001)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identity = @"FDFeedCell";
    
    ContactManageCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        
        cell = [[ContactManageCell alloc]initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identity
                                           delegate:self
                                        inTableView:tableView
                              withRightButtonTitles:@[@""]
                              withRightButtonColors:@[[UIColor clearColor]]
                                               type:ZFTableViewCellTypeFive
                                          rowHeight:100];
        cell.block = ^(AddContactModel *model, NSInteger tag) {
            
            // 删除
            if (tag == 0){
                //        NSLog(@"编辑");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除该联系人吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self delete_contact:model];
                    [self.dataArr removeObjectAtIndex:indexPath.section];
                    [self.tableView reloadData];
                }];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if (tag == 1){
                //        NSLog(@"删除");
                AddContactVC *vc = [[AddContactVC alloc] init];
                vc.title = @"修改联系人";
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        };
        
    }
        AddContactModel *model = self.dataArr[indexPath.section][indexPath.row];
        cell.model = model;
    //    cell.selectArr = _selectArr;
    //    cell.selectJobArr = _selectJobArr;
    return cell;
}


#pragma mark - ZFTableViewCellDelegate
-(void)buttonTouchedOnCell:(ZFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath atButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"row:%ld,buttonIndex:%ld",(long)indexPath.row,(long)buttonIndex);
    
//    AddContactModel *model = self.dataArr[indexPath.section][indexPath.row];
//
//    // 删除
//    if (buttonIndex == 0){
//        //        NSLog(@"编辑");
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除该联系人吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self delete_contact:model];
//            [self.dataArr removeObjectAtIndex:indexPath.section];
//            [self.tableView reloadData];
//        }];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//        [alertController addAction:cancelAction];
//        [alertController addAction:okAction];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//    else if (buttonIndex == 1){
//        //        NSLog(@"删除");
//        AddContactVC *vc = [[AddContactVC alloc] init];
//        vc.title = @"修改联系人";
//        vc.model = model;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
//    //把cell复原
//    [[NSNotificationCenter defaultCenter] postNotificationName:ZFTableViewCellNotificationChangeToUnexpanded object:nil];
}

@end
