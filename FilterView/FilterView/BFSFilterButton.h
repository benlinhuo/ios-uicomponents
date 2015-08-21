//
//  BFSFilterButton.h
//  iFangBroker
//
//  Created by wysasun on 14/12/16.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

// FilterButton 对应的下拉View,如果不设置，认为是默认的
typedef NS_ENUM(NSInteger, BFSFilterButtonPulledViewType)
{
    BFSFilterButtonPulledViewTypeDefault, //默认
    BFSFilterButtonPulledViewTypeCustom // 自定义
};

@interface BFSFilterButton : UIButton

/**
 *  判断对应的filterItem是否已经展开
 */
@property (nonatomic) BOOL unfolded;

// 每个button的属性index
@property (nonatomic) NSInteger index;
//button 对应的下拉view类型
@property (nonatomic) NSInteger buttonPulledViewType;

/**
 *  是否显示右边的分割线
 *
 *  @param show
 */
- (void)showSeparator:(BOOL)show;

/**
 *  set Top and Bottom margin for separtor
 *  设置分割线的上下距离
 *  @param top bottom
 */

- (void)setSeparatorMarginForTop:(CGFloat)top andBottom:(CGFloat)bottom;


@end
