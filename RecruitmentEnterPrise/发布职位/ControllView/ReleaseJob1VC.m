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
@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSArray *selectJobArr;
@property(nonatomic,strong) NSMutableArray *tagArr;
@property(nonatomic,strong) UIButton *selectBtn;


@end

@implementation ReleaseJob1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    UIButton *selectBtn = [UIButton buttonWithframe:CGRectMake(25, 17, kScreenWidth-50, 20) text:[NSString stringWithFormat:@"当前约聊次数为%@次，是否发布可约聊岗位",[InfoCache unarchiveObjectWithFile:@"chatLast"]] font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"Rectangle 11" selected:@"Rectangle 12"];
    [footerView addSubview:selectBtn];
    selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtn = selectBtn;
    
//    UILabel *nameLab = [UILabel labelWithframe:CGRectMake(0, 0, selectBtn.width-20-10, selectBtn.height) text:[NSString stringWithFormat:@"发布可约聊岗位，当前约聊次数为%@",[InfoCache unarchiveObjectWithFile:@"chatLast"]] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
//    [selectBtn addSubview:nameLab];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, selectBtn.bottom+ 17, kScreenWidth-50, 40) text:@"发布" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    [releseBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];

    footerView.height = releseBtn.bottom+17;
    _tableView.tableFooterView = footerView;

    
    // 选择项数据
    NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
    self.selectArr = selectArr;
    
//    NSArray *selectJobArr = [InfoCache unarchiveObjectWithFile:SelectItemJob1];;
//    self.selectJobArr = selectJobArr;
    
//    // 标签数组
//    self.tagArr = [NSMutableArray array];
    
    if ([self.title isEqualToString:@"修改职位"]) {
        [releseBtn setTitle:@"修改" forState:UIControlStateNormal];
        selectBtn.hidden = YES;
        [self get_position_detail];
    }
    else {
        self.dataArr = @[@[@{@"leftTitle":@"职位名称",@"rightTitle":@"请填写",@"text":@"",@"key":@"title"},
                           @{@"leftTitle":@"职位类别",@"rightTitle":@"请选择",@"text":@"",@"key":@"cateName"},
                           @{@"leftTitle":@"公司福利",@"rightTitle":@"请选择(选填)",@"text":@"",@"key":@"tag"}
                           ],
                         @[@{@"leftTitle":@"联系人",@"rightTitle":@"请选择",@"text":@"",@"key":@"contactId"},
                           @{@"leftTitle":@"工作地点",@"rightTitle":@"请选择",@"text":@"",@"key":@"area"}
                           ],
                         @[@{@"leftTitle":@"学历要求",@"rightTitle":@"请选择",@"text":@"",@"key":@"edu"},
                           @{@"leftTitle":@"户口要求",@"rightTitle":@"请填写(选填)",@"text":@"",@"key":@"hukou"}
                           ],
                         @[@{@"leftTitle":@"工作类型",@"rightTitle":@"请选择",@"text":@"",@"key":@"jobs"},
                           @{@"leftTitle":@"工作经验",@"rightTitle":@"请选择",@"text":@"",@"key":@"years"},
                           @{@"leftTitle":@"月薪",@"rightTitle":@"请选择",@"text":@"",@"key":@"pay"}
                           ],
                         @[@{@"leftTitle":@"性别要求",@"rightTitle":@"请选择",@"text":@"不限",@"key":@"gender"},
                           @{@"leftTitle":@"年龄要求",@"rightTitle":@"请填写(选填)",@"text":@"不限",@"key":@"ages"},
                           @{@"leftTitle":@"住房要求",@"rightTitle":@"请选择",@"text":@"",@"key":@"house"}
                           ],
                         @[@{@"leftTitle":@"应聘方式",@"rightTitle":@"请选择",@"text":@"",@"key":@"tele"},
                           @{@"leftTitle":@"招聘人数",@"rightTitle":@"若干",@"text":@"0",@"key":@"nums"}
                           ],
                         @[@{@"leftTitle":@"岗位要求",@"rightTitle":@"请填写(选填)",@"text":@"",@"key":@"info"}
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
        [_tableView reloadData];
        


    }
    

}

- (void)get_position_detail
{

    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.model.jobId forKey:@"jobId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_position_detail dic:paramDic showHUD:YES response:YES Succed:^(id responseObject) {
        
        ReleaseJobModel *model = [ReleaseJobModel yy_modelWithDictionary:responseObject[@"data"]];
        
        self.dataArr = @[@[@{@"leftTitle":@"职位名称",@"rightTitle":@"请填写",@"text":model.title,@"key":@"title"},
                           @{@"leftTitle":@"职位类别",@"rightTitle":@"请选择",@"text":model.cateName,@"key":@"cateName"},
                           @{@"leftTitle":@"公司福利",@"rightTitle":@"请选择(选填)",@"text":model.tag,@"key":@"tag"}

                           ],
                         @[@{@"leftTitle":@"联系人",@"rightTitle":@"请选择",@"text":model.contactName,@"contactId":model.contactId,@"key":@"contactId"},
                           @{@"leftTitle":@"工作地点",@"rightTitle":@"请选择",@"text":model.area,@"key":@"area"}
                           ],
                         @[@{@"leftTitle":@"学历要求",@"rightTitle":@"请选择",@"text":model.edu,@"key":@"edu"},
                           @{@"leftTitle":@"户口要求",@"rightTitle":@"请填写(选填)",@"text":model.hukou,@"key":@"hukou"}
                           ],
                         @[@{@"leftTitle":@"工作类型",@"rightTitle":@"请选择",@"text":model.jobs,@"key":@"jobs"},
                           @{@"leftTitle":@"工作经验",@"rightTitle":@"请选择",@"text":model.years,@"key":@"years"},
                           @{@"leftTitle":@"月薪",@"rightTitle":@"请选择",@"text":model.pay,@"key":@"pay"}
                           ],
                         @[@{@"leftTitle":@"性别要求",@"rightTitle":@"请选择",@"text":model.gender,@"key":@"gender"},
                           @{@"leftTitle":@"年龄要求",@"rightTitle":@"请填写(选填)",@"text":model.ages,@"key":@"ages"},
                           @{@"leftTitle":@"住房要求",@"rightTitle":@"请选择",@"text":model.house,@"key":@"house"}
                           ],
                         @[@{@"leftTitle":@"应聘方式",@"rightTitle":@"请选择",@"text":model.tele,@"key":@"tele"},
                           @{@"leftTitle":@"招聘人数",@"rightTitle":@"若干",@"text":model.nums,@"key":@"nums"}
                           ],
                         @[@{@"leftTitle":@"岗位要求",@"rightTitle":@"请填写(选填)",@"text":model.info,@"key":@"info"}
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
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)selectAction:(UIButton *)btn
{

    // 剩余约聊岗位发布次数
    NSString *chatLast = [InfoCache unarchiveObjectWithFile:@"chatLast"];
    if (chatLast.integerValue == 0) {
        [self.view makeToast:@"当前约聊次数为0次"];
        return;
    }
    else {
        btn.selected = !btn.selected;
    }
}

- (void)saveAction
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    for (NSArray *arr in self.dataArr) {
        
        for (ReleaseJobModel *model in arr) {
            
            if ([model.leftTitle isEqualToString:@"公司福利"]||
                [model.leftTitle isEqualToString:@"招聘人数"]||
//                [model.leftTitle isEqualToString:@"职位名称"]||
                [model.leftTitle isEqualToString:@"户口要求"]||
                [model.leftTitle isEqualToString:@"年龄要求"]||
                [model.leftTitle isEqualToString:@"岗位要求"]) {
                
            }
            else {
                if (model.text.length == 0) {
                    [self.view makeToast:@"请完善发布新职位的信息"];
                    return;
                }
            }
            
            if ([model.leftTitle isEqualToString:@"联系人"]) {
                [paramDic  setValue:model.contactId forKey:model.key];

            }

            else {
                [paramDic  setValue:model.text forKey:model.key];

            }

        }
        
    }
    
    NSLog(@"%@",paramDic);
    
    NSString *url = nil;
    if ([self.title isEqualToString:@"修改职位"]) {
        url = Update_position;
        [paramDic  setValue:self.model.jobId forKey:@"jobId"];
        [self position:url para:paramDic];

    }
    else {
        url = Post_position;
        
        if (self.selectBtn.selected) {
            [paramDic  setValue:@"1" forKey:@"chat"];
            
            [self position:url para:paramDic];
        }
        else {
            [paramDic  setValue:@"0" forKey:@"chat"];
            [self position:url para:paramDic];
        }

    }
    

}

- (void)position:(NSString *)url para:(NSMutableDictionary *)paramDic
{
    [AFNetworking_RequestData requestMethodPOSTUrl:url dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        if (self.block) {
            self.block();
        }
        
        if ([self.title isEqualToString:@"修改职位"]) {
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        else {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
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
    if (indexPath.section == 6) {
        return 103;
        
    }
    else {
        
        ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
        if (model.cellHeight > 0) {
            return model.cellHeight;
        }
        else {
            return 44;

        }
        
    }
    
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
    
    ReleaseJobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[ReleaseJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.block = ^{
            
            [_tableView reloadData];
        };
    }
    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    cell.selectArr = _selectArr;
//    cell.tagArr = _tagArr;
    return cell;
}

@end
