
//
//  BezierPathAnimationViewController.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/16.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import "BezierPathAnimationViewController.h"
#import "BezierPathAnimation.h"

@interface BezierPathAnimationViewController ()

@end

@implementation BezierPathAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BezierPathAnimation *animationView = [[BezierPathAnimation alloc] initWithPosition:CGPointMake(self.view.center.x, self.view.center.y - 50)];
    [animationView configWithSelector:@selector(animationEventTypeOne)];
    [self.view addSubview:animationView];
    
    BezierPathAnimation *animationView2 = [[BezierPathAnimation alloc] initWithPosition:CGPointMake(self.view.center.x, self.view.center.y + 100)];
    [animationView2 configWithSelector:@selector(animationEventTypeTwo)];
    [self.view addSubview:animationView2];
}

- (void)dealloc
{
    NSLog(@"%@ -> dealloc", self);
}

@end
