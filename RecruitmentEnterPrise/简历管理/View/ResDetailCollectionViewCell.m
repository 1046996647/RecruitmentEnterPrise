//
//  ResDetailCollectionViewCell.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResDetailCollectionViewCell.h"

@implementation ResDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//        _imgView.image = [UIImage imageNamed:@"food"];
//        _imgView.backgroundColor = [UIColor redColor];
        _imgView.layer.cornerRadius = _imgView.height/2;
        _imgView.layer.masksToBounds = YES;
//        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgView];
        
        UILabel *nameLab = [UILabel labelWithframe:CGRectMake(0, _imgView.bottom+5, _imgView.width, 17) text:@"陈启平" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [self.contentView addSubview:nameLab];
        self.nameLab = nameLab;
    }
    return self;
}
- (void)setModel:(ResumeModel *)model
{
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"Rectangle 14"]];
    _nameLab.text = model.name;
}

@end
