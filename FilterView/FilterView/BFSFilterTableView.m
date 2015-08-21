//
//  BFSFilterTableView.m
//  BIFService
//
//  Created by wysasun on 14/12/12.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "BFSFilterTableView.h"
#import "UIColor+BFS.h"
#import "UIView+BFS.h"
#import "BFSFilterTableViewCell.h"
#import "NSIndexPath+BFSFilter.h"

static const CGFloat FILTER_TABLEVIEW_CELL_HEIGHT = 45;
static const uint    FILTER_TABLEVIEW_CELL_COLOR  = 0x3EA0DD;

@interface BFSFilterTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) BFSFilterTableViewStyle filterTableViewStyle;
@property (nonatomic, strong) NSIndexPath *selectedPath;
@property (nonatomic, strong) NSIndexPath *selectedCellPath;
@property (nonatomic, retain) NSMutableDictionary *filterTableViewCellStyle;

@end

@implementation BFSFilterTableView

- (instancetype)initWithFilterTableViewStyle:(BFSFilterTableViewStyle)filterTableViewStyle
{
    self = [super init];
    if (self) {
        _filterTableViewStyle = filterTableViewStyle;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if (filterTableViewStyle == BFSFilterTableViewStylePrevious) {
            self.backgroundColor = [UIColor colorWithHex:0xf1f1f1 alpha:1.0];
        } else if (filterTableViewStyle == BFSFilterTableViewStyleNormal) {
            self.backgroundColor = [UIColor colorWithHex:0xffffff alpha:1.0];
        }
        self.delegate = self;
        self.dataSource = self;
        self.showChildTableView = YES;
        self.tableFooterView = [UIView new];
        _filterTableViewCellStyle = nil;
    }
    return self;
}

- (void)reloadData
{
    [super reloadData];
    if (self.filterItem && self.filterItem.selectedItems.count) {
        // 将当前选择的那行 UITableViewCell 自动滚动到可见的最上面位置（top）
        [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.filterItem.selectedItems[0] intValue] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.filterItem.selectedItems[0] intValue] inSection:0] byUser:NO];
    }
}


- (void)setFilterTableViewCellStyle:(NSMutableDictionary*) cellStyle
{
    _filterTableViewCellStyle = cellStyle;
}


#pragma mark - private methods
- (void)addChildTableView
{
    if (!self.childTableView) {
        BFSFilterTableView *subTableview = [[BFSFilterTableView alloc] initWithFilterTableViewStyle:BFSFilterTableViewStyleNormal];
        self.childTableView = subTableview;
        subTableview.parentTableView = self;
        
        /**
         *  // window.height - windowOirgin.y 是为了防止屏幕较小，所以用我们自己设置的高度，和用屏幕高度减去filterView的高度相比，取较小者
            _filterTableView.frame = CGRectMake(0, 0, self.width, MIN(window.height - windowOirgin.y, _maxTabelViewHeight));
         */
        
        // 也就是层级二的UITableView是其父TableView宽度的7/16. 父TableView 如上设置它的frame了
        CGFloat widthOffset = ceilf(self.width * 7.0f/16.f);
        subTableview.frame = self.bounds;
        subTableview.width = self.width - widthOffset;
        subTableview.left = widthOffset;
        subTableview.top = 0;
        [subTableview setFilterTableViewCellStyle: _filterTableViewCellStyle];
    }
    if (self.superview && !self.childTableView.superview) {
        [self.superview addSubview:self.childTableView];// 子 TableView 在UI层面的层级 同其父UI
    }
    self.childTableView.hidden = NO;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FILTER_TABLEVIEW_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self didSelectRowAtIndexPath:indexPath byUser:YES];
}

//[self didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.filterItem.selectedItems[0] intValue] inSection:0] byUser:NO];
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath byUser:(BOOL)byUser
{
    BFSFilterItem *filterItem = self.filterItem.childrenItems[indexPath.row];
    //当我们有类似于点击“徐汇”，则“徐汇”右侧出现徐汇区的 block信息（即 第二层）
    if (self.showChildTableView && self.filterTableViewStyle == BFSFilterTableViewStylePrevious && filterItem.childrenItems.count > 0){
        //需要弹出第二层的情况
        self.selectedPath = [NSIndexPath indexPathWithIndex:indexPath.row];
        //添加第二层filtertableview
        [self addChildTableView];
        // 子 tableView 的选择block 同上层区域
        self.childTableView.selectedBlock = self.selectedBlock;
        self.childTableView.filterItem = filterItem;
        [self.childTableView reloadData];
    } else if (byUser) {
        //触发点击行为
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row level:(self.filterTableViewStyle + 1)];
        if (self.filterItem.selectedBlock) {
            self.filterItem.selectedBlock(selectedIndexPath, @[self.filterItem.childrenItems[indexPath.row]], YES);
        }
        // 考虑到二层级关系，父TableView 也要更新（好像是三层级关系）
        if (self.parentTableView && self.parentTableView.filterItem.selectedBlock) {
            self.parentTableView.filterItem.selectedBlock(selectedIndexPath, @[self.filterItem.childrenItems[indexPath.row]], YES);
        }
        if (self.selectedBlock) {
            self.selectedBlock(selectedIndexPath, @[self.filterItem.childrenItems[indexPath.row]],YES);
        }
        [self updateItemSelectedItems];
    }
    //add by zxy
    // 表示用户点击选择的与当前正处于选中状态的cell 不是同一个
    if(self.selectedCellPath && self.selectedCellPath.row != indexPath.row)
    {
        // cellForRowAtIndexPath 返回指定的 cell
        UITableViewCell *cell = [self cellForRowAtIndexPath:self.selectedCellPath];
        [cell setSelected:NO animated:NO];// 将之前选择的那个 cell 置为非选中状态
        cell.contentView.backgroundColor=self.backgroundColor;
        cell.backgroundColor = self.backgroundColor;
        self.selectedCellPath = nil;
    }
    self.selectedCellPath = indexPath;
    //add end
    
    // 将当前指定 cell ，置为 选中状态
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:NO];
}

/**
 *  更新selectedItems  选中的Item, 变量更新
 */
- (void)updateItemSelectedItems
{
    BFSFilterItem *item = self.filterItem;
    if (self.filterTableViewStyle == BFSFilterTableViewStyleNormal) {
        item = self.parentTableView.filterItem;
    }
    [item deleteSelectedInfo];
    [self.filterItem.selectedItems removeAllObjects];
    [self.filterItem.selectedItems addObject:[NSNumber numberWithInteger:[self indexPathForSelectedRow].row]];
    if (self.filterTableViewStyle == BFSFilterTableViewStyleNormal) {
        [self.parentTableView.filterItem.selectedItems addObject:[NSNumber numberWithInteger:[self.parentTableView indexPathForSelectedRow].row]];
    }
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filterItem.childrenItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FilterViewCell";
    BFSFilterTableViewCell *cell = [[BFSFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    [cell setFilterTableViewCellStyle:_filterTableViewCellStyle];
    
    BFSFilterItem *filterItem = self.filterItem.childrenItems[indexPath.row];
    cell.textLabel.text = filterItem.name;
    //add by zxy
    BOOL bSelected = NO;
    if(self.selectedCellPath)
    {
        if(self.selectedCellPath.row == indexPath.row)
            bSelected = YES;
    }
    if(bSelected)
    {
        [cell setSelected:YES animated:NO];
//        [cell.textLabel setHighlightedTextColor:[UIColor colorWithHex:0x3EA0DD alpha:1.0]];
        cell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        [cell setSelected:NO animated:NO];
        cell.backgroundColor = self.backgroundColor;
    }
    //    //add end
    return cell;
}

@end
