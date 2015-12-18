//
//  CATransitionViewController.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/20.
//  Copyright © 2015年 benlinhuo. All rights reserved.
//

// 转场动画
#import "CATransitionViewController.h"
#import "ColorImageViewController.h"

@interface CATransitionViewController ()
- (IBAction)exchangeView:(id)sender;
- (IBAction)pushAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 交换视图
- (IBAction)exchangeView:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 苹果官方允许使用的私有API, pageCurl 翻页的效果
    transition.type = @"pageCurl"; // 点击type，可以查看它有几种值
    //  `fromLeft', `fromRight', `fromTop' and  `fromBottom'
    transition.subtype = kCATransitionFromRight;
    // 设置具体的动画 UIView 的一个方法
    [_containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [_containerView.layer addAnimation:transition forKey:@"myAnimation"];// key 唯一表示该动画
}

- (IBAction)pushAction:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";// 立体动画效果
    // 是给下一个 navigationController 的view添加动画
    [self.navigationController.view.layer addAnimation:transition forKey:@"navAnimation"];
    ColorImageViewController *detailVC = [ColorImageViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
