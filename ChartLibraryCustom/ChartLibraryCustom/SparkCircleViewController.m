//
//  SparkCircleViewController.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/15.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import "SparkCircleViewController.h"
#import "SparkCircleView.h"

@interface SparkCircleViewController ()

@end

@implementation SparkCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SparkCircleView *sparkView = [[SparkCircleView alloc] initWithFrame:CGRectMake(15, 100, 300, 300) strokeWidth:8.f radianWidth:10.f];
    sparkView.duration = 100.f;
    [self.view addSubview:sparkView];
}

@end
