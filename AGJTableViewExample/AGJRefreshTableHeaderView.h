//
//  AGJRefreshTableHeaderView.h
//  Angejia
//
//  Created by benlinhuo on 15/12/16.
//  Copyright © 2015年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AGJTableViewState) {
    AGJTableViewStatePulling, // 松开刷新
    AGJTableViewStateNormal, // 下拉刷新
    AGJTableViewStateLoading
};

#define AGJ_PULLING_AREA_HEIGHT 120.f

@class AGJRefreshTableHeaderView;

@protocol AGJRefreshTableHeaderViewDelegate <NSObject>

- (void)refreshTableHeaderDidTriggerRefresh:(AGJRefreshTableHeaderView *)headerView;

@end

@interface AGJRefreshTableHeaderView : UIView

@property (nonatomic, weak) id<AGJRefreshTableHeaderViewDelegate> headDeleagte;

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)startLoadingAnimationWithScrollView:(UIScrollView *)scrollView;
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
