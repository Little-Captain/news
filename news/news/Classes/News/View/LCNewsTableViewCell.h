//
//  LCNewsTableViewCell.h
//  news
//
//  Created by Liu-Mac on 24/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCNewsItem;

@interface LCNewsTableViewCell : UITableViewCell

/** item */
@property (nonatomic, strong) LCNewsItem *item;

@end
