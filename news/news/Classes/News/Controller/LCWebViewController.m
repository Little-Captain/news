//
//  LCWebViewController.m
//  05-复杂JSON的解析
//
//  Created by Liu-Mac on 23/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "LCWebViewController.h"
#import <WebKit/WebKit.h>

#import <SVProgressHUD.h>
#import <MJRefresh.h>

@interface LCWebViewController () <WKNavigationDelegate>

@end

@implementation LCWebViewController

- (void)loadView {
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webView.navigationDelegate = self;
    self.view = webView;
    __weak typeof(self) weakSelf = self;
    webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        UIWebView *webView = (UIWebView *)weakSelf.view;
        [webView reload];
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    UIWebView *webView = (UIWebView *)self.view;
    [webView.scrollView.mj_header beginRefreshing];
    
}

- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UIWebViewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView.scrollView.mj_header endRefreshing];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
    [webView.scrollView.mj_header endRefreshing];
}

@end
