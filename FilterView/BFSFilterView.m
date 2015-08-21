//
//  BFSFilterView.m
//  BIFService
//
//  Created by wysasun on 14/12/8.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "BFSFilterView.h"
#import "BFSFilterItem.h"
#import "BFSFilterTableView.h"
#import "BFSFilterButton.h"

#import "UIView+BFS.h"
#import "UIColor+BFS.h"
#import "BFSMacros.h"
#import "BFSMoreFilterViewController.h"

#import "BFSPriceBlockView.h"

static const NSInteger BFSFilterView_DefaultMaxAllowShown = 3;
static const CGFloat BFSFilterView_DefaultHeight = 45.f;
static const CGFloat BFSFilterView_DefaultMoreWidth = 70;
static const CGFloat BFSFilterView_DefaultMaxTabelViewHeight = 315;
static const CGFloat BFSFilterView_DefaultSepartorMargin = 8;

@interface BFSFilterView ()

@property (nonatomic) NSInteger shownItemCount;
@property (nonatomic) BOOL showMore;
@property (nonatomic, strong) NSMutableArray *innerItems;//组装过的内部的items
@property (nonatomic, strong) UIControl *shadowView;//filterview底端到window底部的灰色遮盖层
@property (nonatomic, strong) UIControl *shadowView_top_assistant;//filterview顶端到window顶部的遮盖层，上面的任何点击会隐藏filter
@property (nonatomic, strong) BFSFilterTableView *filterTableView;
@property (nonatomic, strong) BFSPriceBlockView *priceBlockView;
@property (nonatomic) CGFloat filterTableViewHeight;
@property (nonatomic) BOOL filterTableShown;

@property (nonatomic) UIView *redView;

@end

@implementation BFSFilterView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addViews];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, BFS_ScreenWidth, BFSFilterView_DefaultHeight)];
}

- (void)addViews
{
    _separatorMarginForTopBottom = BFSFilterView_DefaultSepartorMargin;
    _maxAllowShown = BFSFilterView_DefaultMaxAllowShown;
    _maxTabelViewHeight = BFSFilterView_DefaultMaxTabelViewHeight;
    _buttons = [NSMutableArray array];
    _forest = [NSMutableArray array];
    _filterTableViewCellStyle = nil;
    
    //TEST CODE
    //
    //    _filterTableViewCellStyle = [NSMutableDictionary dictionary];
    //    [_filterTableViewCellStyle setValue:[NSNumber numberWithInt:0x00ff00] forKey:@"CellLabelSelectTextColor"];
}

- (void)addObserverWithKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)UpdateMaxAllowShownCount:(int)nMaxCount
{
    _maxAllowShown = nMaxCount;
}
- (void)UpdateMaxAllowShownCountToDefault
{
    _maxAllowShown = BFSFilterView_DefaultMaxAllowShown;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

- (instancetype)initWithForest:(NSMutableArray *)forest
{
    self = [self initWithFrame:CGRectMake(0, 0, BFS_ScreenWidth, BFSFilterView_DefaultHeight)];
    if (self) {
        _forest = forest;
        [self updateUIWithForest];
    }
    return self;
}

- (void)setForest:(NSMutableArray *)forest
{
    if (_forest != forest) {
        _forest = forest;
        [self updateUIWithForest];
    }
}

- (void)updateUIWithForest
{
    [self removeAllSubviews];
    [self removeConstraints:[self constraints]];
    [self.buttons removeAllObjects];
    _showMore = NO;
    if (!_forest) {
        return;
    }
    
    //其实我们可以通过直接赋值给forest变量来设置多个 filterItem
    //如果我们想要最后有一个选项是“更多”，则只需要设置的 forest.count > maxAllowShown 即可。
    //“更多”的子选项，是需要自己设置的
    NSMutableArray *items = _forest;
    _innerItems = [NSMutableArray array];
    [_innerItems addObjectsFromArray:[items subarrayWithRange:NSMakeRange(0, _maxAllowShown)]];
    BFSFilterItem *more = nil;
    if (items.count > _maxAllowShown) {
        _showMore = YES;
        more = [[BFSFilterItem alloc] init];
        more.name = @"更多";
        NSRange moreRange = NSMakeRange(_maxAllowShown, items.count - _maxAllowShown);
        more.childrenItems = [[items subarrayWithRange:moreRange] mutableCopy];
        [_innerItems addObject:more];
        _shownItemCount = _innerItems.count - 1;
    } else {
        _shownItemCount = _innerItems.count;
        _showMore = NO;
    }
    //add buttons
    //每个button的宽度设置一样的，如果有“更多”按钮的话，则“更多”按钮一定是指定的70的宽度，其他按钮平均宽度
    CGFloat buttonsWidth = _showMore? self.width - BFSFilterView_DefaultMoreWidth: self.width;
    CGFloat buttonWidth = buttonsWidth/_shownItemCount;
    __block CGFloat buttonStartX = 0;
    __weak typeof(self) weakSelf = self;
    // enumerateObjectsUsingBlock 很像js中的each方法，很好，不错的设计。oc中的block，也相当于js中的回调callback
    [_innerItems enumerateObjectsUsingBlock:^(BFSFilterItem *item, NSUInteger idx, BOOL *stop) {
        UIButton *button = nil;
        if (idx < _shownItemCount) {
            //普通按钮
            // BFSFilterButton 只是一个普通的button的布局，
            BFSFilterButton *filterButton = [[BFSFilterButton alloc] initWithFrame:CGRectMake(buttonStartX, 0, buttonWidth, self.height)];
            [filterButton showSeparator:idx < items.count - 1];//只有最后一个button的右侧是不需要分割线的
            [filterButton setSeparatorMarginForTop:_separatorMarginForTopBottom andBottom:_separatorMarginForTopBottom];
            buttonStartX += buttonWidth;
            filterButton.index = idx;
            
            if ([weakSelf.delegate respondsToSelector:@selector(filterView:buttonPulledViewTypeAtIndex:)]) {
                filterButton.buttonPulledViewType = [weakSelf.dataSource filterView:weakSelf buttonPulledViewTypeAtIndex:idx];
            } else {
                filterButton.buttonPulledViewType = BFSFilterButtonPulledViewTypeDefault;
            }
            
            [filterButton addTarget:self action:@selector(filterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button = filterButton;
            [self.buttons addObject:button];
        } else {
            //更多按钮
            button = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartX, 0, self.width - buttonStartX, self.height)];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor colorWithHex:0x5F646E alpha:1.0] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithHex:0xF7F7F7 alpha:1]];
            [button addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
            
            //redView 不知道是用来干啥用的
            _redView = [[UIView alloc] initWithFrame:CGRectMake(48, 15, 6, 6)];
            _redView.backgroundColor = [UIColor redColor];
            _redView.layer.cornerRadius = _redView.width * 0.5;
            _redView.layer.masksToBounds = YES;
            _redView.hidden = YES;
            [button addSubview:_redView];
        }
        [self addSubview:button];
        [button setTitle:item.name forState:UIControlStateNormal];
    }];
    [self useSelectedItems];
}

- (void)showMore:(id)sender
{
    //如果当前已经有展开项，先将其隐藏
    [self filterButtonClicked:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(showMoreFilter)]) {
        [self.delegate showMoreFilter];
    }
}

/**
 *  触发选中item的selectedBlock
 */
- (void)useSelectedItems
{
    [_forest enumerateObjectsUsingBlock:^(BFSFilterItem *item, NSUInteger idx, BOOL *stop) {
        if (item.allowMultipleSelect) {
            
        } else {
            int level = -1;
            int selectedIndex = -1;
            BFSFilterItem *subItem = item;
            while (subItem && subItem.childrenItems.count && subItem.selectedItems.count) {
                selectedIndex = [subItem.selectedItems[0] intValue];
                subItem = subItem.childrenItems[selectedIndex];
                level += 1;
            }
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex level:level];
            if (item.selectedBlock) {
                item.selectedBlock(selectedIndexPath, @[subItem], NO);
            }
            if (idx < self.buttons.count) {
                [self.buttons[idx] setTitle:subItem.name forState:UIControlStateNormal];
            }
        }
    }];
}

- (UIControl *)shadowView
{
    if (!_shadowView) {
        CGPoint windowOirgin = [self convertPoint:CGPointMake(0, self.height) toView:nil];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        _shadowView = [[UIControl alloc] initWithFrame:CGRectMake(windowOirgin.x, windowOirgin.y, self.width, window.height - windowOirgin.y)];
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_shadowView addTarget:self action:@selector(filterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shadowView;
}

- (UIControl *)shadowView_top_assistant
{
    if (!_shadowView_top_assistant) {
        CGPoint windowOirgin = [self convertPoint:CGPointMake(0, 0) toView:nil];
        _shadowView_top_assistant = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.width, windowOirgin.y)];
        _shadowView_top_assistant.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        [_shadowView_top_assistant addTarget:self action:@selector(filterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shadowView_top_assistant;
}

// 点击 BFSFilterButton 触发的事件
- (void)filterButtonClicked:(BFSFilterButton *)sender
{
    // 点击非button位置 隐藏已经打开的 childrenItems。
    if (![sender isKindOfClass:[BFSFilterButton class]]) {
        [self.buttons enumerateObjectsUsingBlock:^(BFSFilterButton *obj, NSUInteger idx, BOOL *stop) {
            obj.unfolded = NO;
        }];
        [self hiddenFilterTableView];
        return;
    }
    
    // 否则的话
    BOOL isUnfolded = sender.unfolded;
    [self.buttons enumerateObjectsUsingBlock:^(BFSFilterButton *obj, NSUInteger idx, BOOL *stop) {
        obj.unfolded = NO;
    }];
    // 如果获取到的sender.unfolded为YES，那我们应该设置为NO，隐藏FilterTableView
    if (isUnfolded) {
        [self hiddenFilterTableView];
        sender.unfolded = NO;
    } else {
        // 如果区域和服务特色选项进行切换，左右的tableView高度不同，则需要先删除再重建
        [self hiddenFilterTableView];
        if (sender.buttonPulledViewType == BFSFilterButtonPulledViewTypeDefault) {
            [self showTableView:sender];
        } else if (sender.buttonPulledViewType == BFSFilterButtonPulledViewTypeCustom) {
            //创建自定义 view
            if ([self.dataSource respondsToSelector:@selector(filterView:customViewAtIndex:correspondingButton:)]) {
                [self showCustomView:[self.dataSource filterView:self customViewAtIndex:sender.index correspondingButton:(BFSFilterButton *)sender]];
            }
        }
        
        //添加自定义价格筛选 [应该是为价格选项做的特殊设置，不管了～]
        if (_isNeedShowPriceBlock) {
            if (sender.index == 1) {
                [self addObserverWithKeyboard];
                
                _filterTableView.height -= 45;
                _filterTableViewHeight = _filterTableView.height;
                
                [self showPriceBlockView:sender];
            } else {
                [self hiddenPriceBlockView];
            }
        }
        
        sender.unfolded = YES;
    }
}

- (void)showPriceBlockView:(BFSFilterButton *)button
{
    _priceBlockView = [[BFSPriceBlockView alloc] initWithFrame:CGRectMake(0, 0, self.width, 45)];
    
    [self.shadowView addSubview:_priceBlockView];
    
    if (self.dataSource) {
        NSString *minPrice = [self.dataSource getMinPrice];
        if (minPrice.length) {
            _priceBlockView.minPrice.text = minPrice;
        }
        
        NSString *maxPrice = [self.dataSource getMaxPrice];
        if (maxPrice.length) {
            _priceBlockView.maxPrice.text = maxPrice;
        }
    }
    _priceBlockView.top = _filterTableView.bottom - .5;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(button) weakButton = button;
    __weak typeof(BFSFilterTableView) *filterTableView = _filterTableView;
    
    _priceBlockView.selectedPriceBlock = ^(NSString *minPrice, NSString *maxPrice)
    {
        NSString *title = @"";
        if (minPrice.length && maxPrice.length) {
            title = [NSString stringWithFormat:@"%@-%@万元",minPrice, maxPrice];
        } else if (minPrice.length && maxPrice.length == 0) {
             title = [NSString stringWithFormat:@"%@万元以上",minPrice];
        } else if (maxPrice.length && minPrice.length == 0) {
            title = [NSString stringWithFormat:@"%@万元以下",maxPrice];
        }  else {
            return ;
        }
        [weakButton setTitle:title forState:UIControlStateNormal];
        
        [weakSelf filterButtonClicked:weakButton];
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didSecetedPriceBlock:theMaxPrice:)]) {
            
            [filterTableView.filterItem.selectedItems removeAllObjects];
            [weakSelf.delegate didSecetedPriceBlock:minPrice theMaxPrice:maxPrice];
        }
    };
}

//添加自定义的 view
- (void)showCustomView:(UIView *)customView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!self.shadowView.superview) {
        [window addSubview:self.shadowView];
        [window addSubview:self.shadowView_top_assistant];
    }
    [self.shadowView addSubview:customView];
}

//当点击 BFSFilterButton 需要打开 tableView 时，执行以下函数
- (void)showTableView:(BFSFilterButton *)button
{
    // keyWindow 属性用于获取当前程序关键窗口
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!self.shadowView.superview){
        [window addSubview:self.shadowView];
        [window addSubview:self.shadowView_top_assistant];
    }
    CGPoint windowOirgin = [self convertPoint:CGPointMake(0, self.height) toView:nil];
    _filterTableView = [[BFSFilterTableView alloc] initWithFilterTableViewStyle:BFSFilterTableViewStylePrevious];
    
    // window.height - windowOirgin.y 是为了防止屏幕较小，所以用我们自己设置的高度，和用屏幕高度减去filterView的高度相比，取较小者
    _filterTableView.frame = CGRectMake(0, 0, self.width, MIN(window.height - windowOirgin.y, _maxTabelViewHeight));
    
    BFSFilterItem *selectedFilterItem = self.innerItems[button.index];
    _filterTableView.filterItem = selectedFilterItem;
    
    // 主要用于设置 filterTableView 的样式，比如文字字体和颜色等等。filterTableViewCellStyle 是一个NSDictionary,可以一次性设置很多属性
    [_filterTableView setFilterTableViewCellStyle:_filterTableViewCellStyle];
    
    [self.shadowView addSubview:_filterTableView];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(button) weakButton = button;
    __weak typeof(selectedFilterItem) weakFilterItem = selectedFilterItem;
    /**
     * 这是用于选择 UITableViewCell 的触发的操作
     *
     * @param indexPath ：表示当前选择的这个 UITableViewCell 的 indexPath
     * @param items ： 表示当前选择的 UITableViewCell 的数组集合
     * @param reallyEffect ：目前用到的都是YES
     */
    _filterTableView.selectedBlock = ^(NSIndexPath *indexPath, NSArray *items, BOOL reallyEffect)
    {
        // reallyEffect YES 表示 BFSFilterButton 展示的文案变成当前选择的 UITableViewCell 的文字
        if (reallyEffect) {
            BFSFilterItem *item = items[0];
            if (item) {
                if (item.otherName.length > 0) {
                    [weakButton setTitle:item.otherName forState:UIControlStateNormal];
                } else {
                    [weakButton setTitle:item.name forState:UIControlStateNormal];
                }
            }
            [weakSelf filterButtonClicked:weakButton];
        }
        if (weakSelf.delegate) {
            for (BFSFilterItem *item in items) {
                item.tag = weakFilterItem.tag;
            }
            // 通过 protocol 将点击 UITableViewCell 需要触发的事件代理到外部，让使用者去填充自己想要干嘛
            [weakSelf.delegate filterView:weakSelf didSelectedItems:items atIndexPath:indexPath];
            
            // 关于价格的设置，先不管了
            if (button.index == 1) {
                //清空自定义价格筛选
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didSecetedPriceBlock:theMaxPrice:)]) {
                    [weakSelf.delegate didSecetedPriceBlock:@"" theMaxPrice:@""];
                }
            }
        }
    };
}

- (void)hiddenPriceBlockView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (_priceBlockView) {
        [_priceBlockView removeFromSuperview];
    }
    
    _priceBlockView = nil;
}

- (void)hiddenFilterTableView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     // 因为不知道加了什么 self.shadowView，和 self.shadowView_top_assistant（这两个不知道用来干嘛）
    [self.shadowView removeFromSuperview];
    [self.shadowView removeAllSubviews];
    [self.shadowView_top_assistant removeFromSuperview];
}

- (void)updateUIWithDataSource
{
    if (self.dataSource) {
        _forest = [NSMutableArray array];
        for (int step = 0; step < [self.dataSource numberOfItemsForFilterView:self]; step ++) {
            BFSFilterItem *item = [self.dataSource filterView:self itemAtIndex:step];
            item.tag = [self.dataSource filterView:self tagAtIndex:step];
            [self.forest addObject:item];
        }
    }
    [self updateUIWithForest];
}

- (void)showRedView:(BOOL)isShowView
{
    if (isShowView) {
        _redView.hidden = NO;
    } else {
        _redView.hidden = YES;
    }
}

#pragma mark - ObserverWithKeyboard
- (void)keyboardWillShow:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = rect.origin.y;
    
    if (_priceBlockView.bottom > height - 64 - self.bottom) {
        [UIView animateWithDuration:.3 animations:^{
            _filterTableView.height = _filterTableView.height - (_priceBlockView.bottom - height + 64) - self.bottom;
            _priceBlockView.top = _filterTableView.bottom - .5;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
    
    if (_filterTableView.height != _filterTableViewHeight) {
        [UIView animateWithDuration:.3 animations:^{
            _filterTableView.height = _filterTableViewHeight;
            _priceBlockView.top = _filterTableView.bottom;
        }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
