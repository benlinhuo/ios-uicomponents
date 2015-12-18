//
//  wheelView.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/20.
//  Copyright © 2015年 benlinhuo. All rights reserved.
//

#import "wheelView.h"
#import "JKButton.h"

@interface wheelView ()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *centerView;
- (IBAction)chooseNum;

@end

@implementation wheelView

- (void)awakeFromNib
{
    self.centerView.userInteractionEnabled = YES;
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *imageSelected = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    // 从大图中裁剪对应星座的图片
    CGFloat smallW = image.size.width / 12;
    CGFloat smallH = image.size.height;
    CGFloat scale = [UIScreen mainScreen].scale;
    // 高宽转成像素。scale表示屏幕分辨率（retina屏幕就是2，6p之前）
    smallW = smallW * scale;
    smallH = smallH * scale;
    for (int i = 0; i < 12; i++) {
        JKButton *btn = [JKButton buttonWithType:UIButtonTypeCustom];
        CGRect smallRect = CGRectMake(i * smallW, 0, smallW, smallH);
        
        // 裁剪图片，属于绘图部分
        // 根据rect大小裁剪图片.CGImageCreateWithImageInRect只认像素，所以需要将高宽进行转换
        CGImageRef smallImage = CGImageCreateWithImageInRect(image.CGImage, smallRect);
        [btn setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        
        // 选中状态的图片
        CGImageRef smallSelected = CGImageCreateWithImageInRect(imageSelected.CGImage, smallRect);
        [btn setImage:[UIImage imageWithCGImage:smallSelected] forState:UIControlStateSelected];
        // 背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        btn.bounds = CGRectMake(0, 0, 68, 143);
        
        // 设置定位点和位置
        // 让箭头的箭头对准中间
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.centerView.frame.size.width * 0.5, self.centerView.frame.size.height * 0.5);
        
        // 设置旋转角度（绕着锚点进行旋转）
        CGFloat angle = (30 * i) / 180.0 * M_PI;// 360/12＝30
        btn.transform = CGAffineTransformMakeRotation(angle);
        
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self.centerView addSubview:btn];
        // 第一个默认选中
        if (i == 0) {
            [self btnClick:btn];
        }
    }

}

#pragma mark - 按钮响应事件：修改按钮选中状态
- (void)btnClick:(JKButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

+ (instancetype)wheelView
{
    return [[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil].firstObject;
}

// 核心动画不会改变涂层的位置
- (void)startAnimation
{
    if (self.link) {
        return;
    }
    // 1秒刷新60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

- (void)stopAnimation;
{
    [self.link invalidate];
    self.link = nil;
}

// 让视图不停的旋转
- (void)update
{
    self.centerView.transform = CGAffineTransformRotate(self.centerView.transform, M_PI / 100);
}


- (IBAction)chooseNum {
    [self stopAnimation];
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(2 * M_PI * 3);
    anim.duration = 2;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    [self.centerView.layer addAnimation:anim forKey:nil];
    self.userInteractionEnabled = NO;
}

#pragma mark - Animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    // 选中的图片居中
    self.centerView.transform = CGAffineTransformMakeRotation(- (self.selectedBtn.tag * M_PI / 6));
    // 3秒以后进行旋转
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}
@end
