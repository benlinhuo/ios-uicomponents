//
//  HBLBasicViewController.m
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/2.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLBasicViewController.h"
#import "UIColor+BFS.h"

@interface HBLBasicViewController ()

@end

@implementation HBLBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initTabWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    if (title.length > 0) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                        image:[UIImage imageNamed:imageName]
                                                selectedImage:[UIImage imageNamed:selectedImageName]];
        
    } else {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title
                                                        image:[UIImage imageNamed:imageName]
                                                selectedImage:[UIImage imageNamed:selectedImageName]];
        
    }
    [self.tabBarItem setTitleTextAttributes:@{
                                              NSForegroundColorAttributeName: [UIColor colorWithHex:0xFF6D4B alpha:1]
                                              }
                                   forState:UIControlStateHighlighted];
}

@end
