//
//  ViewController.m
//  HBLStatusBar
//
//  Created by benlinhuo on 16/6/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "ViewController.h"
#import "HBLStatusBarNotification.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn.frame = CGRectMake(30, 150, 100, 40);
    [showBtn setTitle:@"显示" forState:UIControlStateNormal];
    showBtn.backgroundColor = [UIColor whiteColor];
    showBtn.layer.borderColor = [UIColor blueColor].CGColor;
    showBtn.layer.borderWidth = 1.f;
    [showBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showStatusBar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)showStatusBar
{
    // HBLStatusBarNotification 它会跟着手指交互
    
    // jumpInfo: 表示当我点击弹出的提示消息，跳转到指定页面。他是在组件内部，通过添加观察者的方式来达到这样的效果（HBLJumpWithChatMessageIdentifer）。所以，如果想要实现跳转的功能，只需要 addObserver 即可，参数通过 userInfo 传递过来
     [HBLStatusBarNotification showDefaultImageWithTitle:@"测试" subTitle:@"这是一条测试信息，哈哈" jumpInfo:nil];
}


@end
