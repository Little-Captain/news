//
//  LCNewsTableViewCell.m
//  news
//
//  Created by Liu-Mac on 24/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "LCNewsTableViewCell.h"

#import "LCNewsItem.h"

#import <UIImageView+WebCache.h>

@interface LCNewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UILabel *authorL;

@end

@implementation LCNewsTableViewCell

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5,5,80,60);
    float imgW =  self.imageView.image.size.width;
    // 如果有图像, 调整label的位置
    if(imgW > 0) {
        self.textLabel.frame = CGRectMake(95,
                                          self.textLabel.frame.origin.y,
                                          self.textLabel.frame.size.width,
                                          self.textLabel.frame.size.height);
        self.detailTextLabel.frame = CGRectMake(95,
                                                self.detailTextLabel.frame.origin.y,
                                                self.detailTextLabel.frame.size.width,
                                                self.detailTextLabel.frame.size.height);
    }
    
}

- (void)setItem:(LCNewsItem *)item {
    
    _item = item;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:item.thumbnail_pic_s] placeholderImage:[self createIconImage:CGSizeMake(80, 60)]];
    self.titleL.text = item.title;
    self.authorL.text = item.author_name;
    
}
     
- (UIImage *)createIconImage:(CGSize)size {

    UIGraphicsBeginImageContextWithOptions(size, NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;

}

@end
