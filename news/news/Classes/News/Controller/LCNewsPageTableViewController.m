//
//  LCNewsPageTableViewController.m
//  news
//
//  Created by Liu-Mac on 24/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "LCNewsPageTableViewController.h"
#import "LCNewsItem.h"
#import "LCNewsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>

#import "LCWebViewController.h"

@interface LCNewsPageTableViewController ()

/** items */
@property (nonatomic, strong) NSArray *items;

@end

@implementation LCNewsPageTableViewController

- (NSArray *)items {
    
    if (!_items) {
//        _items = [LCNewsItem getItemsWithType:self.type];
    }
    
    return _items;
    
}

- (void)getItemsWithType:(NSString *)type {
    
    // 01 url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://v.juhe.cn/toutiao/index?type=%@&key=cdd2f54db332f7a361815ee44b77d17b", type]];
    // 02 发送网络请求
    NSURLSession *session = [NSURLSession sharedSession];
    // 内部会创建一个子队列来执行completionHandler
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *result = dict[@"result"];
        NSArray *resultData = result[@"data"];
        self.items = [LCNewsItem mj_objectArrayWithKeyValuesArray:resultData];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    [dataTask resume];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getItemsWithType:self.type];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LCNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const ID = @"cellID";
    
    LCNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.item = self.items[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0;
    
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCWebViewController *webVC = [[LCWebViewController alloc] init];
    UIWebView *webV = (UIWebView *)webVC.view;
    LCNewsItem *item = self.items[indexPath.row];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:item.url]];
    NSLog(@"%@", item.url);
    [webV loadRequest: requst];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}

@end
