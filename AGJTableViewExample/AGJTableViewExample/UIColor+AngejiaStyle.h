//
//  UIColor+AngejiaStyle.h
//  PBLAngejia
//
//  Created by wysasun on 15/1/9.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AngejiaStyle)
/**
 *  灰色
 */
+ (UIColor *)angejiaGrayColor;
/**
 *  白色
 */
+ (UIColor *)angejiaWhiteColor;
/**
 *  黑色
 */
+ (UIColor *)angejiaBlackColor;
/**
 *  深灰，常规字体
 */
+ (UIColor *)angejiaDarkGrayColor;
/**
 *  中灰，常规字体
 */
+ (UIColor *)angejiaMediumGrayColor;
/**
 *  蓝色，链接字体
 */
+ (UIColor *)angejiaBlueColor;
/**
 *  红色，报错、上涨文案
 */
+ (UIColor *)angejiaRedColor;
/**
 *  橙色，高亮
 */
+ (UIColor *)angejiaOrangeColor;
/**
 *  浅橙色，标签
 */
+ (UIColor *)angejiaLightOrangeColor;
/**
 *  深橙色，价格文案
 */
+ (UIColor *)angejiaDarkOrangeColor;
/**
 *  绿色，下跌文案
 */
+ (UIColor *)angejiaGreenColor;
/**
 *  浅灰色，表单外框颜色
 */
+ (UIColor *)angejiaLightGrayColor;
/**
 *  暗灰色，表单输入文案
 */
+ (UIColor *)angejiaDimGrayColor;
/**
 *  白灰色，输入框、表单提示文案
 */
+ (UIColor *)angejiaPaleGrayColor;
/**
 *  亮灰色，表单框内线条颜色
 */
+ (UIColor *)angejiaBrightGrayColor;
/**
 *  高亮黄色
 */
+ (UIColor *)angejiaHighLightYellowColor;


//==========以下为约定的常用色值==========


/**
 *  整体的背景色
 */
+ (UIColor *)angejiaBackgroundColor;

/**
 *  cell按压后的背景色
 */
+ (UIColor *)angejiaPressedColor;

/**
 *  突出显示文字的背景色
 */
+ (UIColor *)agjBgOrangeColor;

//字体相关颜色

/**
 *  正文
 */
+ (UIColor *)defaultTextColor;

/**
 *  输入框、表单提示文案
 */
+ (UIColor *)angejiaPlaceHolderColor;

/**
 *  价格颜色
 */
+ (UIColor *)angejiaPriceTextColor;

/**
 *  链接颜色
 */
+ (UIColor *)angejiaLinkColor;

//线条相关颜色

/**
 *  外边框颜色
 */
+ (UIColor *)angejiaLayerColor;

/**
 *  内部间隔线颜色
 */
+ (UIColor *)angejiaMiddleLineColor;

/**
 * 底Tab选中色
 */
+ (UIColor *)angejiaSelectTabColor;

+ (UIColor *) angejiaStrongLineColor;

/**
 * 分割线
 */
+ (UIColor *)angejiaLineColor;

/**
 *  默认淡橙色
 */
+ (UIColor *)angejiaDefaultOrangeColor;

@end