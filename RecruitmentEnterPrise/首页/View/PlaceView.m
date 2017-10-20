//
//  PlaceView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PlaceView.h"
#import "HotJobCell.h"

@implementation PlaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.dataArr = @[@"一天内",@"三天内",@"一周内",@"半月内",@"一个月内",@"三个月内",@"半年内",@"不限"];
        
        // 这样会有冲突
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//        [self addGestureRecognizer:tap];
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];

        
        UILabel *hotLab = [UILabel labelWithframe:CGRectMake(15, 18, 50, 17) text:@"时间" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [baseView addSubview:hotLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(hotLab.left, hotLab.bottom+7, kScreenWidth-hotLab.left*2, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#EFCBD0"];
        [baseView addSubview:line];
        
        //
        CGFloat width = (kScreenWidth-24-23*2)/3;
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(width, 26);
        //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 12;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, line.bottom+11, kScreenWidth,26*3+12*2) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        //        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[HotJobCell class] forCellWithReuseIdentifier:@"cellID"];
        collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
        [baseView addSubview:collectionView];
        
        baseView.height = collectionView.bottom+12;
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
//    return 6;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.block) {
        self.block(self.dataArr[indexPath.row]);
    }
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotJobCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.jobLab.text = self.dataArr[indexPath.row];
    return cell;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    if (self.block) {
        self.block(nil);
    }
}

//- (void)tapAction
//{
//    [self removeFromSuperview];
//    self.imgView.image = [UIImage imageNamed:@"55"];
//
//}

@end
