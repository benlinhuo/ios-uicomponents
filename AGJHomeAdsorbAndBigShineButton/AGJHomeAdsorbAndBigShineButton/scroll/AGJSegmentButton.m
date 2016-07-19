//
//  AGJSegmentButton.m
//  Angejia
//
//  Created by Liulexun on 16/3/31.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJSegmentButton.h"
#import "UIColor+AngejiaStyle.h"
#import "UIFont+AngejiaStyle.h"
#import "UIView+HandyAutoLayout.h"
#import "AGJUI.h"

@interface AGJSegmentButton ()

@property (nonatomic, strong) UIView *redDot;
@property (nonatomic, assign, readwrite) BOOL isRedDotShown;

@end

@implementation AGJSegmentButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    [self setTitleColor:[UIColor agjGrayTextColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont angejiaH4Font];
    _redDot = [[UIView alloc] init];
    _redDot.backgroundColor = [UIColor redColor];
    _redDot.clipsToBounds = YES;
    _redDot.layer.cornerRadius = 4;
    [self addSubview:_redDot];
    [self addConstraints:[_redDot constraintsSize:CGSizeMake(8, 8)]];
    [self addConstraints:[_redDot constraintsTopInContainer:5]];
    [self addConstraints:[_redDot constraintsRightInContainer:20]];
    _redDot.hidden = YES;

}

- (void)showRedDot
{
    self.isRedDotShown = YES;
    _redDot.hidden = NO;
}

- (void)hideRedDot
{
    self.isRedDotShown = NO;
    _redDot.hidden = YES;
}

- (void)deSelect
{
    [self setTitleColor:[UIColor agjGrayTextColor] forState:UIControlStateNormal];
}

- (void)showSelect
{
    [self setTitleColor:[UIColor angejiaDefaultOrangeColor] forState:UIControlStateNormal];
    [self hideRedDot];
}


@end
