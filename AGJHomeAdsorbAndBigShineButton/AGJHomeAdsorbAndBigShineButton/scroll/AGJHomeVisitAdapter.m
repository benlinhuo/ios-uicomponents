//
//  AGJHomeVisitAdapter.m
//  Angejia
//
//  Created by Liulexun on 16/4/28.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJHomeVisitAdapter.h"


@implementation AGJHomeVisitAdapter

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
    cell.detailTextLabel.text = @"详细内容22222";
    cell.textLabel.font = [UIFont boldSystemFontOfSize:40.0f];
    
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(visitTableViewDidScrollView:)]) {
        [self.delegate visitTableViewDidScrollView:scrollView];
    }
}

@end
