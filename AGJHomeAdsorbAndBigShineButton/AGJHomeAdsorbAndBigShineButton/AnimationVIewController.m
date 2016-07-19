//
//  AnimationVIewController.m
//  AGJHomeAdsorbAndBigShineButton
//
//  Created by benlinhuo on 16/7/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "AnimationVIewController.h"
#import "AGJHomeGuidView.h"
#import "AGJEnvironmentConfigure.h"

@interface AnimationVIewController ()<AGJHomeGuidViewDelegate>

@property (nonatomic, strong) AGJHomeGuidView *guidView;

@end

@implementation AnimationVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.guidView];
    [self startAnimation];
}

- (void)startAnimation
{
    [self.guidView.animationView stopAnimation];
    [self.guidView.animationView beginAnimation];
}

#pragma mark - AGJHomeGuidViewDelegate
- (void)didHelpmeButtonTouched
{
    NSLog(@"clicked button");
}

// 重点在闪光的点
- (AGJHomeGuidView *)guidView
{
    if (!_guidView) {
        _guidView = [[AGJHomeGuidView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 260)];
        _guidView.delegate = self;
    }
    return _guidView;
}

@end
