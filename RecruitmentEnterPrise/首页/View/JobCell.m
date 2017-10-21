//
//  JobTableViewCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobCell.h"

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
        
        _selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 35, 60) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"Rectangle 11" selected:@"Rectangle 12"];
        [self.cellContentView addSubview:_selectBtn];
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(_selectBtn.right, 0, kScreenWidth-_selectBtn.right-10, 60)];
        baseView.layer.cornerRadius = 10;
        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.cellContentView addSubview:baseView];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(17, 11, 58, 17) text:@"猎头顾问" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [baseView addSubview:_nameLab];

        _viewBtn = [UIButton buttonWithframe:CGRectMake(22, _nameLab.bottom+10, 120, 13) text:@"118" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"106" selected:nil];
        _viewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _viewBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [baseView addSubview:_viewBtn];
        
        _stateLab = [UILabel labelWithframe:CGRectMake(baseView.width-11-61, 19, 61, 22) text:@"招聘中" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
        _stateLab.layer.cornerRadius = _stateLab.height/2;
        _stateLab.layer.masksToBounds = YES;
        _stateLab.backgroundColor = colorWithHexStr(@"#D0021B");
        [baseView addSubview:_stateLab];
        
        _orderLab = [UILabel labelWithframe:CGRectMake(_stateLab.left-14-25, 22, 25, 18) text:@"1" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#999999"];
        _orderLab.layer.borderColor = [UIColor colorWithHexString:@"#979797"].CGColor;
        _orderLab.layer.borderWidth = 1;
        [baseView addSubview:_orderLab];
        
        
        
    }
    
    return self;
    
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//}

@end
