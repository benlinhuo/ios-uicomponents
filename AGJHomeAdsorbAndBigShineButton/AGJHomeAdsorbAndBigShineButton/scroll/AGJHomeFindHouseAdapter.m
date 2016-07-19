//
//  AGJHomeFindHouseAdapter.m
//  Angejia
//
//  Created by Liulexun on 16/4/27.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJHomeFindHouseAdapter.h"


@implementation AGJHomeFindHouseAdapter

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
    cell.detailTextLabel.text = @"详细内容111";
    cell.textLabel.font = [UIFont boldSystemFontOfSize:40.0f];
    
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(findHouseTableViewDidScrollView:)]) {
        [self.delegate findHouseTableViewDidScrollView:scrollView];
    }
}

@end
