//
//  LCTabBar.m
//  Lottery(LC)
//
//  Created by Liu-Mac on 05/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "LCTabBar.h"

#import "LCTabBarBtn.h"

@interface LCTabBar ()

/** 保存当前选中的button */
@property (nonatomic, weak) LCTabBarBtn *selectedBtn;

@end

@implementation LCTabBar

// 创建按钮子控件, 为其设置数据
- (void)setTabBarItems:(NSArray *)tabBarItems {
    
    _tabBarItems = tabBarItems;
    
    // 添加tabBar中按钮
    for (UITabBarItem *item in tabBarItems) {
        // 使用自定义button, 因为我们要取消高亮显示
        LCTabBarBtn *btn = [LCTabBarBtn buttonWithType:UIButtonTypeCustom];
        // 设置图片
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        // 使用UIControlEventTouchDown事件, 按下事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
    }
    // 默认选中第一个
    [self btnClick:self.subviews[0]];
    
}

- (void)btnClick:(LCTabBarBtn *)btn {
    
    if (btn == self.selectedBtn) {
        return;
    }
    
    // 选中当前选中的按钮
    btn.selected = YES;
    
    // 取消上次选中的按钮
    self.selectedBtn.selected = NO;
    
    // 更新当前选中按钮
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:index:)]) {
        [self.delegate tabBar:self index:btn.tag];
    }
    
}

// 布局子控件
- (void)layoutSubviews {
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.bWidth / self.tabBarItems.count;
    CGFloat height = self.bHeight;
    
    NSUInteger index = 0;
    for (LCTabBarBtn *btn in self.subviews) {
        btn.tag = index; // 这个用于指示用户当前选中的是哪个btn
        btn.frame = CGRectMake(x + index * width, y, width, height);
        ++index;
    }
    
}

@end
