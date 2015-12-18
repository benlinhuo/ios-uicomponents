//
//  ColorImageViewController.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/20.
//  Copyright © 2015年 benlinhuo. All rights reserved.
//

#import "ColorImageViewController.h"
#import "ColorUIImageView.h"

@interface ColorImageViewController ()
@property (nonatomic, strong) ColorUIImageView *colorView;
@property (nonatomic, strong) CALayer *layer;
@end

@implementation ColorImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorView        = [[ColorUIImageView alloc] initWithFrame:CGRectMake(0, 0, 198, 253)];
    self.colorView.center = self.view.center;
    self.colorView.image  = [UIImage imageNamed:@"bg"];
    [self.view addSubview:self.colorView];
    
    [self performSelector:@selector(event)
               withObject:nil
               afterDelay:1.f];
    
//    CALayer *layer = [CALayer layer];
//    layer.bounds = CGRectMake(0, 0, 100, 100);
//    layer.position = CGPointMake(100, 100);
//    layer.backgroundColor = [UIColor yellowColor].CGColor;
//    [self.view.layer addSublayer:layer];
//    self.layer = layer;
}

- (void)event {
    self.colorView.direction = DOWN;
    self.colorView.color     = [UIColor redColor];
    self.colorView.percent   = 0.5;
}










- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self animationScale];
    [self keyAnimation];
}

- (void)animationScale
{
    // 1. 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    // 2. 设置动画：keyPath  用于决定执行怎样的动画
    anim.keyPath = @"bounds"; // 因为是设置bounds的，则一个bounds到另一个bounds尺寸，则只能是缩放的动画了
    // toValue 到达哪个点，byValue 是增加多少值，fromValue 从哪个点开始移动
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)];
    
    // position ，位置，就只能是平移
//    anim.keyPath = @"position";
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    anim.byValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    anim.duration = 2.f; //  动画持续时间
    anim.removedOnCompletion = NO; // 动画执行完毕后不删除动画
    anim.fillMode = @"forwards";
    // 3. 添加动画
    // 组动画
//    CAAnimationGroup *animations = [CAAnimationGroup new];
//    // CAAnimationGroup 只有一个属性animations，它是一个动画的数组，这样就可以按照指定的多个动画运动了
//    animations.animations = @[];
//    // 添加到涂层，因为CAAnimationGroup继承自CAAnimation，所以同基本动画类型方法
//    [self.layer addAnimation:animations forKey:nil];
    [self.layer addAnimation:anim forKey:nil];// key 是用来唯一标识这个动画的，即是nil，也用来唯一表示该动画
}

- (void)keyAnimation
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards; // 保持最新状态
    anim.duration = 2.f;
    CGMutablePathRef path = CGPathCreateMutable();
    // 圆形的路径，第一个参数是可变路径，第二个NULL代表不进行变换，第三个参数是圆形尺寸。照着这个圆形路径进行变换
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    anim.path = path;
    // 设置动画的执行节奏(比如先慢后快，加速度等)
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    [self.layer addAnimation:anim forKey:nil];
    
}

@end

