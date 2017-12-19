//
//  CompanyDetailVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CompanyDetailVC.h"
#import "JobDetailCell.h"
//#import "JobDetailVC.h"


@interface CompanyDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *modelArr;


@end

@implementation CompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self preview_company_info];
//    [self initViews];


}

- (void)preview_company_info
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Preview_company_info dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        self.model = model;
        
        if (model) {
            [self initViews];
            
        }
        
        NSArray *arr = model.jobs;
        if ([arr isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            self.modelArr = arrM;
            [self.tableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)initViews
{
    // 头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    
    // 公司
//    UIButton *inBtn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreenWidth, 110) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
//    [headView addSubview:inBtn];
    //    [inBtn addTarget:self action:@selector(inAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *logoView = [UIImageView imgViewWithframe:CGRectMake(14, 17, 75, 75) icon:@""];
    [headView addSubview:logoView];
    logoView.layer.cornerRadius = 10;
    logoView.layer.masksToBounds = YES;
//    logoView.backgroundColor = [UIColor yellowColor];
    [logoView sd_setImageWithURL:[NSURL URLWithString:self.model.logo] placeholderImage:[UIImage imageNamed:@"Rectangle 14"]];

    
    // @"浙江金狮工贸有限公司永康分公司"
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(logoView.right+21, logoView.top, kScreenWidth-12-(logoView.right+7), 19) text:self.model.title font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:companyLab];
    
    // @"五金机电"
    UILabel *decLab = [UILabel labelWithframe:CGRectMake(companyLab.left, companyLab.bottom+10, kScreenWidth-26-(logoView.right+7), 17) text:self.model.cateName font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:decLab];
    
    // @"150人"
    UILabel *addressLab = [UILabel labelWithframe:CGRectMake(companyLab.left, decLab.bottom+5, 100, decLab.height) text:@"" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:addressLab];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, logoView.bottom+16, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    [headView addSubview:view];
    
    // 性质和网址
    UILabel *typeLab = [UILabel labelWithframe:CGRectMake(0, view.bottom+13, kScreenWidth/2, 20) text:@"公司性质" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [headView addSubview:typeLab];
    
    // @"民营"
    UILabel *typeLab1 = [UILabel labelWithframe:CGRectMake(typeLab.left, typeLab.bottom+5, typeLab.width, 18) text:_model.type font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [headView addSubview:typeLab1];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-1, view.bottom+11, 1, 44)];
    line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:line];
    
    UILabel *webLab = [UILabel labelWithframe:CGRectMake(kScreenWidth/2, typeLab.top, typeLab.width, 20) text:@"公司网址" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [headView addSubview:webLab];
    
    // 网址
    UILabel *webLab1 = [UILabel labelWithframe:CGRectMake(webLab.left, typeLab1.top, webLab.width, 18) text:_model.web font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#D0021B"];
    [headView addSubview:webLab1];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, webLab1.bottom+11, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    [headView addSubview:view];
    
    // 公司地址
    UIButton *decBtn = [UIButton buttonWithframe:CGRectMake(logoView.left, view.bottom+9, 87, 17) text:@"公司地址" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"48" selected:nil];
    decBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [headView addSubview:decBtn];
    decBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // @"浙江省永嘉市网生路2号"
    UILabel *jobDecLab = [UILabel labelWithframe:CGRectMake(decBtn.left, decBtn.bottom+12, kScreenWidth-decBtn.left*2, 18) text:_model.address font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:jobDecLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, jobDecLab.bottom+11, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    [headView addSubview:view];
    
    
    // 公司介绍
    UIButton *sameBtn = [UIButton buttonWithframe:CGRectMake(jobDecLab.left, view.bottom+9, 87, 17) text:@"公司介绍" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"47" selected:nil];
    sameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [headView addSubview:sameBtn];
    sameBtn.contentHorizontalAlignment = decBtn.contentHorizontalAlignment;
    
    // @"提供长期稳定的就业环境，不断提高员工的薪资水平。"
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(sameBtn.left, sameBtn.bottom+9, kScreenWidth-24, 200)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = colorWithHexStr(@"#999999");
    [headView addSubview:textView];
    //    self.textView = textView;
    textView.editable = NO;
    textView.text = _model.info;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, textView.bottom+9, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    [headView addSubview:view];
    
    // 正在招聘的职位
    UIButton *wantBtn = [UIButton buttonWithframe:CGRectMake(jobDecLab.left, view.bottom+9, 125, 17) text:@"正在招聘的职位" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"46" selected:nil];
    wantBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [headView addSubview:wantBtn];
    wantBtn.contentHorizontalAlignment = decBtn.contentHorizontalAlignment;

    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, wantBtn.bottom+9, kScreenWidth, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    headView.height = view.bottom;
    
    
    // 表视图
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headView;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
//    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobDetailCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[JobDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.model = self.modelArr[indexPath.row];
    return cell;
}

@end
