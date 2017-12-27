//
//  HeadhuntDetailVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/12/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HeadhuntDetailVC.h"
#import "NSStringExt.h"

@interface HeadhuntDetailVC ()

@property(nonatomic,strong) NSString *text;


@end

@implementation HeadhuntDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.title isEqualToString:@"猎头简介"]) {
        self.text = @"众信猎头（Z-xin Headhunter）是一家专业从事中高级人才猎头服务的咨询公司，公司立足于金华（主要以永康、武义、缙云为主），面向全国寻访合适的人才。众信猎头自2004年公司成立以来，凭借储备丰富的中高级人才库、训练有素的团队、专业化的工作流程、先进快捷的信息技术手段，已成功的与众多企业建立起互惠互利的合作伙伴关系，并为我们的客户成功寻访到销售、市场、生产运营、技术、品质、财务、人事等相关高级管理人员及专业人才。";
    }
    if ([self.title isEqualToString:@"服务行业"]) {
        self.text = @"机械制造、机电设备、模具，家居用品，纺织品业 ，五金及DIY用品，印刷、包装、造纸 ，汽车、摩托车及配件，电子元器件、电子及电脑产品。\n1、服务介绍：根据客户提供的职位要求，发布招聘信息，并通过专业渠道获取人才信息，采取专业的人才评价技术筛选后推荐给客户，全程跟踪服务至人才正式录用，根据协议约定进行事前事后付费。\n2、优势分析：这是一种最通常的猎头服务方式，相对合理的费用获取相应价值的服务。在及时性、准确性、适合性等方面有较好的保障。\n3、适用企业：适用一般具有一定实力企业的中高端人才需求。";
    }
    if ([self.title isEqualToString:@"收费标准"]) {
        self.text = @"1、服务费总额：通过乙方推荐，甲方每成功录用一名候选人的委托服务费为其年薪（针对销售经理/总监、外贸经理/总监等基本工资加提成方式计算薪酬的按固定年薪15万计算费用，固定年薪超过15万的按实际薪资计算，普通销售及业务员等按年薪6万计算）的20%作为服务费用。推荐成功一人，收取一人的费用。\n2、支付方式：客户方需在合同签订后一个工作日内支付人民币 6000元整作为合同启动资金。（用于保证客户委托职位的真实性及防止以招聘为名窃取被推荐人的知识产权及信息，同时也用于支付寻访费用），甲方一经成功录用乙方所推荐的人选，应在二日内书面通知乙方，并在人员上岗后的一个月内支付乙方全部委托服务费。\n3、所有付款将以支票或银行转账或现金方式支付；";
    }
    if ([self.title isEqualToString:@"联系方式"]) {
        self.text = @"客户服务电话：0579-83840599\n手机：13858924279\n传真：0579-86874216\n邮箱：wang1978223@126.com\nfhlzfx@163.com\n地址：永康市丽州南路136-138号3楼   邮编：321300";
        
    }
    
    UILabel *label = [UILabel labelWithframe:CGRectMake(20, 10, kScreenWidth-40, 0) text:self.text font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    CGSize size = [NSString textHeight:self.text font:label.font width:label.width];
    label.height = size.height+10;
    
    if ([self.title isEqualToString:@"联系方式"]) {
        self.text = @"客户服务电话：0579-83840599\n手机：13858924279\n传真：0579-86874216\n邮箱：wang1978223@126.com\nfhlzfx@163.com\n地址：永康市丽州南路136-138号3楼\n邮编：321300";
        
        UIButton *btn1 = [UIButton buttonWithframe:CGRectMake(0, 15, label.width, 15) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"" selected:@""];
        [self.view addSubview:btn1];
        [btn1 addTarget:self action:@selector(callAction1) forControlEvents:UIControlEventTouchUpInside];
//        btn1.backgroundColor = [UIColor redColor];
        
        UIButton *btn2 = [UIButton buttonWithframe:CGRectMake(0, btn1.bottom, label.width, 15) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"" selected:@""];
        [self.view addSubview:btn2];
        [btn2 addTarget:self action:@selector(callAction2) forControlEvents:UIControlEventTouchUpInside];
//        btn1.backgroundColor = [UIColor redColor];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callAction1
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"0579-83840599"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
    
}

- (void)callAction2
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"13858924279"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
    
}

@end
