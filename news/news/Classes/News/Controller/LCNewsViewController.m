//
//  LCNewsViewController.m
//  news
//
//  Created by Liu-Mac on 24/11/2016.
//  Copyright © 2016 Liu-Mac. All rights reserved.
//

#import "LCNewsViewController.h"

#import "LCHomeLabel.h"

#import "LCNewsPageTableViewController.h"

static NSInteger numberOfTitle;

@interface LCNewsViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation LCNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentScrollView.backgroundColor = [UIColor redColor];
    self.contentScrollView.delegate = self;
    
    [self addAllVCs];
    [self.view layoutIfNeeded];
    [self setUpTitle];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self scrollViewDidEndDecelerating:self.contentScrollView];
    [self scrollViewDidScroll:self.contentScrollView];
}

- (void)addAllVCs {
    NSArray *titles = @[@"头条", @"社会", @"国内", @"国际", @"娱乐", @"体育", @"军事", @"科技", @"财经", @"时尚"];
    numberOfTitle = titles.count;
    NSArray *types = @[@"top", @"shehui", @"guonei", @"guoji", @"yule", @"tiyu", @"junshi", @"keji", @"caijing", @"shishang"];
    
    NSInteger index = 0;
    for (NSString *title in titles) {
        LCNewsPageTableViewController *vc = [[LCNewsPageTableViewController alloc] init];
        vc.title = title;
        vc.type = types[index++];
        [self addChildViewController:vc];
    }
}

- (void)setUpTitle {
    
    CGFloat w = 100;
    CGFloat y = 0;
    CGFloat h = self.titleScrollView.bounds.size.height;
    
    for (NSInteger i = 0; i < numberOfTitle; ++i) {
        CGFloat x = i * w;
        LCHomeLabel *label = [[LCHomeLabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        label.text = self.childViewControllers[i].title;
        label.tag = i;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)]];
        [self.titleScrollView addSubview:label];
    }
    
    self.titleScrollView.contentSize = CGSizeMake(numberOfTitle * w, 0);
    self.contentScrollView.contentSize = CGSizeMake(numberOfTitle * ScreenW, 0);
    
}

- (void)labelTap:(UITapGestureRecognizer *)tap {
    
    [self.contentScrollView setContentOffset:CGPointMake(tap.view.tag * ScreenW, 0) animated:YES];
    
}

#pragma mark - <UIScrollViewDelegate>

// 手指松开scrollView后, scrollView停止减速完毕就会调用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / ScreenW;
    
    // 通过index取出需要居中的label
    LCHomeLabel *centerLabel = self.titleScrollView.subviews[index];
    // 计算居中后的titleScrollView的偏移量
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    // 计算表达式
    titleOffset.x = centerLabel.center.x - ScreenW * 0.5;
    if (titleOffset.x < 0) {
        // 偏移量小于0, 就归0
        titleOffset.x = 0;
    }
    if (titleOffset.x > self.titleScrollView.contentSize.width - ScreenW) {
        // 偏移量大于最大偏移量, 就取最大偏移量
        titleOffset.x = self.titleScrollView.contentSize.width - ScreenW;
    }

    for (LCHomeLabel *label in self.titleScrollView.subviews) {
        if (label != centerLabel) {
            label.scale = 0.0;
        }
    }
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    UIViewController *willAppearVC = self.childViewControllers[index];
    if ([willAppearVC isViewLoaded]) {
        return; // 当vc的view已经加载, 直接返回, 因为view已经在contentScrollView中了
    }
    // 添加控制器的view到contentScrollView中
    willAppearVC.view.frame = CGRectMake(index * ScreenW, 0, ScreenW, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:willAppearVC.view];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scale = self.contentScrollView.contentOffset.x / ScreenW;

    if ((scale < 0) || (scale > numberOfTitle-1)) return;
    NSInteger index = self.contentScrollView.contentOffset.x / ScreenW;
    CGFloat rightScale = scale - index; // 右边页面占窗口的比例
    CGFloat leftScale = 1 - rightScale; // 所以1 - scale表示左边页面占窗口的比例
    
    LCHomeLabel *leftLabel = self.titleScrollView.subviews[index];
    LCHomeLabel *rightLabel = (index + 1 >= numberOfTitle) ? nil : self.titleScrollView.subviews[index+1];
    
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;    
    
}

@end
