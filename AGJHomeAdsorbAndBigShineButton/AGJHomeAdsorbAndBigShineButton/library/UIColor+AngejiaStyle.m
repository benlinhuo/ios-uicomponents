//
//  UIColor+AngejiaStyle.m
//  PBLAngejia
//
//  Created by wysasun on 15/1/9.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import "UIColor+AngejiaStyle.h"
#import "UIColor+BFS.h"

@implementation UIColor (AngejiaStyle)
/**
 *  灰色
 */
+ (UIColor *)angejiaGrayColor
{
    return [UIColor colorWithHex:0xEEEEEE alpha:1];
}

/**
 *  白色
 */
+ (UIColor *)angejiaWhiteColor
{
    return [UIColor colorWithHex:0xFFFFFF alpha:1];
}

/**
 *  黑色
 */
+ (UIColor *)angejiaBlackColor
{
    return [UIColor colorWithHex:0x000000 alpha:1];
}

/**
 *  深灰，常规字体
 */
+ (UIColor *)angejiaDarkGrayColor
{
    return [UIColor colorWithHex:0x3E3E3E alpha:1];
}

/**
 *  中灰，常规字体
 */
+ (UIColor *)angejiaMediumGrayColor
{
    return [UIColor colorWithHex:0x8D8C92 alpha:1];
}

/**
 *  蓝色，链接字体
 */
+ (UIColor *)angejiaBlueColor
{
    return [UIColor colorWithHex:0x007FFF alpha:1];
}

/**
 *  红色，报错、上涨文案
 */
+ (UIColor *)angejiaRedColor
{
    return [UIColor colorWithHex:0xFF0000 alpha:1];
}

/**
 *  橙色，高亮
 */
+ (UIColor *)angejiaOrangeColor
{
    return [UIColor colorWithHex:0xF15F00 alpha:1];
}

/**
 *  浅橙色，标签
 */
+ (UIColor *)angejiaLightOrangeColor
{
    return [UIColor colorWithHex:0xFFA800 alpha:1];
}

/**
 *  深橙色，价格文案
 */
+ (UIColor *)angejiaDarkOrangeColor
{
    return [UIColor colorWithHex:0xE54A00 alpha:1];
}

/**
 *  绿色，下跌文案
 */
+ (UIColor *)angejiaGreenColor
{
    return [UIColor colorWithHex:0x2CB200 alpha:1];
}

/**
 *  浅灰色，表单外框颜色
 */
+ (UIColor *)angejiaLightGrayColor
{
    return [UIColor colorWithHex:0xA7A7A7 alpha:1];
}

/**
 *  暗灰色，表单输入文案
 */
+ (UIColor *)angejiaDimGrayColor
{
    return [UIColor colorWithHex:0x3E3E3E alpha:1];
}

/**
 *  白灰色，输入框、表单提示文案
 */
+ (UIColor *)angejiaPaleGrayColor
{
    return [UIColor colorWithHex:0xCCCCCC alpha:1];
}

/**
 *  亮灰色，表单框内线条颜色
 */
+ (UIColor *)angejiaBrightGrayColor
{
    return [UIColor colorWithHex:0xD9D9D9 alpha:1];
}

/**
 *  高亮黄色
 */
+ (UIColor *)angejiaHighLightYellowColor
{
    return [UIColor colorWithHex:0xFFEFBF alpha:1];
}


/* ==========以下为约定的常用色值========== */

//背景相关颜色

/**
 *  整体的背景色
 */
+ (UIColor *)angejiaBackgroundColor
{
    return [UIColor colorWithHex:0xEEEEEE alpha:1];
}

/**
 *  cell按压后的背景色
 */
+ (UIColor *)angejiaPressedColor
{
    return [UIColor colorWithHex:0xF8F8F8 alpha:1];
}

/**
 *  突出显示文字的背景色
 */
+ (UIColor *)agjBgOrangeColor
{
    return [UIColor colorWithHex:0xFFEFBF alpha:1];
}

//字体相关颜色

/**
 *  正文
 */
+ (UIColor *)defaultTextColor
{
    return [UIColor colorWithHex:0x3E3E3E alpha:1];
}

/**
 *  输入框、表单提示文案
 */
+ (UIColor *)angejiaPlaceHolderColor
{
    return [UIColor colorWithHex:0xCCCCCC alpha:1];
}

/**
 *  价格颜色
 */
+ (UIColor *)angejiaPriceTextColor
{
    return [UIColor colorWithHex:0xE54A00 alpha:1];
}

/**
 *  链接颜色
 */
+ (UIColor *)angejiaLinkColor
{
    return [UIColor colorWithHex:0x007FFF alpha:1];
}

//线条相关颜色

/**
 *  外边框颜色
 */
+ (UIColor *)angejiaLayerColor
{
    return [UIColor colorWithHex:0xA7A7A7 alpha:1];
}

/**
 *  内部间隔线颜色
 */
+ (UIColor *)angejiaMiddleLineColor
{
    return [UIColor colorWithHex:0xD9D9D9 alpha:1];
}

/**
 * 底Tab选中色
 */
+ (UIColor *)angejiaSelectTabColor
{
    return [UIColor colorWithHex:0x3EA0DD alpha:1.0];
}

+ (UIColor *)angejiaStrongLineColor
{
    return [UIColor colorWithHex:0xC3C3C5 alpha:1.0];
}

/**
 * 分割线
 */
+ (UIColor *)angejiaLineColor
{
    return [UIColor colorWithHex:0xDEDEE2 alpha:1.0];
}

/**
 *  默认淡橙色
 */
+ (UIColor *)angejiaDefaultOrangeColor
{
    return [UIColor colorWithHex:0xFF6D4B alpha:1];
}
@end
