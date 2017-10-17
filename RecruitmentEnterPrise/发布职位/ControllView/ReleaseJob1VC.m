//
//  ReleaseJob1VC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReleaseJob1VC.h"
#import "ReleaseJobCell.h"

@interface ReleaseJob1VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ReleaseJob1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.dataArr = @[@[@{@"leftTitle":@"职位名称",@"rightTitle":@"请填写",@"text":@"",@"key":@"key"},
                       @{@"leftTitle":@"职位类别",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"}
                       ],
                     @[@{@"leftTitle":@"联系人",@"rightTitle":@"请填写",@"text":@"",@"key":@"key"},
                       @{@"leftTitle":@"工作地点",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"}
                       ],
                     @[@{@"leftTitle":@"学历要求",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"},
                       @{@"leftTitle":@"户口要求",@"rightTitle":@"请填写",@"text":@"",@"key":@"key"}
                       ],
                     @[@{@"leftTitle":@"工作类型",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"},
                       @{@"leftTitle":@"工作经验",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"},
                       @{@"leftTitle":@"月薪",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"}
                       ],
                     @[@{@"leftTitle":@"性别要求",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"},
                       @{@"leftTitle":@"年龄要求",@"rightTitle":@"请填写",@"text":@"",@"key":@"key"},
                       @{@"leftTitle":@"住房要求",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"}
                       ],
                     @[@{@"leftTitle":@"应聘方式",@"rightTitle":@"请选择",@"text":@"",@"key":@"key"},
                       @{@"leftTitle":@"招聘人数",@"rightTitle":@"请填写",@"text":@"",@"key":@"key"}
                       ],
                     @[@{@"leftTitle":@"岗位要求",@"rightTitle":@"请填写",@"text":@"",@"key":@"key"}
                       ]
                     
                     ];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSArray *arr in self.dataArr) {
        
        NSMutableArray *arrM1 = [NSMutableArray array];
        
        for (NSDictionary *dic in arr) {
            
            ReleaseJobModel *model = [ReleaseJobModel yy_modelWithJSON:dic];
            [arrM1 addObject:model];
        }
        
        [arrM addObject:arrM1];
        
    }
    
    self.dataArr = arrM;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 34+40)];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, 17, kScreenWidth-50, 40) text:@"发布" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    _tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 5 || section == 6) {
        return 30;
    }
    else {
        return 10;

    }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    
    if (section == 5 || section == 6) {
        view.height = 30;

        UILabel *label = [UILabel labelWithframe:CGRectMake(12, 0, kScreenWidth-12, view.height) text:@"" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
        [view addSubview:label];
        
        if (section == 5) {
            label.text = @"年龄要求填写例：23岁以上";
        }
        else {
            label.text = @"招聘人数不填表示若干";

        }
    }
    else {
        view.height = 10;

    }
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReleaseJobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[ReleaseJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
//    cell.selectArr = _selectArr;
//    cell.selectJobArr = _selectJobArr;
    return cell;
}

@end
