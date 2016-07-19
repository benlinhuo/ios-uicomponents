//
//  UIButton+AGJStandard.m
//  PBLAngejia
//
//  Created by Liulexun on 16/4/25.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "UIButton+AGJStandard.h"
#import "UIColor+AGJStandard.h"
#import "UIFont+AGJStandard.h"
#import "UIImage+BFS.h"
#import "UIColor+BFS.h"
#import "AGJRadius.h"

@implementation UIButton (AGJStandard)
/**
 *  重要按钮
 */
+ (UIButton *)filledOrangeBtn
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont agjH3Font_B];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = agjDefaultRadius;
    button.clipsToBounds = YES;
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor agjOrangeColor] cornerRadius:1.0] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE56143 alpha:1.0] cornerRadius:1.0] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE56143 alpha:1.0] cornerRadius:1.0] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor agjLine] cornerRadius:1.0] forState:UIControlStateDisabled];
    return button;
}

/**
 *  次要按钮
 */
+ (UIButton *)smallFilledOrangeBtn
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont agjH4Font];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = agjDefaultRadius;
    button.clipsToBounds = YES;
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor agjOrangeColor] cornerRadius:1.0] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE56143 alpha:1.0] cornerRadius:1.0] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE56143 alpha:1.0] cornerRadius:1.0] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor agjLine] cornerRadius:1.0] forState:UIControlStateDisabled];
    return button;
}


/**
 *  空心大按钮
 */
+ (UIButton *)strokeOrangeBtn
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont agjH3Font_B];
    [button setTitleColor:[UIColor agjOrangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHex:0xE56143 alpha:1.0] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHex:0xE56143 alpha:1.0] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor agjHintBgColor] forState:UIControlStateDisabled];
    button.layer.borderColor = [[UIColor agjOrangeColor] CGColor];
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = agjDefaultRadius;
    button.clipsToBounds = YES;
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:1.0] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:1.0] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:1.0] forState:UIControlStateHighlighted];

    
    return button;
}

/**
 *  空心小按钮
 */
+ (UIButton *)smallStrokeOrangeBtn
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont agjH4Font_B];
    [button setTitleColor:[UIColor agjOrangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHex:0xE56143 alpha:1.0] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithHex:0xE56143 alpha:1.0] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor agjHintBgColor] forState:UIControlStateDisabled];
    button.layer.borderColor = [[UIColor agjOrangeColor] CGColor];
    button.layer.borderWidth = 0.5;
    button.layer.cornerRadius = agjDefaultRadius;
    button.clipsToBounds = YES;
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:1.0] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:1.0] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:1.0] forState:UIControlStateHighlighted];
    
    return button;
}
@end
