//
//  NSIndexPath+BFSFilter.m
//  iFangBroker
//
//  Created by wysasun on 14/12/18.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "NSIndexPath+BFSFilter.h"
#import <objc/runtime.h>

static void *const kLevel = (void*)&kLevel;

@implementation NSIndexPath (BFSFilter)
@dynamic level;

+ (NSIndexPath *)indexPathForRow:(NSInteger)row level:(NSInteger)inLevel
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    indexPath.level = inLevel;
    return indexPath;
}

- (void)setLevel:(NSInteger)inLevel
{
    id subRowObj = [NSNumber numberWithInteger:inLevel];
    id myclass = [self class];
    objc_setAssociatedObject(myclass, kLevel, subRowObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)level
{
    id levelNumber = objc_getAssociatedObject(self, kLevel);
    return [levelNumber integerValue];
}

@end