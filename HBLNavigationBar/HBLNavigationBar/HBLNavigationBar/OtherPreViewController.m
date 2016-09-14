//
//  OtherPreViewController.m
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/4.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "OtherPreViewController.h"
#import "OtherNaviagtionBarViewController.h"

@interface OtherPreViewController ()

@end

@implementation OtherPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)enterNextOtherVC:(id)sender
{
    OtherNaviagtionBarViewController *vc = [OtherNaviagtionBarViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
