//
//  rowItem.h
//  05-复杂JSON的解析
//
//  Created by Liu-Mac on 23/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCNewsItem : NSObject

/** author_name */
@property (nonatomic, strong) NSString *author_name;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *realtype;

@property (nonatomic, strong) NSString *thumbnail_pic_s;

@property (nonatomic, strong) NSString *thumbnail_pic_s02;

@property (nonatomic, strong) NSString *thumbnail_pic_s03;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *uniquekey;

@property (nonatomic, strong) NSString *url;


+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
