//
//  AGJHomeTradeAdapter.m
//  Angejia
//
//  Created by Liulexun on 16/5/13.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJHomeTradeAdapter.h"

@implementation AGJHomeTradeAdapter

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"homefindhouseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifer];
    }
    cell.detailTextLabel.text = @"详细内容3333";
    cell.textLabel.font = [UIFont boldSystemFontOfSize:40.0f];
    
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tradeTableViewdidScroll:)]) {
        [self.delegate tradeTableViewdidScroll:scrollView];
    }
}



@end
