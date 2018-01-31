//
//  EditResumeCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditResumeCell.h"
#import "ResumeManageVC.h"
//#import "EditEducationMsgVC.h"


@implementation EditResumeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(_imgView.center.x-.5, 0, 1, 71)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self.contentView addSubview:_line];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(10, (self.contentView.height-14)/2.0, 12, 12) icon:@"25"];
        [self.contentView addSubview:_imgView];

        _timeLab = [UILabel labelWithframe:CGRectMake(_imgView.right+11, 10, 97, 20) text:@"2016.09-2017.09" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_timeLab];
//        _timeLab.backgroundColor = [UIColor greenColor];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callAction)];
        [_timeLab addGestureRecognizer:tap];
        
        _hLine = [[UIView alloc] initWithFrame:CGRectZero];
        _hLine.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self.contentView addSubview:_hLine];
        
        _jobLab = [UILabel labelWithframe:CGRectMake(_timeLab.left, _timeLab.bottom+6, 150, _timeLab.height) text:@"福田店面销售代表" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_jobLab];
        
        _companyLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _jobLab.bottom+6, 150, _timeLab.height) text:@"福田龙飞进出口有限公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        _companyLab.numberOfLines = 0;
        [self.contentView addSubview:_companyLab];
        
        _responsibilityLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _companyLab.bottom+6, kScreenWidth-12-(_jobLab.left), _timeLab.height) text:@"独立完成项目，从交互原型到效果图设计、切图标注等工作。" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        _responsibilityLab.numberOfLines = 0;
        [self.contentView addSubview:_responsibilityLab];
        
        _extraLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _responsibilityLab.bottom+6, kScreenWidth-12-(_jobLab.left), _timeLab.height) text:@"自我评价" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        _extraLab.numberOfLines = 0;
        [self.contentView addSubview:_extraLab];
    
        _hLine1 = [[UIView alloc] initWithFrame:CGRectZero];
        _hLine1.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self.contentView addSubview:_hLine1];
        
        _jobEditBtn = [UIButton buttonWithframe:CGRectMake(kScreenWidth-20-10, 8, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"95" selected:nil];
//        [_jobEditBtn addTarget:self action:@selector(jobEditAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_jobEditBtn];
//        self.jobEditBtn = jobEditBtn;
        
        _contactBtn = [UIButton buttonWithframe:CGRectMake(12, 10, 100, 40) text:@"联系方式" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
        [_contactBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
        _contactBtn.layer.cornerRadius = 7;
        _contactBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:_contactBtn];
        
//        _view = [[UIView alloc] initWithFrame:CGRectMake(_jobLab.left, lin.bottom+9, kScreenWidth-38, 1)];
//        _view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
//        [self.contentView addSubview:_view];
        
    }
    return self;
}

- (void)contactAction
{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [paraDic setValue:self.model.workerId forKey:@"workerId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:View_contact dic:paraDic showHUD:YES response:YES Succed:^(id responseObject) {
        
        NSNumber *code = responseObject[@"status"];
        if (code.integerValue == 0) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请联系客服充值会员" message:ServerPhone preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"联系客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",ServerPhone];
                UIWebView *callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            [self.viewController presentViewController:alertController animated:YES completion:nil];
            
            return ;
        }
        
        self.model.permit = @"1";

        if (self.block) {
            self.block();
        }
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)setModel:(ResumeModel *)model
{
    _model = model;
    
    _jobEditBtn.hidden = NO;
    _timeLab.hidden = NO;
    _jobLab.hidden = NO;
    _companyLab.hidden = NO;
    _responsibilityLab.hidden = NO;
    _contactBtn.hidden = YES;
    
    _timeLab.userInteractionEnabled = NO;

    if (self.indexPath.section == 0) {
        _imgView.hidden = YES;
        _line.hidden = YES;
        _hLine1.hidden = YES;
        _hLine.hidden = NO;
        _extraLab.hidden = YES;
        _responsibilityLab.hidden = YES;

        _timeLab.frame = CGRectMake(12, 10, kScreenWidth-12, 20);
        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreenWidth-28, 1);
        _jobLab.frame = CGRectMake(_timeLab.left, _hLine.bottom+6, _timeLab.width, _timeLab.height);
        //        _responsibilityLab.frame = CGRectMake(12, 10, kScreenWidth-50, 14);



        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        CGSize size = [NSString textHeight:model.jobstatus font:_companyLab.font width:_companyLab.width];
        _companyLab.height = size.height;
        
        _timeLab.text = model.hopepostion;
        _jobLab.text = [NSString stringWithFormat:@"%@|%@|%@|%@",model.requestjobtype,model.hopelocation,model.requestsalary,model.requeststay];
        _companyLab.text = model.jobstatus;


        model.cellHeight = _companyLab.bottom+12;
    }
    
    if (self.indexPath.section == 1) {
        _imgView.hidden = NO;
        _line.hidden = NO;
        _hLine.hidden = YES;
        _extraLab.hidden = YES;

        _timeLab.frame = CGRectMake(_imgView.right+12, 10, kScreenWidth-(_imgView.right+12), 20);
//        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreenWidth-28, 14);
        _jobLab.frame = CGRectMake(_timeLab.left, _timeLab.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        
        NSString *beginTime = [model.begin_time stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *endTime = [model.end_time stringByReplacingOccurrencesOfString:@"-" withString:@"."];

        _timeLab.text = [NSString stringWithFormat:@"%@-%@",beginTime,endTime];
        _jobLab.text = model.position;
        _companyLab.text = [NSString stringWithFormat:@"%@ %@",model.company_name,model.company_nature];
        
        _responsibilityLab.hidden = NO;

        CGSize size = [NSString textHeight:model.skill font:_responsibilityLab.font width:_responsibilityLab.width];
        _responsibilityLab.frame = CGRectMake(_timeLab.left, _companyLab.bottom+6, kScreenWidth-_timeLab.left-12, size.height);
        _responsibilityLab.text = model.skill;
        
        _hLine1.hidden = NO;
        _hLine1.frame = CGRectMake(_timeLab.left, _responsibilityLab.bottom+11, kScreenWidth-_timeLab.left-12, 1);
        
        if (self.indexPath.row == 0) {
            _jobEditBtn.hidden = NO;
            _line.frame = CGRectMake(_imgView.center.x-.5, _imgView.bottom, 1, _hLine1.bottom-_imgView.bottom);

        }
        else {
            _jobEditBtn.hidden = YES;
            _line.frame = CGRectMake(_imgView.center.x-.5, 0, 1, _hLine1.bottom);
            
        }
        
        model.cellHeight = _hLine1.bottom+1;


    }
    if (self.indexPath.section == 2) {
        _imgView.hidden = YES;
        _line.hidden = YES;
        _hLine.hidden = YES;
        _hLine1.hidden = YES;
        _extraLab.hidden = YES;

        _timeLab.frame = CGRectMake(12, 10, kScreenWidth-12, 20);
        //        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreenWidth-28, 14);
        _jobLab.frame = CGRectMake(_timeLab.left, _timeLab.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        _responsibilityLab.hidden = NO;
        _responsibilityLab.frame = CGRectMake(12, _companyLab.bottom+6, kScreenWidth-24, 14);
        
        _timeLab.text = model.graduatedfrom;
        _jobLab.text = [NSString stringWithFormat:@"%@ %@",model.education,model.speciality];
        
        NSString *graduatetime = [model.graduatetime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        _companyLab.text = graduatetime;
        
        CGSize size = [NSString textHeight:model.educationhistory font:_responsibilityLab.font width:_responsibilityLab.width];
        _responsibilityLab.height = size.height;
        _responsibilityLab.text = model.educationhistory;
        
        model.cellHeight = _responsibilityLab.bottom+12;
    }
    
    if (self.indexPath.section == 3) {
        _imgView.hidden = YES;
        _line.hidden = YES;
        _hLine.hidden = YES;
        _hLine1.hidden = YES;
        _extraLab.hidden = NO;

        _timeLab.frame = CGRectMake(12, 10, kScreenWidth-12, 20);
        //        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreenWidth-28, 14);
        _jobLab.frame = CGRectMake(_timeLab.left, _timeLab.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        _responsibilityLab.hidden = NO;
        _responsibilityLab.frame = CGRectMake(12, _companyLab.bottom+6, kScreenWidth-12, 14);
        _extraLab.frame = CGRectMake(_timeLab.left, _responsibilityLab.bottom+6, _timeLab.width, _timeLab.height);
        
        _timeLab.text = [NSString stringWithFormat:@"%@ %@",model.foreignlanguage,model.foreignlanguagelevel];
        _jobLab.text = [NSString stringWithFormat:@"计算机水平 %@",model.computerlevel];
        _companyLab.text = [NSString stringWithFormat:@"相关证书：%@",model.certificate];
        _responsibilityLab.text = [NSString stringWithFormat:@"其他能力：%@",model.otherability];

        CGSize size = [NSString textHeight:model.selfevaluation font:_extraLab.font width:_extraLab.width];
        _extraLab.height = size.height;
        _extraLab.text = model.selfevaluation;
        
        model.cellHeight = _extraLab.bottom+12;

        
    }
    if (self.indexPath.section == 4) {
        _imgView.hidden = YES;
        _line.hidden = YES;
        _hLine.hidden = YES;
        _hLine1.hidden = YES;
        _extraLab.hidden = YES;
        
        _timeLab.userInteractionEnabled = YES;

        _timeLab.frame = CGRectMake(12, 10, kScreenWidth-12, 20);
        //        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreenWidth-28, 14);
        _jobLab.frame = CGRectMake(_timeLab.left, _timeLab.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        _responsibilityLab.hidden = YES;
//        _responsibilityLab.frame = CGRectMake(12, 10, kScreenWidth-50, 14);
        
        _timeLab.text = model.phone;
        _jobLab.text = [NSString stringWithFormat:@"QQ:%@ %@",model.qq,model.email];
        _companyLab.text = model.address;
        
        if (!model.permit.boolValue) {
            _timeLab.hidden = YES;
            _jobLab.hidden = YES;
            _companyLab.hidden = YES;
            _responsibilityLab.hidden = YES;
            _contactBtn.hidden = NO;
            
            model.cellHeight = _contactBtn.bottom+12;

        }
        else {
            model.cellHeight = _companyLab.bottom+12;

        }



    }
    

    
}

- (void)callAction
{
    if (self.model.phone) {
        //    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.tele];
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.phone];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    }
    
}

@end
