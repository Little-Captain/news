//
//  LCTabBar.h
//  Lottery(LC)
//
//  Created by Liu-Mac on 05/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCTabBar;

@protocol LCTabBarProtocol <NSObject>

@optional
- (void)tabBar:(LCTabBar *)tabBar index:(NSUInteger)index;

@end

@interface LCTabBar : UIView

// 这个模型数组用于传递tabBarVC传入的tabBarItems
// 这些数据用于设置自定义tabBar, 图片个数等
/** items */
@property (nonatomic, strong) NSArray *tabBarItems;

@property (nonatomic, weak) id<LCTabBarProtocol> delegate;

@end
