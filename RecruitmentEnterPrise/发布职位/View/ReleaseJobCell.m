//
//  ReleaseJobCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReleaseJobCell.h"

@implementation ReleaseJobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        _imgView = [UIImageView imgViewWithframe:CGRectMake(kScreenWidth-12-6, 15, 6, 12) icon:@"44"];
        [self.contentView addSubview:_imgView];
        
        _leftLab = [UILabel labelWithframe:CGRectMake(12, 14, 58, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_leftLab];
        
        _rightLab = [UILabel labelWithframe:CGRectMake(_imgView.left-6-58, 15, 58, 14) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#D0021B"];
        [self.contentView addSubview:_rightLab];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(_leftLab.left, 45-1, kScreenWidth-_leftLab.left, .5)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
        [self.contentView addSubview:_line];
        
    }
    
    return self;
    
}

- (void)setModel:(ReleaseJobModel *)model
{
    _model = model;
    
    _leftLab.text = model.leftTitle;
    
    if (model.text.length == 0) {
        _rightLab.text = model.rightTitle;

    }
    else {
        _rightLab.text = model.text;

    }

}

@end
