//
//  ViewController.m
//  AGJHomeAdsorbAndBigShineButton
//
//  Created by benlinhuo on 16/7/6.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "ViewController.h"
#import "AnimationVIewController.h"
#import "ScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画效果";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"animation" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 1.f;
    btn1.frame = CGRectMake(20, 140, 100, 40);
    [btn1 addTarget:self action:@selector(btn1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"scroll" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.layer.borderColor = [UIColor redColor].CGColor;
    btn2.layer.borderWidth = 1.f;
    btn2.frame = CGRectMake(20, 200, 100, 40);
    [btn2 addTarget:self action:@selector(btn2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btn1Clicked
{
    AnimationVIewController *vc = [AnimationVIewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btn2Clicked
{
    ScrollViewController *vc = [ScrollViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
