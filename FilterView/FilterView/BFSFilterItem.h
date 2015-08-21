//
//  BFSFilterItem.h
//  BIFService
//
//  Created by wysasun on 14/12/9.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "BIFObject.h"
#import "NSIndexPath+BFSFilter.h"

@class BFSFilterItem;

/**
 *  三种情况下会触发该block: 1.用户点击filter列表中的选项
 *                        2.filter view的updateUIWithForest初始方法
 *                        3.更多筛选页面确认返回
 *
 *  @param NSIndexPath   参见NSIndexPath (BFSFilter)，包括层级level和选中的index row属性
 *  @param NSArray       选中的items,针对多选的情况里面的全部都是选项，单选类型取第一个
 *  @param BOOL          该点击是否应该生效，应该处理为YES，其他情况通常为NO，用户的一个操作可能触发一系列的FilterItem,但只
 *                       有一个会为YES
 *                       可以根据该返回值进行分别处理，如：YES时对查询条件进行修改，并且进行实际查询；返回NO时只对查询条件做修
 *                       改
 */
typedef void(^SelectedBlock)(NSIndexPath *, NSArray */* BFSFilterItem */, BOOL);

@interface BFSFilterItem : BIFObject
@property (nonatomic, copy) NSString *name;//item对应的名字，用于筛选视图显示
@property (nonatomic, copy) NSString *value;//item对应的值，用于查询
@property (nonatomic, copy) NSString *otherName; //item对应其他名称
@property (nonatomic, copy) NSString *otherValue; //item对应的其他值

@property (nonatomic, assign) NSInteger tag;//标示一个item的字段
@property (nonatomic, strong) NSMutableArray *childrenItems;//子item列表
@property (nonatomic, strong) NSMutableArray *selectedItems; //当前item中子列表中选中序号，对于单选item，只取第一个

@property (nonatomic) BOOL allowMultipleSelect;//是否允许多选,只适用于更多页面中,默认NO
@property (nonatomic, strong) NSMutableArray *temporarySelectedItems;//只适用于更多页面中
@property (nonatomic, strong) SelectedBlock selectedBlock;

/**
 *  根据indexs返回对应的items
 *
 *  @param indexes
 *
 *  @return 对应的items
 */
- (NSArray *)childrenItemsAtIndexes:(NSArray *)indexes;

/**
 *  删除item的选中状态
 */
- (void)deleteSelectedInfo;

@end
