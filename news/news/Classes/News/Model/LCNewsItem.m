//
//  rowItem.m
//  05-复杂JSON的解析
//
//  Created by Liu-Mac on 23/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "LCNewsItem.h"

@implementation LCNewsItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    
    LCNewsItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    
    return item;    
}

@end
