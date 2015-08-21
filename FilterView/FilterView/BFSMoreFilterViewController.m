//
//  BFSMoreFilterViewController.m
//  iFangBroker
//
//  Created by wysasun on 14/12/20.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "BFSMoreFilterViewController.h"
#import "NSIndexPath+BFSFilter.h"
#import "UIView+BFS.h"
#import "BFSMacros.h"
#import "BFSFilterView.h"
#import "UIImage+BFS.h"
#import "UIColor+BFS.h"
#import "UIButton+BFSStyle.h"
#import "UILabel+BFSStyle.h"

static const NSInteger TAGOFFSET = 100;
static const CGFloat MoreFilterViewBottomHeight = 50;

@interface BFSMoreFilterViewController ()

@property (nonatomic, strong) UIScrollView *scrollview;

@end

@implementation BFSMoreFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x3EA0DD alpha:1.0]
                                                                           cornerRadius:0]
                                                  forBarMetrics:UIBarMetricsDefault];
    NSDictionary * dict = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                            NSFontAttributeName:[UIFont systemFontOfSize:20]
                            };
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"更多筛选";
    
    [self addCloseButtonItem];
    [self addScrollview];
    [self layoutWithFilterItem];
    [self addConfirmButton];
}

- (void)addScrollview
{
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - MoreFilterViewBottomHeight)];
    [self.view addSubview:_scrollview];
}

- (void)addConfirmButton
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - MoreFilterViewBottomHeight, self.view.width + 2, MoreFilterViewBottomHeight + 2)];
    bottomView.backgroundColor = [UIColor colorWithHex:0xEFEFF4 alpha:1.0];
    bottomView.centerX = self.view.width/2;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomView.width, 1)];
    lineView.backgroundColor = [UIColor colorWithHex:0xC3C3C5 alpha:1.0];
    [bottomView addSubview:lineView];
    
    //addbutton
    UIButton *button = [UIButton buttonNomalColor:[UIColor colorWithHex:0x3EA0DD alpha:1.0]
                                   highLightColor:[UIColor colorWithHex:0x2A6082 alpha:1.0]
                                         coRadius:2.0];
    [button setTitle:@"确定" titleFont:[UIFont systemFontOfSize:16] titleColor:[UIColor whiteColor]];
    button.frame = CGRectMake(0, 0, bottomView.width - 30, bottomView.height - 10);
    button.centerX = bottomView.width / 2;
    button.centerY = bottomView.height / 2;
    [button addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    [self.view addSubview:bottomView];
}

- (void)addCloseButtonItem
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain
                                                                target:self action:@selector(close:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)close:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [self.filterItems enumerateObjectsUsingBlock:^(BFSFilterItem *item, NSUInteger idx, BOOL *stop) {
            [item.temporarySelectedItems removeAllObjects];
        }];
    }];
}

- (void)confirm:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //前面的数个item返回的状态为NO，最后一个为YES
        __block BFSFilterItem *lastItem = nil;
        NSMutableArray *selectedItems = [NSMutableArray array];
        [self.filterItems enumerateObjectsUsingBlock:^(BFSFilterItem *item, NSUInteger idx, BOOL *stop) {
            [item.selectedItems removeAllObjects];
            [item.selectedItems addObjectsFromArray:item.temporarySelectedItems];
            [item.temporarySelectedItems removeAllObjects];
            if (lastItem.selectedBlock) {
                lastItem.selectedBlock(nil,[lastItem childrenItemsAtIndexes:lastItem.selectedItems], NO);
            }
            [selectedItems addObjectsFromArray:[lastItem childrenItemsAtIndexes:lastItem.selectedItems]];
            lastItem = item;
        }];
        if (lastItem.selectedBlock) {
            lastItem.selectedBlock(nil,[lastItem childrenItemsAtIndexes:lastItem.selectedItems], YES);
        }
        [selectedItems addObjectsFromArray:[lastItem childrenItemsAtIndexes:lastItem.selectedItems]];
        if (self.filterView && self.filterView.delegate) {
            int row = 0;
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:row level:1];
            [self.filterView.delegate filterView:self.filterView didSelectedItems:selectedItems atIndexPath:selectedIndexPath];
        }
    }];
}

- (void)layoutWithFilterItem
{
    __block CGFloat height = 0;
    CGFloat xOffset = 15;
    [self.filterItems enumerateObjectsUsingBlock:^(BFSFilterItem *item, NSUInteger idx, BOOL *stop) {
        [item.temporarySelectedItems addObjectsFromArray:item.selectedItems];
        if (height != 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(xOffset, height, BFS_ScreenWidth, 1)];
            line.backgroundColor = [UIColor colorWithHex:0xDEDEE2 alpha:1.0];
            [_scrollview addSubview:line];
        }
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, height + 15, 200, 14)];
        [title setFont:[UIFont systemFontOfSize:14] withColor:[UIColor colorWithHex:0x5F646E alpha:1.0]];
        [_scrollview addSubview:title];
        
        if (item.allowMultipleSelect) {
            [title setText:[NSString stringWithFormat:@"%@(可多选)", item.name]];
            __block CGFloat width = xOffset;
            height = title.bottom + 15;
            [item.childrenItems enumerateObjectsUsingBlock:^(BFSFilterItem *subItem, NSUInteger subIdx, BOOL *stop) {
                UIButton *mutipleButton = [UIButton buttonTextColor:[UIColor colorWithHex:0x999999 alpha:1.0] cordius:4.0 boderWidth:1.0];
                mutipleButton.tag = idx * TAGOFFSET + subIdx + 1;
                [mutipleButton setTitle:[NSString stringWithFormat:@"  %@  ", subItem.name] titleFont:[UIFont systemFontOfSize:14] titleColor:[UIColor colorWithHex:0x999999 alpha:1.0]];
                [mutipleButton sizeToFit];
                [_scrollview addSubview:mutipleButton];
                
                if ([item.temporarySelectedItems containsObject:[NSNumber numberWithInt:(int)subIdx]]) {
                    [mutipleButton setTextColor:[UIColor colorWithHex:0x3EA0DD alpha:1.0] boderWidth:1.0];
                } else {
                    [mutipleButton setTextColor:[UIColor colorWithHex:0x999999 alpha:1.0] boderWidth:1.0];
                }
                if (width + mutipleButton.width + 10> BFS_ScreenWidth - xOffset) {
                    width = xOffset;
                    height += 40;
                }
                [mutipleButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                mutipleButton.top = height;
                mutipleButton.left = width;
                width += mutipleButton.width + 10;
                if (subIdx == item.childrenItems.count - 1) {
                    height += 40;
                }
            }];
        } else {
            [title setText:item.name];
            NSArray *names = [item.childrenItems valueForKeyPath:@"@unionOfObjects.name"];
            UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:names];
            control.tintColor = [UIColor colorWithHex:0x3EA0DD alpha:1.0];
            control.tag = idx * TAGOFFSET + 1;
            [control addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
            [_scrollview addSubview:control];
            control.left = xOffset;
            control.top = title.bottom + 15;
            height = control.bottom + 15;
            if (item.selectedItems.count){
                control.selectedSegmentIndex = [item.selectedItems[0] integerValue];
            } else {
                control.selectedSegmentIndex = 0;
            }
        }
    }];
    self.scrollview.contentSize = CGSizeMake(0, MIN(self.view.height, height));
}

- (void)buttonClicked:(UIButton *)sender
{
    NSInteger index = sender.tag/TAGOFFSET;
    BFSFilterItem *item = self.filterItems[index];
    
    if (![item.temporarySelectedItems containsObject:[NSNumber numberWithInt:sender.tag%TAGOFFSET - 1]]) {
        [sender setTextColor:[UIColor colorWithHex:0x3EA0DD alpha:1.0] boderWidth:1.0];
        [item.temporarySelectedItems addObject:[NSNumber numberWithInt:sender.tag % TAGOFFSET - 1]];
    } else {
        [sender setTextColor:[UIColor colorWithHex:0x999999 alpha:1.0] boderWidth:1.0];
        [item.temporarySelectedItems removeObject:[NSNumber numberWithInt:sender.tag % TAGOFFSET - 1]];
    }
}

- (void)valueChanged:(UISegmentedControl *)sender
{
    NSInteger index = sender.tag/TAGOFFSET;
    BFSFilterItem *item = self.filterItems[index];
    [item.temporarySelectedItems removeAllObjects];
    [item.temporarySelectedItems addObject:[NSNumber numberWithInteger:sender.selectedSegmentIndex]];
}

@end
