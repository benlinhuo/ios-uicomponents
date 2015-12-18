//
//  CAGradientLayerImageAnimationViewController.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/20.
//  Copyright © 2015年 benlinhuo. All rights reserved.
//

// 该类可以封装到 UIImageView 的子类当中，它呈现的是在 UIImageView 图片上有层蒙板的感觉
#import "CAGradientLayerImageAnimationViewController.h"

@interface CAGradientLayerImageAnimationViewController ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CAGradientLayerImageAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    
    //  初始化渐变色
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:self.gradientLayer];
    
    // 设定颜色渐变方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    // 设定颜色组(上半部分让其透明，所以用clearColor)
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor];
    
    
    // 设置颜色分割点
    self.gradientLayer.locations = @[@(0.5), @(1.0f)];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.f
                                                  target:self
                                                selector:@selector(timerEvent)
                                                userInfo:nil
                                                 repeats:YES];
    
}

- (void)timerEvent
{
    // 设置颜色组颜色变化
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor colorWithRed:arc4random() % 255 / 255.f
                                                               green:arc4random() % 255 / 255.f
                                                                blue:arc4random() % 255 / 255.f
                                                               alpha:1].CGColor];
    
    
    // 设置颜色分割点动画
    self.gradientLayer.locations = @[@(arc4random() % 10 / 10.f), @(1.0f)];
}

@end
