//
//  OtherNaviagtionBarViewController.m
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/4.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "OtherNaviagtionBarViewController.h"
#import "HBLNavigationBarObject.h"
#import "UIColor+BFS.h"
#import "OtherNextViewController.h"


#define NAVBAR_CHANGE_POINT 50

#define kNewHouseImagesViewHeight 230

@interface OtherNaviagtionBarViewController () <UITableViewDelegate, UITableViewDataSource, HBLNavigationBarObjectDelegate> {
    
    __weak IBOutlet UITableView *otherTableView;
}

@property (nonatomic, strong) HBLNavigationBarObject *navBarObject;

@end

@implementation OtherNaviagtionBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self navBarObject];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navBarObject resetNavigationBar];
    self.navBarObject = nil;
}

- (void)initUI
{
    otherTableView.delegate = self;
    otherTableView.dataSource = self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNewHouseImagesViewHeight)];
    headerView.backgroundColor = [UIColor greenColor];
    otherTableView.tableHeaderView = headerView;
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
    OtherNextViewController *vc = [OtherNextViewController new];
    [self.navigationController pushViewController:vc animated:vc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identiferFlag = @"identiferFlag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identiferFlag];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identiferFlag];
    }
    cell.textLabel.text = @"OtherOther测试当时的非法所得大放送发达地方";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navBarObject scrollViewDidScroll:scrollView];
}

- (void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (HBLNavigationBarObject *)navBarObject
{
    if (!_navBarObject) {
        _navBarObject = [[HBLNavigationBarObject alloc] initWithNaviationController:self.navigationController navigationItem:self.navigationItem scrollView:otherTableView changeHeight:kNewHouseImagesViewHeight];
        _navBarObject.delegate = self;
        }
    return _navBarObject;
}


@end
