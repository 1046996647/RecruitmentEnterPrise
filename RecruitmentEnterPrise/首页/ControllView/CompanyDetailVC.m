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
//#import "ShareVC.h"


@interface CompanyDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *modelArr;


@end

@implementation CompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self get_company_detail];
    [self initViews];


}


// 3.1	公司详情
- (void)get_company_detail
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [paraDic setValue:self.model.companyId forKey:@"companyId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_company_detail dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        JobModel *model = [JobModel yy_modelWithJSON:responseObject[@"data"]];
        self.model = model;
        
        NSArray *arr = responseObject[@"jobs"];
        if ([arr isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            self.modelArr = arrM;
            [self.tableView reloadData];
            
        }
        
        if (model) {
            [self initViews];
            
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
    logoView.backgroundColor = [UIColor yellowColor];
    [logoView sd_setImageWithURL:[NSURL URLWithString:self.model.logo] placeholderImage:[UIImage imageNamed:@""]];

    
    // @"浙江金狮工贸有限公司永康分公司"
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(logoView.right+21, logoView.top, kScreenWidth-12-(logoView.right+7), 19) text:self.model.company_name font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:companyLab];
    
    // @"五金机电"
    UILabel *decLab = [UILabel labelWithframe:CGRectMake(companyLab.left, companyLab.bottom+10, kScreenWidth-26-(logoView.right+7), 17) text:self.model.cate_name font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:decLab];
    
    // @"150人"
    UILabel *addressLab = [UILabel labelWithframe:CGRectMake(companyLab.left, decLab.bottom+5, 100, decLab.height) text:_model.persons font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
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
    
    // @"提供长期稳定的就业环境，不断提高员工的薪资水平。"
    UILabel *companyDecLab = [UILabel labelWithframe:CGRectMake(sameBtn.left, sameBtn.bottom+9, kScreenWidth-24, 16) text:_model.info font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:companyDecLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, companyDecLab.bottom+9, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    [headView addSubview:view];
    
    // 正在招聘的职位
    UIButton *wantBtn = [UIButton buttonWithframe:CGRectMake(jobDecLab.left, view.bottom+9, 125, 17) text:@"正在招聘的职位" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"46" selected:nil];
    wantBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [headView addSubview:wantBtn];
    
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
//    return self.modelArr.count;
    return 10;
    
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
//    cell.model = self.modelArr[indexPath.row];
    return cell;
}

@end
