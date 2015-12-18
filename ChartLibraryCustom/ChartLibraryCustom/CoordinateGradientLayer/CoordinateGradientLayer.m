//
//  CoordinateGradientLayer.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/20.
//  Copyright © 2015年 benlinhuo. All rights reserved.
//

#import "CoordinateGradientLayer.h"

@interface CoordinateGradientLayer ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation CoordinateGradientLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    // 创建背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    imageView.center = self.center;
    [self addSubview:imageView];
    
    
    //  初始化渐变色
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:self.gradientLayer];
    
    // 设定颜色渐变方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    // 设定颜色组
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor];
    
    
    // 设置颜色分割点
    self.gradientLayer.locations = @[@(0.5), @(1.0f)];
    
    return self;
}



@end
