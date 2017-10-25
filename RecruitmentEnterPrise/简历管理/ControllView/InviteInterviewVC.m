//
//  InviteInterviewVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/23.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "InviteInterviewVC.h"
#import "InviteInterviewCell.h"

@interface InviteInterviewVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
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
    
    UIImageView *userImg = [UIImageView imgViewWithframe:CGRectMake((imgView.width-50)/2, 15, 50, 50) icon:@""];
    userImg.backgroundColor = [UIColor redColor];
    userImg.layer.cornerRadius = userImg.height/2;
    userImg.layer.masksToBounds = YES;
    [baseView addSubview:userImg];
    
    UILabel *nameLab = [UILabel labelWithframe:CGRectMake(0, userImg.bottom+5, imgView.width, 17) text:@"陈启平" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [baseView addSubview:nameLab];
    
    UILabel *selectLab = [UILabel labelWithframe:CGRectMake(0, nameLab.bottom+12, imgView.width, 17) text:@"选择面试职位" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#D0021B"];
    [baseView addSubview:selectLab];
    
    baseView.height = selectLab.bottom;

    _tableView.tableHeaderView = baseView;

    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 108+40+17)];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(26, 108, footerView.width-26*2, 40) text:@"发送面试邀请" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    [releseBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView.tableFooterView = footerView;
    
}

- (void)btnAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已成功发送面试邀请" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [okAction setValue:[UIColor colorWithHexString:@"#D0021B"] forKey:@"_titleTextColor"];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
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



@end
