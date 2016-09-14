//
//  HBLFirstViewController.m
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/2.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLFirstViewController.h"
#import "MyNavigationBarViewController.h"
#import "OtherNaviagtionBarViewController.h"
#import "OtherPreViewController.h"

@interface HBLFirstViewController ()

@end

@implementation HBLFirstViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTab];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initTab
{
    [super initTabWithTitle:@"首页" imageName:@"tab_home_pre" selectedImageName:@"tab_home"];
}

- (IBAction)otherNavigationBarMethod:(id)sender
{
    OtherPreViewController *otherVC = [OtherPreViewController new];
    otherVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:otherVC animated:YES];
}

- (IBAction)myNavigationBarMethod:(id)sender
{
    MyNavigationBarViewController *MyVC = [MyNavigationBarViewController new];
    MyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:MyVC animated:YES];
}

@end
