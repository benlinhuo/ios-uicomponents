//
//  AGJLayerAnimationView.m
//  Angejia
//
//  Created by benlinhuo on 16/7/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "AGJLayerAnimationView.h"
#import "UIColor+AngejiaStyle.h"
#import "AGJEnvironmentConfigure.h"

@interface AGJLayerAnimationView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer1;
@property (nonatomic, strong) CAShapeLayer *shapeLayer2;
@property (nonatomic, strong) CAAnimationGroup *animationGoup;

@end
@implementation AGJLayerAnimationView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    if (self = [super initWithFrame:frame]) {
        [self configWithColor:color];
    }
    return self;
}

- (void)configWithColor:(UIColor *)color
{
    CGRect pathFrame = CGRectMake(-[AGJLayerAnimationView buttonWidth] / 2, -[AGJLayerAnimationView buttonWidth] / 2, [AGJLayerAnimationView buttonWidth], [AGJLayerAnimationView buttonWidth]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:[AGJLayerAnimationView buttonWidth] * 1.5 / 2 / 2];
    CGPoint shapePosition = CGPointMake([AGJLayerAnimationView buttonWidth] / 2, [AGJLayerAnimationView buttonWidth] / 2);
    _shapeLayer1 = [CAShapeLayer layer];
    _shapeLayer1.path = path.CGPath;
    _shapeLayer1.position = shapePosition;
    if (color) {
        _shapeLayer1.fillColor = color.CGColor;

    }
    _shapeLayer1.opacity = 0;
    _shapeLayer1.strokeColor = [UIColor clearColor].CGColor;
    _shapeLayer1.lineWidth = 2.0;
    [self.layer addSublayer:_shapeLayer1];
    
    _shapeLayer2 = [CAShapeLayer layer];
    _shapeLayer2.path = path.CGPath;
    _shapeLayer2.position = shapePosition;
    if (color) {
        _shapeLayer2.fillColor = color.CGColor;

    }
    _shapeLayer2.opacity = 0;
    _shapeLayer2.strokeColor = [UIColor clearColor].CGColor;
    _shapeLayer2.lineWidth = 2.0;
    [self.layer addSublayer:_shapeLayer2];
}

+ (CGFloat)buttonWidth
{
    CGFloat buttonWidth = 120;
//    if (IS_IPHONE_6) {
//        buttonWidth = 150;
//    } else if (IS_IPHONE_6P) {
//        buttonWidth = 150;
//    }
    return buttonWidth;
}

- (void)beginAnimation
{
    [_shapeLayer1 removeAllAnimations];
    [_shapeLayer1 addAnimation:self.animationGoup forKey:@"layer1"];
    [self performSelector:@selector(animateLayouer2) withObject:nil afterDelay:2.0];
}

-(void)animateLayouer2
{
    [_shapeLayer2 removeAllAnimations];
    [_shapeLayer2 addAnimation:self.animationGoup forKey:@"layer2"];
}

- (void)stopAnimation
{
    [_shapeLayer1 removeAllAnimations];
    [_shapeLayer2 removeAllAnimations];
}

- (CAAnimationGroup *)animationGoup
{
    if (!_animationGoup) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)];
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @0.3;
        alphaAnimation.toValue = @0;
        
        _animationGoup = [CAAnimationGroup animation];
        _animationGoup.delegate = self;
        _animationGoup.animations = @[scaleAnimation, alphaAnimation];
        _animationGoup.duration = 5.0f;
        _animationGoup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        _animationGoup.repeatCount = HUGE_VALF;
    }
    return _animationGoup;
}
@end
