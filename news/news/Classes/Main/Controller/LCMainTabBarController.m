//
//  LCMainTabBarController.m
//  news
//
//  Created by Liu-Mac on 24/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "LCMainTabBarController.h"

#import "LCMainNavigationController.h"

#import "LCNewsViewController.h"

#import "LCTabBar.h"

#import "UIImage+Tools.h"

@interface LCMainTabBarController () <LCTabBarProtocol>

// 将自带tabBarItem添加入这个模型数组, 传入自定义tabBar
/** items */
@property (nonatomic, strong) NSMutableArray *tabBarItems;

@end

@implementation LCMainTabBarController

- (NSMutableArray *)tabBarItems {
    
    if (!_tabBarItems) {
        _tabBarItems = [NSMutableArray array];
    }
    
    return _tabBarItems;
    
}

// 移除系统自带的tabBar上的子控件
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[LCTabBar class]]) {
            [view removeFromSuperview];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 添加子控制器
    [self addAllChildViewController];
    
    [self setUpTabBar];
    LogHomeDirectory;
}

- (void)addAllChildViewController {
    
    UIViewController *newsVC = [[LCNewsViewController alloc] init];
    [self addOneChildViewController:newsVC image:@"news" selImage:@"news_selected" title:@"新闻"];
    
    UIViewController *myVC = [[UIViewController alloc] init];
    [self addOneChildViewController:myVC image:@"star" selImage:@"star_selected" title:@"我的"];
}

- (void)addOneChildViewController:(UIViewController *)vc image:(NSString *)image selImage:(NSString *)sel title:(NSString *)title {

    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:sel];
    vc.title = title;
    [self.tabBarItems addObject:vc.tabBarItem];
    
    LCMainNavigationController *nav = [[LCMainNavigationController alloc] initWithRootViewController:vc];
    nav.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}

- (void)setUpTabBar {
    
    LCTabBar *tabBar = [[LCTabBar alloc] init];
    tabBar.tabBarItems = self.tabBarItems;
    tabBar.frame = self.tabBar.bounds;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    
}

#pragma mark - LCTabBarProtocol

- (void)tabBar:(LCTabBar *)tabBar index:(NSUInteger)index {
    
    self.selectedIndex = index;
    
}

@end
