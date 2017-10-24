//
//  ContactManageCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ContactManageCell.h"

@implementation ContactManageCell


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
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 100)];
        //        baseView.layer.cornerRadius = 10;
        //        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.cellContentView addSubview:baseView];
        
        
        _timeLab = [UILabel labelWithframe:CGRectMake(baseView.width-68-8, 44, 68, 13) text:@"2015-08-29" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [baseView addSubview:_timeLab];
        
        _bodyBtn = [UIButton buttonWithframe:CGRectMake(20, 17, 200, 17) text:@"陈先生" font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:@"35" selected:nil];
        _bodyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _bodyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _bodyBtn.userInteractionEnabled = NO;
        [baseView addSubview:_bodyBtn];
        
        
        _eduBtn = [UIButton buttonWithframe:CGRectMake(_bodyBtn.left, _bodyBtn.bottom+9, _bodyBtn.width, _bodyBtn.height) text:@"356335205@qq.com" font:SystemFont(13) textColor:@"#999999" backgroundColor:nil normal:@"34" selected:nil];
        _eduBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置UIControlContentHorizontalAlignmentLeft，所以UIEdgeInsetsMake只能设置left
        _eduBtn.titleEdgeInsets = _bodyBtn.titleEdgeInsets;
        _eduBtn.userInteractionEnabled = NO;
        [baseView addSubview:_eduBtn];
        
        
        _chatBtn = [UIButton buttonWithframe:CGRectMake(_bodyBtn.left, _eduBtn.bottom+9, _bodyBtn.width, _bodyBtn.height) text:@"18842682580" font:SystemFont(13) textColor:@"#999999" backgroundColor:nil normal:@"33" selected:nil];
        _chatBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置UIControlContentHorizontalAlignmentLeft，所以UIEdgeInsetsMake只能设置left
        _chatBtn.titleEdgeInsets = _bodyBtn.titleEdgeInsets;
        _chatBtn.userInteractionEnabled = NO;
        [baseView addSubview:_chatBtn];
        
    }
    
    return self;
    
}

@end
