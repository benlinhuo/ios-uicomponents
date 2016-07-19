//
//  UIButton+BFSStyle.h
//  BIFService
//
//  Created by xbmac on 14/12/9.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BFSStyle)

+ (UIButton *)buttonNomalColor:(UIColor *)nomalColor highLightColor:(UIColor *)hlColor coRadius:(CGFloat)radius;
+ (UIButton *)buttonTextColor:(UIColor *)TC cordius:(CGFloat)cor boderWidth:(CGFloat)width;
+ (UIButton *)buttonTintColor:(UIColor *)TC;

- (void)setTextColor:(UIColor *)TC cordius:(CGFloat)cor boderWidth:(CGFloat)width;
- (void)setTextColor:(UIColor *)TC boderWidth:(CGFloat)width;

- (void)setTitle:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color;
- (void)buttonNomalColor:(UIColor *)nomalColor highLightColor:(UIColor *)hlColor;

//调整button的image和title之间的间距
-(void)centerButtonAndImageWithSpacing:(CGFloat)spacing;

@end
