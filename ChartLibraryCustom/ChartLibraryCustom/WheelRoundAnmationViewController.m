//
//  WheelRoundAnmationViewController.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/20.
//  Copyright © 2015年 benlinhuo. All rights reserved.
//

#import "WheelRoundAnmationViewController.h"
#import "wheelView.h"

@interface WheelRoundAnmationViewController ()
@property (nonatomic, strong) wheelView *wheelView;
@property (nonatomic, strong) UIButton *button;
@end

@implementation WheelRoundAnmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    wheelView *wheel = [wheelView wheelView];
    wheel.center = self.view.center;
    [wheel startAnimation];
    [self.view addSubview:wheel];
    self.wheelView = wheel;
    [self.view addSubview:self.button];
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"Stop" forState:UIControlStateNormal];
        _button.layer.borderColor = [UIColor blueColor].CGColor;
        _button.layer.borderWidth = 1.f;
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _button.frame = CGRectMake(100, 100, 80, 30);
        [_button addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
    
}

- (void)stopAnimation
{
    [self.wheelView stopAnimation];
}

@end
