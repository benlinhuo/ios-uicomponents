//
//  UIButton+BFSStyle.m
//  BIFService
//
//  Created by xbmac on 14/12/9.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "UIButton+BFSStyle.h"
#import "UIImage+BFS.h"

@implementation UIButton (BFSStyle)

+ (UIButton *)buttonNomalColor:(UIColor *)nomalColor highLightColor:(UIColor *)hlColor coRadius:(CGFloat)radius
{
    UIButton *colorButton = [[UIButton alloc] init];
    [colorButton  setBackgroundImage:[UIImage createImageWithColor:nomalColor] forState:UIControlStateNormal];
    [colorButton setBackgroundImage:[UIImage createImageWithColor:hlColor] forState:UIControlStateHighlighted];
    colorButton.layer.cornerRadius  = radius;
    colorButton.layer.masksToBounds = YES;
    
    return colorButton;
}

+ (UIButton *)buttonTextColor:(UIColor *)TC cordius:(CGFloat)cor boderWidth:(CGFloat)width
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tintColor = TC;
    button.backgroundColor = [UIColor clearColor];
    button.layer.cornerRadius  = cor;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [TC CGColor];
    button.layer.borderWidth = width;
    
    return button;
}

+ (UIButton *)buttonTintColor:(UIColor *)TC
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tintColor = TC;
    button.backgroundColor = [UIColor clearColor];
    return button;
}

- (void)setTextColor:(UIColor *)TC cordius:(CGFloat)cor boderWidth:(CGFloat)width
{
    self.tintColor = TC;
    [self setTitleColor:TC forState:UIControlStateNormal];
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius  = cor;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [TC CGColor];
    self.layer.borderWidth = width;
}

- (void)setTextColor:(UIColor *)TC boderWidth:(CGFloat)width
{
    self.tintColor = TC;
    [self setTitleColor:TC forState:UIControlStateNormal];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [TC CGColor];
    self.layer.borderWidth = width;
}

- (void)setTitle:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color
{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)buttonNomalColor:(UIColor *)nomalColor highLightColor:(UIColor *)hlColor
{
    [self setBackgroundImage:[UIImage createImageWithColor:nomalColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage createImageWithColor:hlColor] forState:UIControlStateHighlighted];
}

-(void)centerButtonAndImageWithSpacing:(CGFloat)spacing
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}
@end
