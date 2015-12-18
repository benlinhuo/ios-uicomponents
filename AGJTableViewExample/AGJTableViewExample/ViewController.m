//
//  ViewController.m
//  AGJTableViewExample
//
//  Created by benlinhuo on 15/12/17.
//  Copyright © 2015年 benlinhuo. All rights reserved.
//

#import "ViewController.h"
#import "AGJTableView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, AGJTableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) AGJTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:238/255 green:238/255 blue:238/255 alpha:1];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"com.hbl.member.AGJTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = @"测试 UITableView 的头部刷新";
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"11111");
}

#pragma mark - AGJTableViewDelegate
- (void)AGJTableViewDidTriggerRefresh:(AGJTableView *)AGJTableView
{
    self.tableView.frame = CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 60);
    //该delegate，一般的应用场景是做一个api请求，如：[self.searchApi requestAsync];
    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 以下这步其实真实的应用场景是在请求结束: - (void)api:(id)api didFinishWithResponse:(BIFURLResponse *)response reformedData:(id)result 调用
        weakSelf.tableView.pullTableIsRefreshing = NO;
    });
}

#pragma mark - getter
- (AGJTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[AGJTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.pullDelegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

@end
