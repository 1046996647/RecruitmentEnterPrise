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

#import "ZFTableViewCell.h"

@interface ContactManageVC ()<UITableViewDelegate,UITableViewDataSource,ZFTableViewCellDelegate>

//@property (nonatomic,strong) NSArray *dataArr;
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

- (void)addAction
{
    AddContactVC *vc = [[AddContactVC alloc] init];
    vc.title = @"增加联系人";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    return [self.dataArr count];
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return [self.dataArr[section] count];
    return 1;
    
    
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
    
    AddContactVC *vc = [[AddContactVC alloc] init];
    vc.title = @"修改联系人";
    [self.navigationController pushViewController:vc animated:YES];
    
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
        
    }
    //    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
    //    cell.model = model;
    //    cell.selectArr = _selectArr;
    //    cell.selectJobArr = _selectJobArr;
    return cell;
}

#pragma mark - ZFTableViewCellDelegate
-(void)buttonTouchedOnCell:(ZFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath atButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"row:%ld,buttonIndex:%ld",(long)indexPath.row,(long)buttonIndex);
    
    // 删除
    if (buttonIndex == 0){
        //        NSLog(@"编辑");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除该联系人吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (buttonIndex == 1){
        //        NSLog(@"删除");

        
    }
    //把cell复原
    [[NSNotificationCenter defaultCenter] postNotificationName:ZFTableViewCellNotificationChangeToUnexpanded object:nil];
}

@end
