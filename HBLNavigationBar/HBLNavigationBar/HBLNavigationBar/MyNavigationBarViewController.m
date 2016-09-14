//
//  MyNavigationBarViewController.m
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/4.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "MyNavigationBarViewController.h"
#import "HBLNavigationBarView.h"
#import "MyNextViewController.h"

#define kNewHouseImagesViewHeight 230

@interface MyNavigationBarViewController () <UITableViewDelegate, UITableViewDataSource, HBLNavigationBarViewDelegate> {
    __weak IBOutlet UITableView *myTableView;
}

@property (nonatomic, strong) HBLNavigationBarView *navBarView;

@end

@implementation MyNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self.view addSubview:self.navBarView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)initUI
{
    myTableView.delegate = self;
    myTableView.dataSource = self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNewHouseImagesViewHeight)];
    headerView.backgroundColor = [UIColor greenColor];
    myTableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyNextViewController *vc = [MyNextViewController new];
    [self.navigationController pushViewController:vc animated:vc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identiferFlag = @"identiferFlag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identiferFlag];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identiferFlag];
    }
    cell.textLabel.text = @"MyMyMy测试当时的非法所得大放送发达地方";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navBarView scrollViewDidScroll:scrollView];
}

#pragma mark - HBLNavigationBarViewDelegate

- (void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter / setter

- (HBLNavigationBarView *)navBarView
{
    if (!_navBarView) {
        _navBarView = [[HBLNavigationBarView alloc] initWithScrollView:myTableView scrollHeight:kNewHouseImagesViewHeight];
        _navBarView.delegate = self;
    }
    return _navBarView;
}

@end
