//
//  InviteInterviewCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/23.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"


@interface InviteInterviewCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong) UIImageView *leftImgView;
@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UIButton *saveBtn;
@property(nonatomic,strong) UIImageView *imgView;

@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UITextView *tv;
@property(nonatomic,strong) UILabel *remindLabel;



@property(nonatomic,strong) ContactModel *model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;


@end
