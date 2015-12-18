//
//  AGJRefreshTableHeaderView.m
//  Angejia
//
//  Created by benlinhuo on 15/12/16.
//  Copyright © 2015年 Plan B Inc. All rights reserved.
//

#import "AGJRefreshTableHeaderView.h"
#import "UIColor+AngejiaStyle.h"
#import "UIFont+AngejiaStyle.h"

#define AGJ_LOADING_AREA_HEIGHT 70.f
#define AGJ_FLIP_ANIMATION_DURATION 0.18f

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface AGJRefreshTableHeaderView ()

@property (nonatomic, strong) UIImageView *pullingImgView;
@property (nonatomic, strong) UIView *pullingTipView;
@property (nonatomic, strong) CALayer *arrowImgView;
@property (nonatomic, strong) UILabel *pullingText;
@property (nonatomic, strong) UIImageView *loadingImgView;
@property (nonatomic, strong) UILabel *loadingText;

@property (nonatomic, assign) AGJTableViewState state;

@end

@implementation AGJRefreshTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor angejiaBackgroundColor];
        [self addSubview:self.pullingImgView];
        [self addSubview:self.pullingTipView];
        [self addSubview:self.loadingImgView];
        [self addSubview:self.loadingText];
        [self setState:AGJTableViewStateNormal];
    }
    return self;
}

#pragma mark - private method
- (void)setState:(AGJTableViewState)aState
{
    [self setControlIsShowByState:aState];
    switch (aState) {
        case AGJTableViewStatePulling:
        {
            _pullingText.text = @"松开刷新";
            [CATransaction begin];
            [CATransaction setAnimationDuration:AGJ_FLIP_ANIMATION_DURATION];
            _arrowImgView.transform = CATransform3DMakeRotation((M_PI / 180.f) * 180.f, 0.f, 0.f, 1.f);
            [CATransaction commit];
        }
            break;
        case AGJTableViewStateNormal:
        {
            if (_state == AGJTableViewStatePulling) {
                // 如果之前一个状态是 AGJTableViewStatePulling
                [CATransaction begin];
                [CATransaction setAnimationDuration:AGJ_FLIP_ANIMATION_DURATION];
                _arrowImgView.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            _pullingText.text = @"下拉刷新";
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImgView.transform = CATransform3DIdentity;
            [CATransaction commit];
        }
            break;
        case AGJTableViewStateLoading:
        {
            
        }
            break;
            
        default:
            break;
    }
    _state = aState;
}

- (void)setControlIsShowByState:(AGJTableViewState)state
{
    CGRect rect = self.frame;
    if (state == AGJTableViewStateNormal || state == AGJTableViewStatePulling) {
        //下拉刷新 ＋ 释放更新
        _pullingImgView.hidden = NO;
        _pullingTipView.hidden = NO;
        _arrowImgView.hidden = NO;
        _pullingText.hidden = NO;
        
        _loadingImgView.hidden = YES;
        [_loadingImgView stopAnimating];
        _loadingText.hidden = YES;
        
        rect.size.height = AGJ_PULLING_AREA_HEIGHT;
        rect.origin.y = -AGJ_PULLING_AREA_HEIGHT;
        
    } else {
        // 加载中
        _pullingImgView.hidden = YES;
        _pullingTipView.hidden = YES;
        _arrowImgView.hidden = YES;
        _pullingText.hidden = YES;
        
        _loadingImgView.hidden = NO;
        [_loadingImgView startAnimating];
        _loadingText.hidden = NO;
        
        rect.size.height = AGJ_LOADING_AREA_HEIGHT;
        rect.origin.y = -AGJ_LOADING_AREA_HEIGHT;
        
    }
    self.frame = rect;
    
}

- (void)setScrollView:(UIScrollView *)scrollView top:(CGFloat)offset
{
    UIEdgeInsets currInsets = scrollView.contentInset;
    currInsets.top = offset;
    scrollView.contentInset = currInsets;
}

#pragma mark - scrollView method
- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_state == AGJTableViewStateLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y * (-1), 0);
        offset = MIN(offset, AGJ_LOADING_AREA_HEIGHT);
        [self setScrollView:scrollView top:offset];
        
    } else if (scrollView.isDragging) {
        CGFloat contentY = scrollView.contentOffset.y;
        if (_state == AGJTableViewStatePulling && contentY > -AGJ_PULLING_AREA_HEIGHT && contentY < 0.f) {
            [self setState:AGJTableViewStateNormal];
            
        } else if (_state == AGJTableViewStateNormal && contentY < -AGJ_PULLING_AREA_HEIGHT) {
            [self setState:AGJTableViewStatePulling];
        }
        
        if (scrollView.contentInset.top != 0) {
            [self setScrollView:scrollView top:0];
        }
    }
}

- (void)startLoadingAnimationWithScrollView:(UIScrollView *)scrollView
{
    [self setState:AGJTableViewStateLoading];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [self setScrollView:scrollView top:AGJ_LOADING_AREA_HEIGHT];
    [UIView commitAnimations];
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= -AGJ_PULLING_AREA_HEIGHT) {
        if (_headDeleagte && [_headDeleagte respondsToSelector:@selector(refreshTableHeaderDidTriggerRefresh:)]) {
            [_headDeleagte refreshTableHeaderDidTriggerRefresh:self];
        }
        [self startLoadingAnimationWithScrollView:scrollView];
    }
}

- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView
{
    CGFloat timeAfter = .3f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeAfter];
    [self setScrollView:scrollView top:0];
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeAfter * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setState:AGJTableViewStateNormal];
    });
}

#pragma mark - getter / setter
- (UIImageView *)pullingImgView
{
    if (!_pullingImgView) {
        CGFloat w = 240;
        CGFloat x = (SCREEN_WIDTH - w) / 2;
        _pullingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, w, 47)];
        _pullingImgView.image = [UIImage imageNamed:@"icon_biaoyu"];
        _pullingImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _pullingImgView;
}

- (UIView *)pullingTipView
{
    if (!_pullingTipView) {
        CGFloat w  = 80;
        CGFloat x = (SCREEN_WIDTH - w) / 2;
        CGFloat y = (AGJ_PULLING_AREA_HEIGHT - 20 - 20);
        _pullingTipView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, 20)];
        _pullingTipView.backgroundColor = [UIColor clearColor];
        [_pullingTipView.layer addSublayer:self.arrowImgView];
        [_pullingTipView addSubview:self.pullingText];
    }
    return _pullingTipView;
}

- (CALayer *)arrowImgView
{
    if (!_arrowImgView) {
        _arrowImgView = [[CALayer alloc] init];
        _arrowImgView.frame = CGRectMake(0, 0, 10, 17);
        _arrowImgView.contentsGravity = kCAGravityResizeAspect;
        _arrowImgView.contents = (id)[UIImage imageNamed:@"icon_shuaxinjt"].CGImage;
    }
    return _arrowImgView;
}

- (UILabel *)pullingText
{
    if (!_pullingText) {
        _pullingText = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 17)];
        _pullingText.text = @"下拉刷新";
        _pullingText.textColor = [UIColor angejiaMediumGrayColor];
        _pullingText.font = [UIFont angejiaH5Font];
    }
    return _pullingText;
}

- (UIImageView *)loadingImgView
{
    if (!_loadingImgView) {
        CGFloat w = 55;
        CGFloat x = (SCREEN_WIDTH - w) / 2;
        _loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 10, w, 23)];
        UIImage *loadingImage1 = [UIImage imageNamed:@"loading1"];
        UIImage *loadingImage2 = [UIImage imageNamed:@"loading2"];
        UIImage *loadingImage3 = [UIImage imageNamed:@"loading3"];
        UIImage *loadingImage4 = [UIImage imageNamed:@"loading4"];
        UIImage *loadingImage5 = [UIImage imageNamed:@"loading5"];
        UIImage *loadingImage6 = [UIImage imageNamed:@"loading6"];
        UIImage *loadingImage7 = [UIImage imageNamed:@"loading7"];
        UIImage *loadingImage8 = [UIImage imageNamed:@"loading8"];
        UIImage *loadingImage9 = [UIImage imageNamed:@"loading9"];
        UIImage *loadingImage10 = [UIImage imageNamed:@"loading10"];
        UIImage *loadingImage11 = [UIImage imageNamed:@"loading11"];
        
        _loadingImgView.animationImages = @[loadingImage1,loadingImage2, loadingImage3, loadingImage4, loadingImage5, loadingImage6, loadingImage7, loadingImage8, loadingImage9, loadingImage10, loadingImage11];
        _loadingImgView.animationDuration = 1;
        _loadingImgView.animationRepeatCount = 0;
    }
    return _loadingImgView;
}

- (UILabel *)loadingText
{
    if (!_loadingText) {
        CGFloat w = 65;
        CGFloat x = (SCREEN_WIDTH - w) / 2;
        _loadingText = [[UILabel alloc] initWithFrame:CGRectMake(x, 40, w, 20)];
        _loadingText.text = @"努力加载中";
        _loadingText.textAlignment = NSTextAlignmentCenter;
        _loadingText.textColor = [UIColor angejiaMediumGrayColor];
        _loadingText.font = [UIFont angejiaH5Font];
    }
    return _loadingText;
}

@end
