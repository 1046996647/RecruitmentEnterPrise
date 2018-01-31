//
//  JobTableViewCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobCell.h"
#import "NSStringExt.h"

@implementation JobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     delegate:(id<ZFTableViewCellDelegate>)delegate
                  inTableView:(UITableView *)tableView
        withRightButtonTitles:(NSArray *)rightButtonTitles
        withRightButtonColors:(NSArray *)rightButtonColors type:(ZFTableViewCellType)type
                    rowHeight:(NSInteger)rowHeight
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier
                       delegate:delegate
                    inTableView:tableView
          withRightButtonTitles:rightButtonTitles
          withRightButtonColors:rightButtonColors
                           type:type
                      rowHeight:(NSInteger)rowHeight];
    
    if (self){
        
        self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
        self.cellContentView.backgroundColor = [UIColor clearColor];
        self.scrollView.scrollEnabled = NO;
        
        _selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 35, 60) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"Rectangle 11" selected:@"Rectangle 12"];
        [self.cellContentView addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(_selectBtn.right, 0, kScreenWidth-_selectBtn.right-10, 60)];
        baseView.layer.cornerRadius = 10;
        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.cellContentView addSubview:baseView];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(17, 11, 58, 17) text:@"猎头顾问" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [baseView addSubview:_nameLab];

        _viewBtn = [UIButton buttonWithframe:CGRectMake(22, _nameLab.bottom+10, 60, 13) text:@"118" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"106" selected:nil];
        _viewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _viewBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [baseView addSubview:_viewBtn];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(_viewBtn.right, _viewBtn.center.y-6, _viewBtn.height, _viewBtn.height) icon:@"聊天 (1)"];
        [baseView addSubview:_imgView];
        
        _editBtn = [UIButton buttonWithframe:CGRectMake(baseView.width-12-30, (baseView.height-30)/2, 30, 30) text:@"" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"102" selected:nil];
        _editBtn.tag = 2;
        [baseView addSubview:_editBtn];
        [_editBtn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _stateLab = [UILabel labelWithframe:CGRectMake(_editBtn.left-11-61, 19, 61, 22) text:@"招聘中" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
        _stateLab.layer.cornerRadius = _stateLab.height/2;
        _stateLab.layer.masksToBounds = YES;
        _stateLab.backgroundColor = colorWithHexStr(@"#D0021B");
        [baseView addSubview:_stateLab];
        _stateLab.userInteractionEnabled = YES;
        _stateLab.tag = 0;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
        [_stateLab addGestureRecognizer:tap1];
        
        _orderLab = [UILabel labelWithframe:CGRectMake(_stateLab.left-14-25, 22, 25, 18) text:@"1" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#999999"];
        _orderLab.layer.borderColor = [UIColor colorWithHexString:@"#979797"].CGColor;
        _orderLab.layer.borderWidth = 1;
        [baseView addSubview:_orderLab];
        _orderLab.userInteractionEnabled = YES;
        _orderLab.tag = 1;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
        [_orderLab addGestureRecognizer:tap2];
        


//        _refreshLab = [UILabel labelWithframe:CGRectMake(_orderLab.left-12-42, 19, 42, 22) text:@"刷新" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
//        _refreshLab.layer.cornerRadius = _stateLab.height/2;
//        _refreshLab.layer.masksToBounds = YES;
//        _refreshLab.backgroundColor = colorWithHexStr(@"#D0021B");
//        [baseView addSubview:_refreshLab];
//        _refreshLab.userInteractionEnabled = YES;
//        _refreshLab.tag = 2;
//        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
//        [_refreshLab addGestureRecognizer:tap3];

    }
    
    return self;
    
}

-(void)onButton:(UIButton *)btn {
    
    if (self.block) {
        self.block(_model,btn.tag);
    }
}

- (void)selectAction:(UIButton *)btn
{
    _model.isSelected = !_model.isSelected;
    
    if (self.block) {
        self.block(_model,0);
    }
}

- (void)gesAction:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    if (tag == 0) {
        
        if (self.vipLevel.integerValue == 0) {
            
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
        
        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
        
        [paraDic setValue:_model.jobId forKey:@"jobId"];
        
        
        [AFNetworking_RequestData requestMethodPOSTUrl:Alter_position_status dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
            
            _model.status = responseObject[@"jobStatus"];
            if (self.block) {
                self.block(nil,tag);
            }
            
        } failure:^(NSError *error) {
            
            
        }];
        

    }
    else if (tag == 1) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (int i=0; i<self.dataArr.count; i++) {
            [arrM addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [BRStringPickerView showStringPickerWithTitle:nil dataSource:arrM defaultSelValue:arrM[0] isAutoSelect:NO resultBlock:^(id selectValue) {
            
            _orderLab.text = selectValue;
            _model.ordid = selectValue;
            
            if (self.block) {
                self.block(_model,tag);
            }
            
        }];
    }
    else {
        
//        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
//        
//        [paraDic setValue:_model.jobId forKey:@"jobId"];
//        
//        
//        [AFNetworking_RequestData requestMethodPOSTUrl:Refresh_position dic:paraDic showHUD:YES response:NO Succed:^(id responseObject) {
//            
//            if (self.block) {
//                self.block(nil,tag);
//            }
//            
//        } failure:^(NSError *error) {
//            
//            
//        }];
    }
}

- (void)setModel:(ReleaseJobModel *)model
{
    _model = model;
    
    _nameLab.width = _orderLab.left-_nameLab.left-10;
    _nameLab.text = model.title;
    
    CGSize size = [NSString textLength:model.hits font:_viewBtn.titleLabel.font];
    _viewBtn.width = 20+size.width;
    _imgView.left = _viewBtn.right+10;
    
    [_viewBtn setTitle:model.hits forState:UIControlStateNormal];
    _orderLab.text = model.ordid;
    
    _selectBtn.selected = _model.isSelected;

    
    if (model.status.integerValue == 1) {

        _stateLab.text = @"招聘中";
        _stateLab.backgroundColor = [UIColor colorWithHexString:@"#D0021B"];
    }
    else {
        _stateLab.text = @"已关闭";
        _stateLab.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    }
    
    if (model.chatStatus.integerValue == 1) {
        _imgView.hidden = NO;
        
    }
    else {
        _imgView.hidden = YES;

    }
}











@end
