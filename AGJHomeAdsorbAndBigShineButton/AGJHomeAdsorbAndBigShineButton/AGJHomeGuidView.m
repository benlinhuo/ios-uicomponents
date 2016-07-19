//
//  AGJHomeGuidView.m
//  AGJHomeAdsorbAndBigShineButton
//
//  Created by benlinhuo on 16/7/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "AGJHomeGuidView.h"
#import "UIImage+BFS.h"
#import "UIColor+AngejiaStyle.h"
#import "UIFont+AngejiaStyle.h"
#import "UIColor+BFS.h"
#import "UIButton+BFSStyle.h"
#import "AGJUI.h"
#import "AGJLayerAnimationView.h"
#import "UIView+LayoutMethods.h"


@implementation AGJHomeGuidView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self config];
    }
    return self;
}

- (void)config
{
    AGJLayerAnimationView *animationView = self.animationView;
    [self addSubview:animationView];
    UIButton *circleButton = [[UIButton alloc] initWithFrame:CGRectMake((self.width - [AGJLayerAnimationView buttonWidth]) / 2, 40, [AGJLayerAnimationView buttonWidth], [AGJLayerAnimationView buttonWidth])];
    [circleButton addTarget:self action:@selector(helpButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    circleButton.clipsToBounds = YES;
    [circleButton setBackgroundImage:[UIImage imageNamed:@"bg_bwzf_pre"] forState:UIControlStateNormal];
    [circleButton setBackgroundImage:[UIImage imageNamed:@"bg_bwzf"] forState:UIControlStateHighlighted];
    [self addSubview:circleButton];
    
    CGFloat iconTopSpace = 30;
    CGFloat textLabelTopSpace = 60;
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:16];
    
//    if (IS_IPHONE_6) {
//        iconTopSpace = 35;
//        textLabelTopSpace = 67;
//        textLabel.font = [UIFont systemFontOfSize:19];
//    } else if (IS_IPHONE_6P) {
//        iconTopSpace = 40;
//        textLabelTopSpace = 70;
//        textLabel.font = [UIFont systemFontOfSize:21];
//        
//    }
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, iconTopSpace, 40, 30)];
    icon.image = [UIImage imageNamed:@"icon_bwzf"];
    [circleButton addSubview:icon];
    icon.centerX = [AGJLayerAnimationView buttonWidth] / 2;
    
    textLabel.frame = CGRectMake(0, textLabelTopSpace, 120, 40);
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"填需求找房";
    [circleButton addSubview:textLabel];
    textLabel.centerX = [AGJLayerAnimationView buttonWidth] / 2;
}


- (void)helpButtonTouched
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHelpmeButtonTouched)]) {
        [self.delegate didHelpmeButtonTouched];
    }
}

- (AGJLayerAnimationView *)animationView
{
    if (!_animationView) {
        _animationView = [[AGJLayerAnimationView alloc] initWithFrame:CGRectMake((self.width - [AGJLayerAnimationView buttonWidth]) / 2, 40, [AGJLayerAnimationView buttonWidth], [AGJLayerAnimationView buttonWidth]) color:[UIColor angejiaDefaultOrangeColor]];
    }
    return _animationView;
}

@end

