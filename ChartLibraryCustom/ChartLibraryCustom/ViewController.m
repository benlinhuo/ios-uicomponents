//
//  ViewController.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/12.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import "ViewController.h"
#import "SparkCircleViewController.h"
#import "BezierPathAnimationViewController.h"
#import "CAGradientLayerImageAnimationViewController.h"
#import "ColorImageViewController.h"
#import "CATransitionViewController.h"
#import "WheelRoundAnmationViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"ChartCircleView";  // 弧形图，百分比
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"ChartCurveLineView";  // 带有弧度的曲线度
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"SparkCircleView";  // 带有动画的弧形进度条
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"gradientLineView";  // 带有渐变色的横向进度条
    } else if (indexPath.row == 4) {     //  动画
        cell.textLabel.text = @"BezierPathAnimation";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"CAGradientLayer色差动画";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"ColorUIImageView组件实现色差动画";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"CATransition转场动画";
    } else if (indexPath.row == 8) {
        cell.textLabel.text = @"WheelRoundAnimation旋转选号游戏";
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        SparkCircleViewController *sparkVC = [SparkCircleViewController new];
        [self.navigationController pushViewController:sparkVC animated:YES];
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        BezierPathAnimationViewController *animationVC = [BezierPathAnimationViewController new];
        [self.navigationController pushViewController:animationVC animated:YES];
    } else if (indexPath.row == 5) {
        CAGradientLayerImageAnimationViewController *gradientImageVC = [[CAGradientLayerImageAnimationViewController alloc] init];
        [self.navigationController pushViewController:gradientImageVC animated:YES];
    } else if (indexPath.row == 6) {
        ColorImageViewController *vc = [ColorImageViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 7) {
        CATransitionViewController *vc = [CATransitionViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 8) {
        WheelRoundAnmationViewController * vc = [WheelRoundAnmationViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
