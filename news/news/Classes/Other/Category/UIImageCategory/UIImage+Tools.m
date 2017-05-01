//
//  UIImage+Tools.m
//  Lottery(LC)
//
//  Created by Liu-Mac on 05/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)

+ (instancetype)imageOfAlwaysOriginalWithImageNamed:(NSString *)name {

    return [[self imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

+ (UIImage *)imageOfResizableWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGSize size = image.size;
    
    return  [image resizableImageWithCapInsets:UIEdgeInsetsMake(size.height/2, size.width/2, size.height/2 - 1, size.width/2 -1)];
}

+ (UIImage *)imageWithCornerRadius:(CGFloat)radius imageNamed:(NSString *)name {
    
    // 取出原始图片
    UIImage *image = [UIImage imageNamed:name];
    
    // 开一个位图上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 得到当前上下文的rect
    CGRect contextRect = CGRectZero;
    contextRect.size = image.size;
    // 通过上下文rect和圆角半径绘制路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:contextRect cornerRadius:radius];
    // 设置为路径裁剪
    [path addClip];
    // 将路径加入图形上下文
    CGContextAddPath(context, path.CGPath);
    
    // 绘制原始图片
    [image drawInRect:contextRect];
    
    // 从图形上下文获取图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    // 返回圆角图片
    return image;    
    
}

@end
