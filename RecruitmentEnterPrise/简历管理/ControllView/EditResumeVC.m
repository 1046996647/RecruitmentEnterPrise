//
//  EditResumeVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditResumeVC.h"
#import "HeaderView.h"
//#import "EditJobMsgVC.h"
//#import "EditEducationMsgVC.h"
#import "NSStringExt.h"
#import "UIImage+UIImageExt.h"
#import "InviteInterviewVC.h"


@interface EditResumeVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *titleArr1;
@property (nonatomic,strong) UILabel *signLabel;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *hopeLabel;
@property (nonatomic,strong) UIButton *userBtn;
@property(nonatomic,strong) UIButton *cellctionBtn;
@property(nonatomic,strong) UIView *footerView;



@end

@implementation EditResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    
    // 简历信息
    UIButton *userBtn = [UIButton buttonWithframe:CGRectMake(6, 14, 66, 66) text:nil font:nil textColor:nil backgroundColor:nil normal:@"" selected:nil];
//    [userBtn addTarget:self action:@selector(headImgAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:userBtn];
    self.userBtn = userBtn;
    userBtn.layer.cornerRadius = userBtn.height/2;
    userBtn.layer.masksToBounds = YES;
    
    if ([self.title isEqualToString:@"详情"]) {
        userBtn.userInteractionEnabled = NO;
        
    }
    
    // 天天
    UILabel *signLabel = [UILabel labelWithframe:CGRectMake(userBtn.right+16, 11, 40, 18) text:@"" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:signLabel];
    self.signLabel = signLabel;
    
    UIButton *editBtn = [UIButton buttonWithframe:CGRectMake(signLabel.right+11, signLabel.top, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"95" selected:nil];
//    [editBtn addTarget:self action:@selector(personalAction) forControlEvents:UIControlEventTouchUpInside];
//    [headView addSubview:editBtn];
    self.editBtn = editBtn;
    
    // 女|本科|两年|永嘉
    UILabel *infoLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, editBtn.bottom+5, 300, 14) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:infoLabel];
    self.infoLabel = infoLabel;
    
    // 188426835
    UILabel *phoneLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, infoLabel.bottom+5, 300, 14) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    
    // 我毕业于杭州大学，希望多多看我的简历哦~
    UILabel *hopeLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, phoneLabel.bottom+5, 300, 14) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:hopeLabel];
    self.hopeLabel = hopeLabel;
    
    headView.height = hopeLabel.bottom+12;
    
    NSArray *titleArr1 = @[@"求职意向",@"工作经历",@"教育经历",@"技能特长",@"联系方式"];
    self.titleArr1 = titleArr1;
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];


    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10+40+10)];
    self.footerView = footerView;

    CGFloat width = (kScreenWidth-12*4)/3;
    UIButton *inviteBtn = [UIButton buttonWithframe:CGRectMake(12, 10, width, 40) text:@"邀请面试" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    inviteBtn.layer.cornerRadius = 7;
    inviteBtn.layer.masksToBounds = YES;
    [footerView addSubview:inviteBtn];
    inviteBtn.tag = 0;
    [inviteBtn addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(inviteBtn.right+12, inviteBtn.top, width, 40) text:@"立即沟通" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    releseBtn.layer.cornerRadius = 7;
    releseBtn.layer.masksToBounds = YES;
    [footerView addSubview:releseBtn];
    releseBtn.tag = 1;

    
    UIButton *cellctionBtn = [UIButton buttonWithframe:CGRectMake(releseBtn.right+12, releseBtn.top, width, 40) text:@"加入收藏" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    cellctionBtn.layer.cornerRadius = 7;
    cellctionBtn.layer.masksToBounds = YES;
    [footerView addSubview:cellctionBtn];
    cellctionBtn.tag = 2;
    [cellctionBtn addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];


//    // 右上角按钮
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
//
//    [self.view addSubview:rightView];
//
//    UIButton *cellctionBtn = [UIButton buttonWithframe:CGRectMake(0, 10, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"Star" selected:@"Star Copy"];
//
//    [rightView addSubview:cellctionBtn];
////    [cellctionBtn addTarget:self action:@selector(cellctionAction) forControlEvents:UIControlEventTouchUpInside];
//    self.cellctionBtn = cellctionBtn;
//
////    if (_model.favs.integerValue == 0) {
////        cellctionBtn.selected = NO;
////    }
////    else {
////        cellctionBtn.selected = YES;
////
////    }
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    [self get_Resume_detail];

}

//- (void)cellctionAction
//
//{
//    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
//    if (!model) {
//        LoginVC *vc = [[LoginVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//        return;
//    }
//
//    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
//    [paraDic setValue:self.model.ID forKey:@"id"];
//
//    if (_model.favs.integerValue == 0) {
//        //        [paraDic setValue:@"0" forKey:@"del"];
//    }
//    else {
//        [paraDic setValue:@(1) forKey:@"del"];// 取消收藏
//
//    }
//
//    [AFNetworking_RequestData requestMethodPOSTUrl:Favs_job dic:paraDic showHUD:YES Succed:^(id responseObject) {
//
//        if ([responseObject[@"message"] isEqualToString:@"收藏成功"]) {
//            self.cellctionBtn.selected = YES;
//            _model.favs = @"1";
//        }
//        else {
//            self.cellctionBtn.selected = NO;
//            _model.favs = @"0";
//
//        }
//
//        [self.view makeToast:responseObject[@"message"]];
//
//
//    } failure:^(NSError *error) {
//
//
//    }];
//
//}


- (void)bottomAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        
        NSMutableArray *arrM = [NSMutableArray arrayWithObject:self.model];
        
        InviteInterviewVC *vc = [[InviteInterviewVC alloc] init];
        vc.title = @"邀请面试";
        vc.selectedArr = arrM;
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (btn.tag == 2) {
        
        NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
        [paramDic setValue:self.model.workerId forKey:@"workerId"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:Add_company_fav dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
            
            [self.view makeToast:@"收藏成功"];
            
        } failure:^(NSError *error) {
            
        }];
    }
}


// 返回用户表该用户相关信息
- (void)get_Resume_detail
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic setValue:self.model.workerId forKey:@"workerId"];
    [paramDic setValue:self.model.sendresumeId forKey:@"sendresumeId"];

    [AFNetworking_RequestData requestMethodPOSTUrl:Resume_detail dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        ResumeModel *model = [ResumeModel yy_modelWithJSON:responseObject[@"data"]];
        self.model = model;
        
//        [InfoCache archiveObject:model toFile:Person];
        
        NSMutableArray *arrM = [NSMutableArray array];
        NSArray *arr = responseObject[@"data"][@"jobhistory"];
        
        if ([arr isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in arr) {
                ResumeModel *model1 = [ResumeModel yy_modelWithJSON:dic];
                [arrM addObject:model1];
            }
        }
        
        if (model) {
            self.dataArr = @[@[model],arrM,@[model],@[model],@[model]];

        }
        
        [_tableView reloadData];


        [self.userBtn sd_setImageWithURL:[NSURL URLWithString:self.model.img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Rectangle 14"]];

        CGSize size = [NSString textLength:model.name font:self.signLabel.font];
        self.signLabel.width = size.width;
        self.signLabel.text = model.name;
        
        self.editBtn.left = self.signLabel.right+11;

        self.infoLabel.text = [NSString stringWithFormat:@"%@|%@岁|%@cm|%@kg",model.sex,model.age,model.height,model.weight];
        
        self.phoneLabel.text = [NSString stringWithFormat:@"%@  户籍：%@  所在地：%@",model.phone,model.jiguan,model.home];

        self.hopeLabel.text = [NSString stringWithFormat:@"%@ %@ %@年工作经验",model.marry,model.political,model.jobyear];
        

        if (model.permit.boolValue) {
            
            _tableView.tableFooterView = self.footerView;

        }
        else {
            _tableView.tableFooterView = nil;

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
//    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 1;
    
    if (section == 0) {
        
        if (self.model.requestjobtype.length == 0) {
            return 0;
        }


    } else if (section == 1) {
        
        return [self.dataArr[section] count];

        
    } else if (section == 2) {
        if (self.model.graduatedfrom.length == 0) {
            return 0;
        }

        
    } else if (section == 3) {
        
        if (self.model.foreignlanguage.length == 0) {
            return 0;
        }

        
    } else if (section == 4) {
        if (self.model.phone.length == 0) {
            return 0;
        }

    }
    return 1;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResumeModel *model = self.dataArr[indexPath.section][indexPath.row];

    if (model.cellHeight < 1) {
        return 96;// 默认值

    }
    else {
        return model.cellHeight;

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if ([self.title isEqualToString:@"详情"]) {
        if (section == 0) {
            
            if (self.model.requestjobtype.length == 0) {
                return 0.0001;
            }
            
            
        }  else if (section == 1) {
            
            if ([self.dataArr[section] count] == 0) {
                return 0.0001;

            }
            
            
        }  else if (section == 2) {
            if (self.model.graduatedfrom.length == 0) {
                return 0.0001;
            }
            
            
        } else if (section == 3) {
            
            if (self.model.foreignlanguage.length == 0) {
                return 0.0001;
            }
            
            
        } else if (section == 4) {
            if (self.model.phone.length == 0) {
                return 0.0001;
            }
            
        }
        
        return 35;
        
    }
    else {
        
        return 35;
    }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *imgArr = @[@"ic_current_location",@"24",@"23",@"22",@"21"];
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    [headerView.btn setTitle:self.titleArr1[section] forState:UIControlStateNormal];
    [headerView.btn setImage:[UIImage imageNamed:imgArr[section]] forState:UIControlStateNormal];
    
    if (section == 0 || section == 4) {
        headerView.hopeLabel.hidden = YES;
    }
    else {
        headerView.hopeLabel.hidden = NO;

    }
    
    if ([self.title isEqualToString:@"详情"]) {
        if (section == 0) {
            
            if (self.model.requestjobtype.length == 0) {
                return nil;
            }
            
            
        }  else if (section == 1) {
            
            if ([self.dataArr[section] count] == 0) {
                return nil;
                
            }
            
            
        }  else if (section == 2) {
            if (self.model.graduatedfrom.length == 0) {
                return nil;
            }
            
            
        } else if (section == 3) {
            
            if (self.model.foreignlanguage.length == 0) {
                return nil;
            }
            
            
        } else if (section == 4) {
            if (self.model.phone.length == 0) {
                return nil;
            }
            
        }
        
        return headerView;
        
    }
    else {
        
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.title isEqualToString:@"详情"]) {
        return 0.0001;// Group不能设置0

    }
    else {
        
        if (section == 0) {
            
            if (self.model.requestjobtype.length == 0) {
                return 62;
            }

            
        }  else if (section == 1) {
            
            return 62;

            
        }  else if (section == 2) {
            if (self.model.graduatedfrom.length == 0) {
                return 62;
            }
            
            
        } else if (section == 3) {
            
            if (self.model.foreignlanguage.length == 0) {
                return 62;
            }

            
        } else if (section == 4) {
            if (self.model.phone.length == 0) {
                return 62;
            }

        }

        return 0.0001;

    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if ([self.title isEqualToString:@"详情"]) {
//        footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        return nil;
    }
    else {
        
        NSArray *titleArr = @[@"+ 增加求职意向",@"+ 增加工作经历",@"+ 增加教育经历",@"+ 增加技能特长",@"+ 增加联系方式"];
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 62)];
        footView.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn = [UIButton buttonWithframe:CGRectMake(12, 14, kScreenWidth-24, 35) text:titleArr[section] font:[UIFont systemFontOfSize:14] textColor:@"#FF9123" backgroundColor:nil normal:@"" selected:nil];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor colorWithHexString:@"#FF9123"].CGColor;
        btn.layer.borderWidth = 1;
        [footView addSubview:btn];
        btn.tag = section;
//        [btn addTarget:self action:@selector(footAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (section == 0) {
            
            if (self.model.requestjobtype.length == 0) {
                return footView;
            }
            
            
        }  else if (section == 1) {
            return footView;

            
        }else if (section == 2) {
            if (self.model.graduatedfrom.length == 0) {
                return footView;
            }
            
            
        } else if (section == 3) {
            
            if (self.model.foreignlanguage.length == 0) {
                return footView;
            }
            
            
        } else if (section == 4) {
            if (self.model.phone.length == 0) {
                return footView;
            }
            
        }
        
        return nil;

    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditResumeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[EditResumeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.block = ^{
            
            if (self.model.permit.boolValue) {
                
                _tableView.tableFooterView = self.footerView;
                
            }
            else {
                _tableView.tableFooterView = nil;
                
            }
            [_tableView reloadData];
        };
    }
    cell.indexPath = indexPath;
    
    ResumeModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
     
    if ([self.title isEqualToString:@"详情"]) {
        cell.jobEditBtn.hidden = YES;
        
    }


    return cell;
}



@end
