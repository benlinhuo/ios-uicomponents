//
//  HBLNavigationBarObject.m
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/4.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLNavigationBarObject.h"
#import "UIColor+BFS.h"
#import "UIBarButtonItem+NavItem.h"

@interface HBLNavigationBarObject () {
    BOOL isFirstUpMiddlePosition; // 第一次从下往上滚动到达中间位置
    BOOL isFirstDownMiddlePosition; // 第一次从上往下滚动到达中间位置
}

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) UINavigationItem *navItem;

@property (nonatomic, strong) UIView *overlayView;

@property (nonatomic, strong) UIButton *wechatButton;//右上角微聊入口
@property (nonatomic, strong) UIButton *collectionButton;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, assign) CGFloat showAnimateHeight;

@end


@implementation HBLNavigationBarObject

- (instancetype)initWithNaviationController:(UINavigationController *)navController navigationItem:(UINavigationItem *)navItem scrollView:(UIScrollView *)scrollView changeHeight:(CGFloat)height
{
    self = [super init];
    if (self) {
        _navController = navController;
        _navItem = navItem;
        isFirstDownMiddlePosition = NO;
        isFirstUpMiddlePosition = NO;
        self.showAnimateHeight = height;
        
        [self initLeftItem];
        [self initRightItem];
        
        // 把 navigationbar 弄成透明
        [self.navController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        [self.navController.navigationBar.subviews.firstObject insertSubview:self.overlayView atIndex:0];
        [self scrollViewDidScroll:scrollView];
    }
    return self;
}

- (void)initLeftItem
{
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0, 0, 20, 26);
    [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    UIBarButtonItem *spacer = [UIBarButtonItem getBarSpace:-9.0];
    [self.navItem setLeftBarButtonItems:@[spacer, buttonItem]];
    
}

- (void)initRightItem
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 74, 50)];
    _wechatButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 40, 40)]; // frame 会更改，先不改
    [customView addSubview:_wechatButton];
    _collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    [customView addSubview:_collectionButton];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView: customView];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = -10;
    
    self.navItem.rightBarButtonItems = @[fixedSpace, barButtonItem];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *bgColor = [UIColor colorWithHex:0xF8F8F8 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y + 64;
    CGFloat changeHeight = self.showAnimateHeight - 64;
    CGFloat halfHeight = changeHeight / 2;
    
    if (offsetY < changeHeight) {
        CGFloat alpha = MIN(1, offsetY / changeHeight);
        self.overlayView.backgroundColor = [bgColor colorWithAlphaComponent:alpha];
        
        CGFloat eleAlpha = 0;
        if (offsetY < halfHeight) {
            if (!isFirstUpMiddlePosition) {
                [self UploadChangeStatus];
                isFirstUpMiddlePosition = YES;
                }
            eleAlpha = MIN(1, (halfHeight - offsetY) / halfHeight);
            isFirstDownMiddlePosition = NO;
            
            } else {
                if (!isFirstDownMiddlePosition) {
                    // 第一次到达中间位置，图片替换
                    [self DownloadChangeStatus];
                    isFirstDownMiddlePosition = YES;
                    }
                eleAlpha = MIN(1, (offsetY - halfHeight) / halfHeight);
                isFirstUpMiddlePosition = NO;
                }
        
        _wechatButton.alpha = eleAlpha;
        _collectionButton.alpha = eleAlpha;
        _backButton.alpha = eleAlpha;
        
        } else {
            self.overlayView.backgroundColor = [bgColor colorWithAlphaComponent:1];
            }
    
}

// 从下至上
- (void)UploadChangeStatus
{
    [_backButton setImage:[UIImage imageNamed:@"icon_newhouse_arrow"] forState:UIControlStateNormal];
    [_wechatButton setImage:[UIImage imageNamed:@"icon_newhouse_wechat"] forState:UIControlStateNormal];
    [_wechatButton setImage:[UIImage imageNamed:@"icon_newhouse_wechat"] forState:UIControlStateHighlighted];
    [_collectionButton setImage:[UIImage imageNamed:@"icon_newhouse_collection"] forState:UIControlStateNormal];
    [_collectionButton setImage:[UIImage imageNamed:@"icon_newhouse_pre_collection"] forState:UIControlStateSelected];
    _backButton.frame = CGRectMake(0, 0, 50, 50);
    _wechatButton.frame = CGRectMake(40, 0, 34, 34);
    _collectionButton.frame = CGRectMake(0, 0, 34, 34);
    
    [self.navController.navigationBar setShadowImage:[UIImage new]];
}

// 从上至下
- (void)DownloadChangeStatus
{
    [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [_wechatButton setImage:[UIImage imageNamed:@"danye_wechat"] forState:UIControlStateNormal];
    [_wechatButton setImage:[UIImage imageNamed:@"danye_wechat"] forState:UIControlStateHighlighted];
    [_collectionButton setImage:[UIImage imageNamed:@"icon_gray"] forState:UIControlStateNormal];
    [_collectionButton setImage:[UIImage imageNamed:@"icon_collet_after"] forState:UIControlStateSelected];
    
    _backButton.frame = CGRectMake(0, 0, 20, 26);
    _wechatButton.frame = CGRectMake(40, 0, 40, 40);
    _collectionButton.frame = CGRectMake(0, 0, 30, 40);
    
    [self.navController.navigationBar setShadowImage:nil];
}

#pragma mark - event

- (void)doBack
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doBack)]) {
        [self.delegate doBack];
        }
}

- (void)resetNavigationBar
{
    [self.navController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navController.navigationBar setShadowImage:nil];
    [self.overlayView removeFromSuperview];
    self.overlayView = nil;
}

#pragma mark - getter / setter

- (UIView *)overlayView
{
    if (!_overlayView) {
        _overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.navController.navigationBar.bounds) + 20)];
        _overlayView.backgroundColor = [UIColor clearColor];
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _overlayView.userInteractionEnabled = NO;
        }
    return _overlayView;
}

@end
