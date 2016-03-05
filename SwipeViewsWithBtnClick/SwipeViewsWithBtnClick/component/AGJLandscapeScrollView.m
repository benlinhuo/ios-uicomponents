//
//  AGJLandscapeScrollView.m
//  Angejia
//
//  Created by benlinhuo on 16/3/2.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJLandscapeScrollView.h"
#import "AGJGoldBrokerCardView.h"

@interface AGJLandscapeScrollView () <UIScrollViewDelegate>


@property (nonatomic, assign) NSInteger viewCount;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *viewsData;

@property (nonatomic, assign) CGFloat viewWidth; // 单个 view 的宽度
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat viewInterval;
@property (nonatomic, assign) CGFloat viewUnitWidth;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation AGJLandscapeScrollView

/**
 *  初始化
 *
 *  @param views  展示的多个view
 *  @param frame  当前 view 的frame
 *  @param params 必要的参数
 *
 *  @return self
 */

- (instancetype)initWithViews:(NSArray *)views frame:(CGRect)frame params:(NSDictionary *)params
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUIWithViews:views params:params];
    }
    return self;
}

#pragma mark - private method
- (void)initUIWithViews:(NSArray *)views params:(NSDictionary *)params
{
    //parms
    self.viewCount = views.count;
    CGFloat viewHeight = 0;
    if (params[@"viewHeight"]) {
        viewHeight = [params[@"viewHeight"] floatValue];
    }
    self.viewHeight = viewHeight;
    CGFloat viewWidth = 0;
    if (params[@"viewWidth"]) {
        viewWidth = [params[@"viewWidth"] floatValue];
    }
    self.viewWidth = viewWidth;
    CGFloat viewInterval = 10.f;
    if (params[@"viewInterval"]) {
        viewInterval = [params[@"viewInterval"] floatValue];
    }
    self.viewInterval = viewInterval;
    self.viewUnitWidth = viewWidth + viewInterval;
    
    [self addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(self.viewUnitWidth * views.count, viewHeight);
    self.scrollView.pagingEnabled = YES; // 开启分页
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.clipsToBounds = NO;
    self.currentIndex = 0;
    self.viewsData = views;
    
    __weak typeof(self) weakSelf = self;
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        view.frame = CGRectMake(idx * weakSelf.viewUnitWidth + viewInterval, 0, weakSelf.viewWidth, weakSelf.viewHeight);
        [weakSelf.scrollView addSubview:view];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}

#pragma mark - getter / setter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];// 高宽取当前 view 的高宽
        _scrollView.delegate = self;
    }
    return _scrollView;
}

@end
