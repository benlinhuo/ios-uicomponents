//
//  HBLNavigationBarView.m
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/4.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLNavigationBarView.h"
#import "UIView+BFS.h"
#import "UIColor+BFS.h"




@interface HBLNavigationBarView () {
    UIScrollView *_scrollView;
    CGFloat _scrollHeight;
    BOOL _isFirstUpMiddlePosition;
    BOOL _isFirstDownMiddlePosition;
    CGFloat controlTop;
}

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *wechatButton;
@property (nonatomic, strong) UIButton *collectionButton;
@property (nonatomic, strong) UIView *lineView;

@end


@implementation HBLNavigationBarView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView scrollHeight:(CGFloat)height
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)]; // 模拟 navigationBar 的高度
    if (self) {
        _scrollView = scrollView;
        _scrollHeight = height;
        
        [self initUI];
        
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.backButton];
    [self addSubview:self.wechatButton];
    [self addSubview:self.collectionButton];
    [self addSubview:self.lineView];
    [self UploadChangeStatus];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *bgColor = [UIColor colorWithHex:0xF8F8F8 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y + 20;
    CGFloat changeHeight = _scrollHeight - 64;
    CGFloat halfHeight = changeHeight / 2;
    
    if (offsetY < changeHeight) {
        CGFloat alpha = MIN(1, offsetY / changeHeight);
        self.backgroundColor = [bgColor colorWithAlphaComponent:alpha];
        
        CGFloat eleAlpha = 0;
        if (offsetY < halfHeight) {
            if (!_isFirstUpMiddlePosition) {
                [self UploadChangeStatus];
                _isFirstUpMiddlePosition = YES;
            }
            eleAlpha = MIN(1, (halfHeight - offsetY) / halfHeight);
            _isFirstDownMiddlePosition = NO;
            
        } else {
            if (!_isFirstDownMiddlePosition) {
                // 第一次到达中间位置，图片替换
                [self DownloadChangeStatus];
                _isFirstDownMiddlePosition = YES;
            }
            eleAlpha = MIN(1, (offsetY - halfHeight) / halfHeight);
            _isFirstUpMiddlePosition = NO;
        }
        
        _wechatButton.alpha = eleAlpha;
        _collectionButton.alpha = eleAlpha;
        _backButton.alpha = eleAlpha;
        
    } else {
        self.backgroundColor = [bgColor colorWithAlphaComponent:1];
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
    self.lineView.hidden = YES;
    
    [self setPositionTop:30.f];
}

// 从上至下
- (void)DownloadChangeStatus
{
    [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [_wechatButton setImage:[UIImage imageNamed:@"danye_wechat"] forState:UIControlStateNormal];
    [_wechatButton setImage:[UIImage imageNamed:@"danye_wechat"] forState:UIControlStateHighlighted];
    [_collectionButton setImage:[UIImage imageNamed:@"icon_gray"] forState:UIControlStateNormal];
    [_collectionButton setImage:[UIImage imageNamed:@"icon_collet_after"] forState:UIControlStateSelected];
    self.lineView.hidden = NO;
    
    [self setPositionTop:25.f];
}

- (void)setPositionTop:(CGFloat)top
{
    controlTop = top;
    _backButton.top = controlTop;
    _wechatButton.top = controlTop;
    _collectionButton.top = controlTop;
    
}

#pragma mark - event
- (void)doBack
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doBack)]) {
        [self.delegate doBack];
    }
}

#pragma mark - getter / setter

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(10, controlTop, 34, 34);
        [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)wechatButton
{
    if (!_wechatButton) {
        _wechatButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, controlTop, 34, 34)]; // frame 会更改，先不改
    }
    return _wechatButton;
}

- (UIButton *)collectionButton
{
    if (!_collectionButton) {
        _collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, controlTop, 34, 34)];
    }
    return _collectionButton;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, .5)];
        _lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9 alpha:1];
    }
    return _lineView;
}

@end
