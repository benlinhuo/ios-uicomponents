//
//  AGJTableView.m
//  Angejia
//
//  Created by benlinhuo on 15/12/16.
//  Copyright © 2015年 Plan B Inc. All rights reserved.
//

#import "AGJTableView.h"
#import "UIView+BFSToastInfo.h"
#import "AGJRefreshTableHeaderView.h"
#import "MessageInterceptor.h"

@interface AGJTableView () <AGJRefreshTableHeaderViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) AGJRefreshTableHeaderView *headerView;
@property (nonatomic, strong) MessageInterceptor *delegateInterceptor;

@end

@implementation AGJTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerView];
        
        _delegateInterceptor = [[MessageInterceptor alloc] init];
        _delegateInterceptor.middleMan = self;
        _delegateInterceptor.receiver = self.delegate;
        super.delegate = (id)_delegateInterceptor;
        
        _pullTableIsRefreshing = NO;
    }
    return self;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if (_delegateInterceptor) {
        super.delegate = nil;
        _delegateInterceptor.receiver = delegate;
        super.delegate = (id)_delegateInterceptor;
    } else {
        super.delegate = delegate;
    }
}

- (void)setPullTableIsRefreshing:(BOOL)isRefreshing
{
    // 由非加载中->加载中
    if (isRefreshing) {
        [_headerView startLoadingAnimationWithScrollView:self];
        _pullTableIsRefreshing = YES;
        
    } else if (!isRefreshing) {
        //由 加载中 -> 非加载中
        [_headerView refreshScrollViewDataSourceDidFinishedLoading:self];
        _pullTableIsRefreshing = NO;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"22222");
}

#pragma mark - AGJRefreshTableHeaderViewDelegate
- (void)refreshTableHeaderDidTriggerRefresh:(AGJRefreshTableHeaderView *)headerView
{
    if (_pullDelegate && [_pullDelegate respondsToSelector:@selector(AGJTableViewDidTriggerRefresh:)]) {
        [_pullDelegate AGJTableViewDidTriggerRefresh:self];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_headerView refreshScrollViewDidScroll:scrollView];
    if (_delegateInterceptor.receiver && [_delegateInterceptor.receiver respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_delegateInterceptor.receiver scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_headerView refreshScrollViewDidEndDragging:scrollView];
    if (_delegateInterceptor.receiver && [_delegateInterceptor.receiver respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_delegateInterceptor.receiver scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_delegateInterceptor.receiver && [_delegateInterceptor.receiver respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegateInterceptor.receiver scrollViewWillBeginDragging:scrollView];
    }
}

#pragma mark - public method
- (void)showMessageType:(BFSErrorMessageType)type target:(id)target action:(SEL)action
{
    [self showMessageType:type target:target action:action withMessage:nil];
}

- (void)showMessageType:(BFSErrorMessageType)type target:(id)target action:(SEL)action withMessage:(NSString *)sMsg
{
    NSString * msg = nil;
    if (sMsg != nil) {
        msg = sMsg;
    } else {
        msg = [self.errorView messageForType:type];
    }
    if ([self visibleCells].count>0) {
        if (self.superview) {
            [self.superview showInfo:msg autoHidden:YES];
        } else {
            [self showInfo:msg autoHidden:YES];
        }
    } else {
        [self.errorView showInView:self type:type target:target action:action withMsg:msg];
    }
}

- (void)showMessageTitle:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action
{
    if ([self visibleCells].count>0) {
        if (self.superview) {
            [self.superview showInfo:title autoHidden:YES];
        } else {
            [self showInfo:title autoHidden:YES];
        }
    } else {
        [self.errorView showInView:self title:title image:image subTitle:subTitle target:target action:action];
    }
}

- (void)showMessageTitle:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action topMargin:(CGFloat)topMargin
{
    [self.errorView showInView:self title:title image:image subTitle:subTitle target:target action:action topMargin:topMargin];
}

- (void)showMessageTitle:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action highLightButton:(BOOL)showHighLightButton highLightButtonText:(NSString *)text
{
    if ([self visibleCells].count>0) {
        if (self.superview) {
            [self.superview showInfo:title autoHidden:YES];
        } else {
            [self showInfo:title autoHidden:YES];
        }
    } else {
        [self.errorView showInView:self title:title image:image subTitle:subTitle target:target action:action highLightButton:showHighLightButton highLightButtonText:text];
    }
}

- (void)cleanMessage
{
    [self.errorView dismissAnimation:NO];
}


#pragma mark - getter / setter
- (AGJRefreshTableHeaderView *)headerView
{
    if (!_headerView) {
        CGSize size = self.bounds.size;
        _headerView = [[AGJRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -AGJ_PULLING_AREA_HEIGHT, size.width, AGJ_PULLING_AREA_HEIGHT)];
        _headerView.headDeleagte = self;
        _headerView.layer.borderColor = [UIColor redColor].CGColor;
        _headerView.layer.borderWidth = 1.f;
    }
    return _headerView;
}

@end
