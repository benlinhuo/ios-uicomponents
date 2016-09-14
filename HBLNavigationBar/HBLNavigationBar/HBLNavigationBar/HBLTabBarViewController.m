//
//  HBLTabBarViewController.m
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/2.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLTabBarViewController.h"
#import "HBLFirstViewController.h"

@interface HBLTabBarViewController ()

@end

@implementation HBLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HBLFirstViewController *vc1 = [HBLFirstViewController new];
    HBLFirstViewController *vc2 = [HBLFirstViewController new];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    self.viewControllers = @[nav1, nav2];
    
}





@end
