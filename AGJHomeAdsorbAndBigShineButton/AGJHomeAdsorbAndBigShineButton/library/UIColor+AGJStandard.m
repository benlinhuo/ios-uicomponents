//
//  UIColor+AGJStandard.m
//  PBLAngejia
//
//  Created by Liulexun on 16/4/25.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "UIColor+AGJStandard.h"
#import "UIColor+BFS.h"

@implementation UIColor (AGJStandard)
#pragma mark - 背景色
/**
 *  页面默认背景色
 */
+(UIColor *)agjBgPageColor
{
    return [UIColor colorWithHex:0xEEEEEE alpha:1];
}

/**
 *  按压后的背景色
 */
+(UIColor *)agjBgPressedColor
{
    return [UIColor colorWithHex:0xF8F8F8 alpha:1];
}

/**
 *  标签，提示等的背景色
 */
+(UIColor *)agjHintBgColor
{
    return [UIColor colorWithHex:0xCCCCCC alpha:1];
}

/**
 *  突出显示文字的背景色
 */
+(UIColor *)agjBgOrangeColor
{
    return [UIColor colorWithHex:0xFFEFBF alpha:1];
}

/**
 *  红色标签的背景
 */
+(UIColor *)agjBgRedColor
{
    return [UIColor colorWithHex:0xE54A00 alpha:1];
}

/**
 *  浅绿色标签的背景
 */
+(UIColor *)agjBgBabyGreenColor
{
    return [UIColor colorWithHex:0x70D4D6 alpha:1];
}

#pragma mark - 字体_1
/**
 *  列表标题/特别重要的点
 */
+(UIColor *)agjBlackColor
{
    return [UIColor colorWithHex:0x000000 alpha:1];
}

/**
 *  深色背景下的白色字体
 */
+(UIColor *)agjWhiteColor
{
    return [UIColor colorWithHex:0xFFFFFF alpha:1];
}

/**
 *  正文文字，默认的文字颜色
 */
+(UIColor *)agjDefaultTextColor
{
    return [UIColor colorWithHex:0x3E3E3E alpha:1];
}

/**
 *  辅助的文字颜色
 */
+(UIColor *)agjGrayTextColor
{
    return [UIColor colorWithHex:0x8D8C92 alpha:1];
}

/**
 *  提示文字颜色
 */
+(UIColor *)agjHintTextColor
{
    return [UIColor colorWithHex:0xCCCCCC alpha:1];
}

/**
 *  价格/重要文字
 */
+(UIColor *)agjPriceTextColor
{
    return [UIColor colorWithHex:0xFF6D4B alpha:1];
}

/**
 *  价格下跌
 */
+(UIColor *)agjGreenColor
{
    return [UIColor colorWithHex:0x2CB200 alpha:1];
}

/**
 *  价格上涨
 */
+(UIColor *)agjRedColor
{
    return [UIColor colorWithHex:0xFF0000 alpha:1];
}

/**
 *  青色
 */
+(UIColor *)agjCyanColor
{
    return [UIColor colorWithHex:0x45C7C9 alpha:1];
}

/**
 *  金色
 */
+(UIColor *)agjGoldenColor
{
    return [UIColor colorWithHex:0xFF80000 alpha:1];
}

/**
 *  银色
 */
+(UIColor *)agjSilverColor
{
    return [UIColor colorWithHex:0x7EABC7 alpha:1];
}

#pragma mark - 字体_2
/**
 *  链接
 */
+(UIColor *)agjBlueColor
{
    return [UIColor colorWithHex:0x007FFF alpha:1];
}

/**
 *  链接
 */
+(UIColor *)agjOrangeColor
{
    return [UIColor colorWithHex:0xFF6D4B alpha:1];
}

/**
 *  标签
 */
+(UIColor *)agjLightOrangeColor
{
    return [UIColor colorWithHex:0xF4A47B alpha:1];
}

#pragma mark - 线条
/**
 *  深色线
 */
+(UIColor *)agjDarkLineColor
{
    return [UIColor colorWithHex:0xA7A7A7 alpha:1];
}

/**
 *  浅色线，默认的线条颜色
 */
+(UIColor *)agjLine
{
    return [UIColor colorWithHex:0xD9D9D9 alpha:1];
}


@end
