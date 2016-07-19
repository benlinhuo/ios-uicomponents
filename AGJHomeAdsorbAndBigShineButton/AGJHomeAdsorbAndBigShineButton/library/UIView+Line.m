//
//  UIView+Line.m
//  Angejia
//
//  Created by wysasun on 15/2/11.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import "UIView+Line.h"
#import "UIColor+AngejiaStyle.h"
#import "UIView+BFS.h"
#import <QuartzCore/QuartzCore.h>


static const CGFloat offLength = 400;
static const NSInteger errorimageViewTag = 66;

@implementation UIView (Line)
- (void)changeToLineWithLineAlignment:(AGJLineAlignment)alignment
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    CALayer *line= [CALayer new];
    line.backgroundColor = [[UIColor angejiaBrightGrayColor] CGColor];
    switch (alignment) {
        case AGJLineAlignmentBottom:
            line.frame = CGRectMake(0, self.height - 0.5,self.width + offLength, 0.5);
            break;
        case AGJLineAlignmentTop:
            line.frame = CGRectMake(0, 0,self.width + offLength, 0.5);
            break;
        case AGJLineAlignmentLeft:
            line.frame = CGRectMake(0, 0, 0.5, self.height + offLength);
            break;
        case AGJLineAlignmentRight:
            line.frame = CGRectMake(self.width - 0.5, 0,0.5, self.height + offLength);
            break;
        default:
            break;
    }
    [self.layer addSublayer:line];
}

- (UIView *)addTopLine
{
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor angejiaBrightGrayColor];
    topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:topLine];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topLine]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(topLine)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLine(0.5)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(topLine)]];
    return topLine;
}
- (UIView *)addBottomLine
{
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor angejiaBrightGrayColor];
    bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:bottomLine];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomLine]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(bottomLine)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLine(0.5)]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(bottomLine)]];
    return bottomLine;
}

- (void)addTopLineWithColor:(UIColor *)color
{
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = color;
    topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:topLine];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topLine]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(topLine)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLine(0.5)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(topLine)]];
}

- (void)addBottomLineWithColor:(UIColor *)color
{
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = color;
    bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:bottomLine];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomLine]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(bottomLine)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLine(0.5)]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(bottomLine)]];
}

- (UIImageView *)addArrowRight
{
    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right_s"]];
    rightArrow.contentMode = UIViewContentModeScaleAspectFit;
    rightArrow.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:rightArrow];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightArrow(13)]-15-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(rightArrow)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightArrow(19)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(rightArrow)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:rightArrow
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    
    return rightArrow;
}

- (void)addErrorLayer
{
    for (id crrentView in self.subviews) {
        if ([crrentView isKindOfClass:[UIImageView class]]) {
            UIImageView *currentImageView = crrentView;
            if (currentImageView.tag == errorimageViewTag) {
                return;
            }
        }
    }
    UIImageView *errorimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cuowutishikuang"]];
    errorimageView.translatesAutoresizingMaskIntoConstraints = NO;
    errorimageView.tag = errorimageViewTag;
    [self addSubview:errorimageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[errorimageView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(errorimageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[errorimageView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(errorimageView)]];
    [self sendSubviewToBack:errorimageView];
}

- (void)removeErrorLayer
{
    for (id crrentView in self.subviews) {
        if ([crrentView isKindOfClass:[UIImageView class]]) {
            UIImageView *currentImageView = crrentView;
            if (currentImageView.tag == errorimageViewTag) {
                [currentImageView removeFromSuperview];
            }
        }
    }
}
@end
