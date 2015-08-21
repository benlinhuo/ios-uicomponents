//
//  BFSFilterView.h
//  BIFService
//
//  Created by wysasun on 14/12/8.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFSFilterButton;
@class BFSFilterView;
@class BFSFilterItem;

@protocol BFSFilterViewDataSource<NSObject>
@required
- (NSInteger)numberOfItemsForFilterView:(BFSFilterView *)filterView;
- (NSInteger)filterView:(BFSFilterView *)filterView tagAtIndex:(NSInteger)index;
- (BFSFilterItem *)filterView:(BFSFilterView *)filterView itemAtIndex:(NSInteger)index;

@optional
- (NSString *)getMinPrice;
- (NSString *)getMaxPrice;

/**
 * 用于设置 BFSFilterButton 点击之后，展开的view类型，可以是默认，也可以是自定义
 */
- (NSInteger)filterView:(BFSFilterView *)filterView buttonPulledViewTypeAtIndex:(NSInteger)index;

/**
 * 用于设置对应的自定义view
 */
- (UIView *)filterView:(BFSFilterView *)filterView customViewAtIndex:(NSInteger)index correspondingButton:(BFSFilterButton *)button;
@end

@protocol BFSFilterViewDelegate<NSObject>
@required
/**
 *  用户选中筛选项以后的回调
 *
 *  @param filterView  筛选视图
 *  @param selectItems 具体选中的筛选项
 *  @param indexPath 包含选中的筛选项的层次信息
 */
- (void)filterView:(BFSFilterView *)filterView didSelectedItems:(NSArray */*BFSFilterItems * */)selectItems atIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  用户自定义价格筛选
 *
 */
- (void)didSecetedPriceBlock:(NSString *)minPrice theMaxPrice:(NSString *)maxPrice;

/**
 *  更多筛选项
 *
 */
- (void)showMoreFilter;

@end
/**
 *  筛选试图
 */
@interface BFSFilterView : UIView
@property (nonatomic) NSInteger maxAllowShown;//并排的最大允许的筛选按钮数量,默认为3
@property (nonatomic) CGFloat maxTabelViewHeight;//filtertableview最大的高度，底部高度不足会设置为视图距离底部的高度
@property (nonatomic, retain) NSMutableArray *forest;//里面的数据类型必须为BFSFilterItem,设置filter会自动调用updateUIWithForest
@property (nonatomic, weak) id<BFSFilterViewDataSource> dataSource;
@property (nonatomic, weak) id<BFSFilterViewDelegate> delegate;
@property (nonatomic, strong, readonly) NSMutableArray *buttons;//总的按钮
@property (nonatomic)  CGFloat separatorMarginForTopBottom;
@property (nonatomic, retain) NSMutableDictionary *filterTableViewCellStyle;
@property (nonatomic) BOOL isNeedShowPriceBlock;//YES 显示自定义价格筛选

//add by zxy
/**
 *  设置最大可显示项个数，需重新调用updateUIWithDataSource
 */
-(void) UpdateMaxAllowShownCount:(int)nMaxCount;
/**
 *  设置最大可显示项个数为默认值，需重新调用updateUIWithDataSource
 */
-(void) UpdateMaxAllowShownCountToDefault;
//add end

/**
 *  通过筛选项来创建filterview
 *
 *  @param forest 筛选项列表
 *
 *  @return
 */
- (instancetype)initWithForest:(NSMutableArray *)forest;

/**
 *  根据forest设置更新filter视图
 */
- (void)updateUIWithForest;

/**
 *  通过datasource来更新filter视图
 */
- (void)updateUIWithDataSource;

/**
 *  是否显示小红点
 */
- (void)showRedView:(BOOL)isShowView;

/**
 *  将隐藏 TableView 的接口暴露
 */
- (void)hiddenFilterTableView;

@end