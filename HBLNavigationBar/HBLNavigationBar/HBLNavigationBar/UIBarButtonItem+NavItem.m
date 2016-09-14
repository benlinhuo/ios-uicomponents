//
//  UIBarButtonItem+NavItem.m
//  Angejia
//
//  Created by wysasun on 15/1/6.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import "UIBarButtonItem+NavItem.h"
#import "UIColor+BFS.h"

@implementation UIBarButtonItem (NavItem)
+ (UIBarButtonItem *)getBackBarButtonItemForPresent:(id)taget action:(SEL)action
{
    UIButton *btn = [self getButtonWithImg:nil highLightedImg:nil titleStr:@"取消" taget:taget action:action];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return buttonItem;
}

+ (UIBarButtonItem *)getBarButtonItemWithString:(NSString *)titleStr taget:(id)taget action:(SEL)action
{
    UIButton *btn = [self getButtonWithImg:nil highLightedImg:nil titleStr:titleStr taget:taget action:action];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return buttonItem;
}

+ (UIBarButtonItem *)getBarButtonItemWithImage:(UIImage *)normalImg highLihtedImg:(UIImage *)highLihtedImg taget:(id)taget action:(SEL)action
{
    UIButton *btn = [self getButtonWithImg:normalImg highLightedImg:highLihtedImg titleStr:nil taget:taget action:action];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return buttonItem;
}

+ (UIBarButtonItem *)getBarSpace:(float)spaceWidth
{
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer.width = spaceWidth;
    
    return spacer;
}

+ (UIButton *)getButtonWithImg:(UIImage *)normalImg highLightedImg:(UIImage *)highLightedImg titleStr:(NSString *)titleStr taget:(id)taget action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (normalImg) {
        CGSize size = normalImg.size;
        btn.frame = CGRectMake(0, 0, size.width, size.height);
        [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:highLightedImg forState:UIControlStateHighlighted];
    } else if (titleStr && titleStr.length > 0){
        btn.frame = CGRectMake(0, 0, 100, 24);
        [btn setTitle:titleStr forState:UIControlStateNormal];
        [btn setTitle:titleStr forState:UIControlStateHighlighted];
//        [btn setTitleColor:[UIColor brokerWhiteColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor brokerLightGrayColor] forState:UIControlStateHighlighted];
//        btn.titleLabel.font = [UIFont H2Font];
        [btn sizeToFit];
    }
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (UIBarButtonItem *)getBarButtonItemWithChangeString:(NSString *)titleStr taget:(id)taget action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 24);
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn setTitle:titleStr forState:UIControlStateHighlighted];
    btn.backgroundColor = [UIColor clearColor];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return buttonItem;
}
@end
