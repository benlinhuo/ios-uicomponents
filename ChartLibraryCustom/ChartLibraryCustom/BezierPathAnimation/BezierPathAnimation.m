//
//  BezierPathAnimation.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/16.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import "BezierPathAnimation.h"
// 动画原理：每隔一秒更改它的 strokeStart / strokeEnd
@interface BezierPathAnimation ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation BezierPathAnimation

- (instancetype)initWithPosition:(CGPoint)position
{
    self = [super init];
    // 设置背景色
    self.backgroundColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1];
    
    // 创建椭圆形贝塞尔曲线
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    
    // 创建CAShapeLayer
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 0, 100, 100);
    _shapeLayer.position = position;
    
    // 修改CAShapeLayer的线条相关值
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    _shapeLayer.lineWidth = 2.f;
    _shapeLayer.strokeStart = 0.f;
    _shapeLayer.strokeEnd = 1.f;
    
    // 建立贝塞尔曲线与CAShapeLayer之间的关联
    _shapeLayer.path = oval.CGPath;
    
    // 添加并显示
    [self.layer addSublayer:_shapeLayer];
    
    return self;

}

- (void)configWithSelector:(SEL)selector
{
    // 创建定时器，每隔1s 执行一次该方法
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                              target:self
                                            selector:selector
                                            userInfo:nil
                                             repeats:YES];
}

/**
 *  动画效果1：只更改 strokeEnd 的值
 */
- (void)animationEventTypeOne
{
    // 执行隐式动画
    _shapeLayer.strokeEnd = arc4random() % 100 / 100.f;// 0~1之间
}

/**
 *  动画效果2
 */
- (void)animationEventTypeTwo
{
    CGFloat valueOne = arc4random() % 100 / 100.f;
    CGFloat valueTwo = arc4random() % 100 / 100.f;
    
    // 执行隐式动画: strokeStart strokeEnd 都随机变化
    _shapeLayer.strokeStart = valueOne < valueTwo ? valueOne : valueTwo;
    _shapeLayer.strokeEnd   = valueOne > valueTwo ? valueOne : valueTwo;
}

@end
