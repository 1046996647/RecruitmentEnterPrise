//
//  SearchUITableView.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchTableViewBlock)(NSMutableDictionary *dic);

@interface SearchUITableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,copy) SearchTableViewBlock block;


@end
