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
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 34+40)];
    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, 17, kScreenWidth-50, 40) text:@"发布" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    _tableView.tableFooterView = footerView;
    [releseBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];

    
    // 选择项数据
    NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
    self.selectArr = selectArr;
    
//    NSArray *selectJobArr = [InfoCache unarchiveObjectWithFile:SelectItemJob1];;
//    self.selectJobArr = selectJobArr;
    
    if ([self.title isEqualToString:@"修改职位"]) {
        [releseBtn setTitle:@"修改" forState:UIControlStateNormal];
        [self get_position_detail];
    }
    else {
        self.dataArr = @[@[@{@"leftTitle":@"职位名称",@"rightTitle":@"请填写",@"text":@"",@"key":@"title"},
                           @{@"leftTitle":@"职位类别",@"rightTitle":@"请选择",@"text":@"",@"key":@"cateName"}
                           ],
                         @[@{@"leftTitle":@"联系人",@"rightTitle":@"请选择",@"text":@"",@"key":@"contactId"},
                           @{@"leftTitle":@"工作地点",@"rightTitle":@"请选择",@"text":@"",@"key":@"area"}
                           ],
                         @[@{@"leftTitle":@"学历要求",@"rightTitle":@"请选择",@"text":@"",@"key":@"edu"},
                           @{@"leftTitle":@"户口要求",@"rightTitle":@"请填写",@"text":@"",@"key":@"hukou"}
                           ],
                         @[@{@"leftTitle":@"工作类型",@"rightTitle":@"请选择",@"text":@"",@"key":@"jobs"},
                           @{@"leftTitle":@"工作经验",@"rightTitle":@"请选择",@"text":@"",@"key":@"years"},
                           @{@"leftTitle":@"月薪",@"rightTitle":@"请选择",@"text":@"",@"key":@"pay"}
                           ],
                         @[@{@"leftTitle":@"性别要求",@"rightTitle":@"请选择",@"text":@"",@"key":@"gender"},
                           @{@"leftTitle":@"年龄要求",@"rightTitle":@"请填写",@"text":@"",@"key":@"ages"},
                           @{@"leftTitle":@"住房要求",@"rightTitle":@"请选择",@"text":@"",@"key":@"house"}
                           ],
                         @[@{@"leftTitle":@"应聘方式",@"rightTitle":@"请选择",@"text":@"",@"key":@"tele"},
                           @{@"leftTitle":@"招聘人数",@"rightTitle":@"请填写",@"text":@"",@"key":@"nums"}
                           ],
                         @[@{@"leftTitle":@"岗位要求",@"rightTitle":@"请填写",@"text":@"",@"key":@"info"}
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
                           @{@"leftTitle":@"职位类别",@"rightTitle":@"请选择",@"text":model.cateName,@"key":@"cateName"}
                           ],
                         @[@{@"leftTitle":@"联系人",@"rightTitle":@"请选择",@"text":model.contactName,@"key":@"contactId"},
                           @{@"leftTitle":@"工作地点",@"rightTitle":@"请选择",@"text":model.area,@"key":@"area"}
                           ],
                         @[@{@"leftTitle":@"学历要求",@"rightTitle":@"请选择",@"text":model.edu,@"key":@"edu"},
                           @{@"leftTitle":@"户口要求",@"rightTitle":@"请填写",@"text":model.hukou,@"key":@"hukou"}
                           ],
                         @[@{@"leftTitle":@"工作类型",@"rightTitle":@"请选择",@"text":model.jobs,@"key":@"jobs"},
                           @{@"leftTitle":@"工作经验",@"rightTitle":@"请选择",@"text":model.years,@"key":@"years"},
                           @{@"leftTitle":@"月薪",@"rightTitle":@"请选择",@"text":model.pay,@"key":@"pay"}
                           ],
                         @[@{@"leftTitle":@"性别要求",@"rightTitle":@"请选择",@"text":model.gender,@"key":@"gender"},
                           @{@"leftTitle":@"年龄要求",@"rightTitle":@"请填写",@"text":model.ages,@"key":@"ages"},
                           @{@"leftTitle":@"住房要求",@"rightTitle":@"请选择",@"text":model.house,@"key":@"house"}
                           ],
                         @[@{@"leftTitle":@"应聘方式",@"rightTitle":@"请选择",@"text":model.tele,@"key":@"tele"},
                           @{@"leftTitle":@"招聘人数",@"rightTitle":@"请填写",@"text":model.nums,@"key":@"nums"}
                           ],
                         @[@{@"leftTitle":@"岗位要求",@"rightTitle":@"请填写",@"text":model.info,@"key":@"info"}
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

- (void)saveAction
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    for (NSArray *arr in self.dataArr) {
        
        for (ReleaseJobModel *model in arr) {
            
            if (model.text.length == 0) {
                [self.view makeToast:@"请完善发布新职位的信息"];
                return;
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
        
    }
    else {
        url = Post_position;

        // 剩余约聊岗位发布次数
        NSString *chatLast = [InfoCache unarchiveObjectWithFile:@"chatLast"];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发布职位" message:[NSString stringWithFormat:@"剩余约聊岗位发布%@次",chatLast] preferredStyle:UIAlertControllerStyleAlert];
        
        if (chatLast.integerValue > 0) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"可约聊" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [paramDic  setValue:@"1" forKey:@"chat"];

                [self position:url para:paramDic];
            }];
            [alertController addAction:cancelAction];

        }
        else {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
        }

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"不可约聊" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [paramDic  setValue:@"0" forKey:@"chat"];
            [self position:url para:paramDic];

            
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
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
        return 44;
        
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
        
    }
    ReleaseJobModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    cell.selectArr = _selectArr;
//    cell.selectJobArr = _selectJobArr;
    return cell;
}

@end
