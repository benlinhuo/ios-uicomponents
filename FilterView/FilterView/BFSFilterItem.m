//
//  BFSFilterItem.m
//  BIFService
//
//  Created by wysasun on 14/12/9.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "BFSFilterItem.h"

@implementation BFSFilterItem

- (id)init
{
    self = [super init];
    if (self) {
        //init
        self.selectedItems = [NSMutableArray array];
        self.temporarySelectedItems = [NSMutableArray array];
        self.childrenItems = [NSMutableArray array];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    BFSFilterItem *item = [[[self class] allocWithZone:zone] init];
    item.name = self.name;
    item.value = self.value;
    item.allowMultipleSelect = self.allowMultipleSelect;
    item.childrenItems = [self.childrenItems copy];
    item.selectedItems = [NSMutableArray array];
    return item;
}

- (NSArray *)childrenItemsAtIndexes:(NSArray *)indexes
{
    NSMutableArray *array = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [indexes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSNumber class]] && [obj intValue] < self.childrenItems.count) {
            BFSFilterItem *item = self.childrenItems[[obj intValue]];
            item.tag = weakSelf.tag;
            [array addObject:item];
        }
    }];
    return array;
}

/**
 *  细化log信息，方便调试
 *
 *  @return log信息
 */
- (NSString *)description
{
    NSString *description = [super description];
    description = [description stringByAppendingFormat:@" - name:%@ - value:%@", self.name, self.value];
    description = [description stringByAppendingString:@"childrenItems:["];
    for (BFSFilterItem *item in self.childrenItems) {
        [description stringByAppendingString:item.description];
    }
    description = [description stringByAppendingString:@"]"];
    return description;
}

- (void)deleteSelectedInfo
{
    [self.selectedItems enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        BFSFilterItem *item = self.childrenItems[[obj intValue]];
        [item deleteSelectedInfo];
    }];
    [self.selectedItems removeAllObjects];
}

#pragma mark setter
- (void)setTag:(NSInteger)tag
{
    if (_tag <= 0) {
        _tag = tag;
    }
}

@end
