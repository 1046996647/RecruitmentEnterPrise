//
//  SearchUITableView.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SearchUITableView.h"
#import "ReleaseJobCell.h"


@implementation SearchUITableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;// 滑动时收起键盘

        
        self.dataArr = @[@[@{@"leftTitle":@"求职者期望职位",@"rightTitle":@"请填写",@"text":@"",@"key":@"hopepostion"},
                           @{@"leftTitle":@"求职者编号",@"rightTitle":@"请填写",@"text":@"",@"key":@"workerId"},
                           @{@"leftTitle":@"籍贯",@"rightTitle":@"请填写",@"text":@"",@"key":@"jiguan"},
                           @{@"leftTitle":@"有无照片",@"rightTitle":@"请填写",@"text":@"不限",@"key":@"img"},
                           @{@"leftTitle":@"最近上网日期",@"rightTitle":@"请填写",@"text":@"不限",@"key":@"lastTime"},
                           @{@"leftTitle":@"求职者性别",@"rightTitle":@"请填写",@"text":@"不限",@"key":@"sex"},
                           @{@"leftTitle":@"求职者专业",@"rightTitle":@"请填写",@"text":@"",@"key":@"speciality"},
                           @{@"leftTitle":@"求职者工作经历",@"rightTitle":@"请填写",@"text":@"",@"key":@"jobhistory"},
                           @{@"leftTitle":@"求职者学历",@"rightTitle":@"请填写",@"text":@"不限",@"key":@"education"},
                           @{@"leftTitle":@"求职者年龄",@"rightTitle":@"请填写",@"text":@"",@"key":@"key"},
                           @{@"leftTitle":@"期望工作地点",@"rightTitle":@"请填写",@"text":@"不限",@"key":@"hopelocation"},
                           @{@"leftTitle":@"姓名",@"rightTitle":@"请填写",@"text":@"",@"key":@"name"}
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
    
        
        // 尾视图
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 34+40)];
        
        UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, 17, kScreenWidth-50, 40) text:@"立即搜索" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
        releseBtn.layer.cornerRadius = 7;
        releseBtn.layer.masksToBounds = YES;
        [footerView addSubview:releseBtn];
        [releseBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];

        
        self.tableFooterView = footerView;
        
        // 选择项数据
        NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
        self.selectArr = selectArr;

    }
    return self;
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
    return 10;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
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

- (void)saveAction
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary  alloc]initWithCapacity:0];
    
    for (NSArray *arr in self.dataArr) {
        
        for (ReleaseJobModel *model in arr) {
            
            if ([model.leftTitle isEqualToString:@"求职者年龄"]) {
                
                if (model.minAge.length == 0) {
                    [paramDic  setValue:@"不限" forKey:@"minAge"];
                    
                }
                else {
                    [paramDic  setValue:model.minAge forKey:@"minAge"];
                    
                }
                
                if (model.maxAge.length == 0) {
                    [paramDic  setValue:@"不限" forKey:@"maxAge"];
                    
                }
                else {
                    [paramDic  setValue:model.maxAge forKey:@"maxAge"];
                    
                }
                
            }
            else {
                
                if (model.text.length == 0) {
                    [paramDic  setValue:@"不限" forKey:model.key];
                    
                }
                else {
                    [paramDic  setValue:model.text forKey:model.key];
                    
                }
                
            }
        }
        
        
        
    }
    
    if (self.block) {
        self.block(paramDic);
    }
    NSLog(@"%@",paramDic);

}

@end
