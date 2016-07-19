//
//  UIColor+AGJStandard.h
//  PBLAngejia
//
//  Created by Liulexun on 16/4/25.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AGJStandard)
#pragma mark - 背景色
/**
 *  页面默认背景色
 */
+(UIColor *)agjBgPageColor;

/**
 *  按压后的背景色
 */
+(UIColor *)agjBgPressedColor;

/**
 *  标签，提示等的背景色
 */
+(UIColor *)agjHintBgColor;

/**
 *  突出显示文字的背景色
 */
+(UIColor *)agjBgOrangeColor;

/**
 *  红色标签的背景
 */
+(UIColor *)agjBgRedColor;

/**
 *  浅绿色标签的背景
 */
+(UIColor *)agjBgBabyGreenColor;

#pragma mark - 字体_1
/**
 *  列表标题/特别重要的点
 */
+(UIColor *)agjBlackColor;

/**
 *  深色背景下的白色字体
 */
+(UIColor *)agjWhiteColor;

/**
 *  正文文字，默认的文字颜色
 */
+(UIColor *)agjDefaultTextColor;

/**
 *  辅助的文字颜色
 */
+(UIColor *)agjGrayTextColor;

/**
 *  提示文字颜色
 */
+(UIColor *)agjHintTextColor;

/**
 *  价格/重要文字
 */
+(UIColor *)agjPriceTextColor;

/**
 *  价格下跌
 */
+(UIColor *)agjGreenColor;

/**
 *  价格上涨
 */
+(UIColor *)agjRedColor;

/**
 *  青色
 */
+(UIColor *)agjCyanColor;

/**
 *  金色
 */
+(UIColor *)agjGoldenColor;

/**
 *  银色
 */
+(UIColor *)agjSilverColor;

#pragma mark - 字体_2
/**
 *  链接
 */
+(UIColor *)agjBlueColor;

/**
 *  链接
 */
+(UIColor *)agjOrangeColor;

/**
 *  标签
 */
+(UIColor *)agjLightOrangeColor;

#pragma mark - 线条
/**
 *  深色线
 */
+(UIColor *)agjDarkLineColor;

/**
 *  浅色线，默认的线条颜色
 */
+(UIColor *)agjLine;


@end
