//
//  ViewController.m
//  AGJSliderViewExample
//
//  Created by benlinhuo on 15/9/1.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import "ViewController.h"
#import "AGJSliderView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AGJSliderView *view = [[[NSBundle mainBundle] loadNibNamed:@"AGJSliderView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(30, 100, SCREEN_WIDTH - 45, 300);
    [view configWithParams:nil];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
