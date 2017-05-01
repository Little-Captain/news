//
//  LCHomeLabel.m
//  01-网易新闻首页
//
//  Created by Liu-Mac on 10/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "LCHomeLabel.h"
#import "LCConst.h"

const CGFloat LCRed   = 0.4;
const CGFloat LCGreen = 0.7;
const CGFloat LCBlue  = 0.6;
const CGFloat LCAlpha = 1.0;

@implementation LCHomeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.textColor = [UIColor colorWithRed:LCRed green:LCGreen blue:LCBlue alpha:LCAlpha]; // 未选中颜色001
        self.font = [UIFont systemFontOfSize:17.0]; // 未选中字体大小17.0
    }
    
    return self;
    
}

- (void)setScale:(CGFloat)scale {
    
    _scale = scale;
    
    // 根据比例调整大小
    CGFloat transformScale = 1.0 + scale*0.3;
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
    
    // 根据比例调整文字颜色 (scale == 1.0时的颜色是101)
    CGFloat red   = LCRed   + (1 - LCRed)   * scale;
    CGFloat green = LCGreen + (0 - LCGreen) * scale;
    CGFloat blue  = LCBlue  + (1 - LCBlue)  * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:LCAlpha];
    
}

@end
