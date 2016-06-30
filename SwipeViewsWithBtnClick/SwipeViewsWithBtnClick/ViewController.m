//
//  ViewController.m
//  SwipeViewsWithBtnClick
//
//  Created by benlinhuo on 16/3/5.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "ViewController.h"
#import "AGJChatEmptyScrollView.h"
#import "UIColor+BFS.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController () <AGJChatEmptyScrollViewDelegate>

@property (nonatomic, strong) AGJChatEmptyScrollView *emptyResultView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.emptyResultView];
}

- (void)gotoBrokerDetailPage:(AGJBroker *)broker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"房源单页" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:NO completion:
     nil];
}

- (void)gotoChatDetailPage:(AGJBroker *)broker
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"微聊单页" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:NO completion:
        nil];

}

- (AGJChatEmptyScrollView *)emptyResultView
{
    if (!_emptyResultView) {
        _emptyResultView = [AGJChatEmptyScrollView loadFromXibIfViewAtFirstIndex];
        _emptyResultView.backgroundColor = [UIColor colorWithHex:0xEEEEEE alpha:1];
        _emptyResultView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_emptyResultView showContentData];
        _emptyResultView.emptyDelegate = self;
    }
    return _emptyResultView;
}

@end
