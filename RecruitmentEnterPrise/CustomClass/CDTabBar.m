//
//  CDTabBar.m
//  CustomTabbar
//
//  Created by Dong Chen on 2017/9/1.
//  Copyright © 2017年 Dong Chen. All rights reserved.
//

#import "CDTabBar.h"

@interface CDTabBar()
@property (nonatomic, strong) UIButton *secBtn;
@property (nonatomic, strong) UIButton *thdBtn;
@end

@implementation CDTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width/4.0;
    
    UIButton *sendBtn = [[UIButton alloc] init];
    sendBtn.frame = CGRectMake(w, 0, w, self.height);
//    sendBtn.backgroundColor = [UIColor redColor];
//    [sendBtn setImage:[UIImage imageNamed:@"tabar_plus_normal"] forState:UIControlStateNormal];
//    [sendBtn setTitle:@"发布" forState:UIControlStateNormal];
//    sendBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [sendBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
//    sendBtn.adjustsImageWhenHighlighted = NO;
//    sendBtn.size = CGSizeMake(w, 70);
//    sendBtn.centerX = self.width / 2;
//    sendBtn.centerY = 12;
//    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:sendBtn];
    self.secBtn = sendBtn;
    sendBtn.tag = 0;
    
    sendBtn = [[UIButton alloc] init];
    sendBtn.frame = CGRectMake(w*2, 0, w, self.height);
    //    sendBtn.backgroundColor = [UIColor redColor];
    //    [sendBtn setImage:[UIImage imageNamed:@"tabar_plus_normal"] forState:UIControlStateNormal];
    //    [sendBtn setTitle:@"发布" forState:UIControlStateNormal];
    //    sendBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [sendBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    sendBtn.adjustsImageWhenHighlighted = NO;
    //    sendBtn.size = CGSizeMake(w, 70);
    //    sendBtn.centerX = self.width / 2;
    //    sendBtn.centerY = 12;
    //    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:sendBtn];
    self.thdBtn = sendBtn;
    sendBtn.tag = 1;

    

    // 其他位置按钮
//    NSUInteger count = self.subviews.count;
//    for (NSUInteger i = 0 , j = 0; i < count; i++)
//    {
//        UIView *view = self.subviews[i];
//        Class class = NSClassFromString(@"UITabBarButton");
//        if ([view isKindOfClass:class])
//        {
//            view.width = self.width / 4.0;
//            view.left = self.width * j / 4.0;
//            j++;
//            if (j == 1)
//            {
//                j++;
//            }
//        }
//    }

}
// 发布
- (void)didClickPublishBtn:(UIButton*)sender {
    if (self.didSecBtn) {
        self.didSecBtn(sender.tag);
    }

}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden == NO)
    {
        CGPoint newP = [self convertPoint:point toView:self.secBtn];
        CGPoint newP1 = [self convertPoint:point toView:self.thdBtn];
        if ([self.secBtn pointInside:newP withEvent:event])
        {
            return self.secBtn;
        } else if ([self.thdBtn pointInside:newP1 withEvent:event]) {
            return self.thdBtn;

        }
        else
        {
            return [super hitTest:point withEvent:event];
        }
    }
    else
    {
        return [super hitTest:point withEvent:event];
    }
}

@end
