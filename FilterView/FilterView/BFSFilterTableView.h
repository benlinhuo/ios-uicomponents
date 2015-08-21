//
//  BFSFilterTableView.h
//  BIFService
//
//  Created by wysasun on 14/12/12.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFSFilterItem.h"

/**
 *  用于展示筛选项的tableview的类型
 */
typedef NS_ENUM(NSUInteger, BFSFilterTableViewStyle){
    /**
     *  灰色背景，用于筛选第一层的tableview
     */
    BFSFilterTableViewStylePrevious,
    /**
     *  普通的白底，有分隔线的tableview
     */
    BFSFilterTableViewStyleNormal,
};

@interface BFSFilterTableView : UITableView
@property (nonatomic, strong) BFSFilterItem *filterItem;
@property (nonatomic, strong) BFSFilterTableView *childTableView;
@property (nonatomic, weak) BFSFilterTableView *parentTableView;
@property (nonatomic) BOOL showChildTableView;
@property (nonatomic, strong) SelectedBlock selectedBlock;

- (instancetype)initWithFilterTableViewStyle:(BFSFilterTableViewStyle)filterTableViewStyle;

- (void)setFilterTableViewCellStyle:(NSMutableDictionary*) cellStyle;

@end
