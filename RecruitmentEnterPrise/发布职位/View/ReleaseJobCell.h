//
//  ReleaseJobCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReleaseJobModel.h"
#import "BRPickerView.h"
#import "HXTagsView.h"
#import "YZTagList.h"

typedef void(^ReleaseJobBlock)(void);


@interface ReleaseJobCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *leftLab;
@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UIButton *saveBtn;
@property(nonatomic,strong) ReleaseJobModel *model;
@property(nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSArray *selectJobArr;

//
@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UITextField *tf1;
@property(nonatomic,strong) UITextField *tf2;
@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong) UILabel *label2;

@property(nonatomic,strong) UIView *baseView1;
@property(nonatomic,strong) UITextView *tv;
@property(nonatomic,strong) UILabel *remindLabel;
@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,copy) ReleaseJobBlock block;
@property(nonatomic,strong) NSMutableArray *tagArr;
//@property (nonatomic, strong) YZTagList *tagList;


@end
