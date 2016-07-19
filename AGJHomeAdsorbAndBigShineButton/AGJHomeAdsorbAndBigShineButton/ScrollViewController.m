//
//  ScrollViewController.m
//  AGJHomeAdsorbAndBigShineButton
//
//  Created by benlinhuo on 16/7/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "ScrollViewController.h"
#import "AGJHomeFunctionContainerView.h"
#import "AGJEnvironmentConfigure.h"
#import "UIView+BFS.h"
#import "AGJUI.h"
#import "AGJHomeFindHouseAdapter.h"
#import "AGJHomeVisitAdapter.h"
#import "AGJHomeTradeAdapter.h"


@interface ScrollViewController ()<UIScrollViewDelegate, AGJHomeFindHouseAdapterDelegate, AGJHomeVisitAdapterDelegate, AGJHomeTradeAdapterDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) AGJHomeFunctionContainerView *topFunctionView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *findHouseTableView;//找房顾问tableview
@property (nonatomic, strong) UITableView *visitTableView;//带看tableview
@property (nonatomic, strong) UITableView *tradeTableView;//交易tableview
@property (nonatomic, assign) BOOL isScrolling;//正在做segmentBar悬浮的动画
@property (nonatomic, assign) BOOL isScrolledTop;//segmentBar已悬浮到顶部

@property (nonatomic, strong) AGJHomeFindHouseAdapter *findHouseAdapter;//找房顾问适配
@property (nonatomic, strong) AGJHomeVisitAdapter *visitAdapter;//带看适配
@property (nonatomic, strong) AGJHomeTradeAdapter *tradeAdapter;//交易适配

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}


- (void)initUI
{
    AGJHomeFunctionContainerView *topFunctionView = self.topFunctionView;
    [self.view addSubview:topFunctionView];
    UIScrollView *scrollView = self.scrollView;
    [self.view addSubview:scrollView];
}

- (CGFloat)scrollViewHeight
{
    return self.view.height - [AGJHomeFunctionContainerView viewHeight] + 10 + 44;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self.topFunctionView.segmentView setSelectedSegmentIndex:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.topFunctionView.segmentView setSlidViewLeft:scrollView.contentOffset.x / 3];
}


- (void)findHouseTableViewDidScrollView:(UIScrollView *)scrollView
{
    [self tableViewDidScroll:scrollView];
}

- (void)visitTableViewDidScrollView:(UIScrollView *)scrollView
{
    [self tableViewDidScroll:scrollView];
}

- (void)tradeTableViewdidScroll:(UIScrollView *)scrollView
{
    [self tableViewDidScroll:scrollView];
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isScrolling) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    __weak typeof(self) weakSelf = self;
    
    if (offsetY > 0 && !self.isScrolledTop) {
        self.isScrolling = YES;
        [UIView animateWithDuration:0.5
                         animations:^{
                             weakSelf.topFunctionView.frame = CGRectMake(weakSelf.topFunctionView.frame.origin.x, weakSelf.topFunctionView.frame.origin.y - toolViewHeight - graySpaceHeight, weakSelf.topFunctionView.frame.size.width, weakSelf.topFunctionView.frame.size.height);
                             weakSelf.scrollView.frame = CGRectMake(weakSelf.scrollView.frame.origin.x, weakSelf.scrollView.frame.origin.y - toolViewHeight - graySpaceHeight, weakSelf.scrollView.frame.size.width, weakSelf.scrollView.frame.size.height);
                             
                         } completion:^(BOOL finished){
                             weakSelf.isScrolling = NO;
                             weakSelf.isScrolledTop = YES;
                             
                         }];
    }
    
    if (offsetY < 0 && weakSelf.isScrolledTop) {
        weakSelf.isScrolling = YES;
        [UIView animateWithDuration:0.5
                         animations:^{
                             weakSelf.topFunctionView.frame = CGRectMake(weakSelf.topFunctionView.frame.origin.x, weakSelf.topFunctionView.frame.origin.y + toolViewHeight + graySpaceHeight, weakSelf.topFunctionView.frame.size.width, weakSelf.topFunctionView.frame.size.height);
                             weakSelf.scrollView.frame = CGRectMake(weakSelf.scrollView.frame.origin.x, weakSelf.scrollView.frame.origin.y + toolViewHeight + graySpaceHeight, weakSelf.scrollView.frame.size.width, weakSelf.scrollView.frame.size.height);
                             
                         } completion:^(BOOL finished){
                             weakSelf.isScrolling = NO;
                             weakSelf.isScrolledTop = NO;
                             
                         }];
    }
}


#pragma mark - getter / setter

- (AGJHomeFunctionContainerView *)topFunctionView
{
    if (!_topFunctionView) {
        _topFunctionView = [[AGJHomeFunctionContainerView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, [AGJHomeFunctionContainerView viewHeight])];
        __weak typeof(self) weakSelf = self;
        
        _topFunctionView.segmentView.indexChangeBlock = ^(NSInteger index, BOOL isRedDot){
            [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, 0, weakSelf.view.width, 1) animated:YES];
        };
    }
    return _topFunctionView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topFunctionView.bottom, SCREEN_WIDTH, [self scrollViewHeight])];
        _scrollView.layer.borderColor = [UIColor grayColor].CGColor;
        _scrollView.layer.borderWidth = 1.f;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.view.width * 3, 1);
        _scrollView.delegate = self;
        [_scrollView scrollRectToVisible:CGRectMake(0, 0, self.view.width, 1) animated:NO];
        
        UITableView *findHouseTableView = self.findHouseTableView;
        [_scrollView addSubview:findHouseTableView];
        
        UITableView *visitTableView = self.visitTableView;
        [_scrollView addSubview:visitTableView];
        
        UITableView *tradeTableView = self.tradeTableView;
        [_scrollView addSubview:tradeTableView];
    }
    return _scrollView;
}

- (UITableView *)findHouseTableView
{
    if (!_findHouseTableView) {
        _findHouseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, self.scrollView.height)];
//        _findHouseTableView.backgroundColor = [UIColor blueColor];
        _findHouseTableView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
        _findHouseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _findHouseTableView.delegate = self.findHouseAdapter;
        _findHouseTableView.dataSource = self.findHouseAdapter;
    }
    return _findHouseTableView;
}

- (UITableView *)visitTableView
{
    if (!_visitTableView) {
        _visitTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 10, SCREEN_WIDTH, self.scrollView.height)];
        _visitTableView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
//        _visitTableView.backgroundColor = [UIColor redColor];
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        _visitTableView.tableFooterView = footView;
        _visitTableView.delegate = self.visitAdapter;
        _visitTableView.dataSource = self.visitAdapter;
        
    }
    return _visitTableView;
}

- (UITableView *)tradeTableView
{
    if (!_tradeTableView) {
        _tradeTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 10, SCREEN_WIDTH, self.scrollView.height)];
        _tradeTableView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
//        _tradeTableView.backgroundColor = [UIColor greenColor];
        _tradeTableView.tableFooterView = [UIView new];
        _tradeTableView.delegate = self.tradeAdapter;
        _tradeTableView.dataSource = self.tradeAdapter;
    }
    return _tradeTableView;;
}

- (AGJHomeFindHouseAdapter *)findHouseAdapter
{
    if (!_findHouseAdapter) {
        _findHouseAdapter = [[AGJHomeFindHouseAdapter alloc] init];
        _findHouseAdapter.delegate = self;
    }
    return _findHouseAdapter;
}

- (AGJHomeVisitAdapter *)visitAdapter
{
    if (!_visitAdapter) {
        _visitAdapter = [[AGJHomeVisitAdapter alloc] init];
        _visitAdapter.delegate = self;
    }
    return _visitAdapter;
}

- (AGJHomeTradeAdapter *)tradeAdapter
{
    if (!_tradeAdapter) {
        _tradeAdapter = [[AGJHomeTradeAdapter alloc] init];
        _tradeAdapter.delegate = self;
    }
    return _tradeAdapter;
}


@end
