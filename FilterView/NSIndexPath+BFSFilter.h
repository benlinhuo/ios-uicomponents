//
//  NSIndexPath+BFSFilter.h
//  iFangBroker
//
//  Created by wysasun on 14/12/18.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (BFSFilter)
/**
 *  创建filter相对的indexpath
 *
 *  @param row 对应filtertableview中的一行
 *  @param level 对应filtertableview中的层次(目前总共两层)
 *
 *  @return 对应filtertableview中的一个cell的位置坐标
 */
//TODO: 如果以后filtertableview中一个层次中的tableview还要分section，需要相应处理
+ (NSIndexPath *)indexPathForRow:(NSInteger)row level:(NSInteger)level;

/**
 *  filtertableview中的层次,详见BFSFilterTableViewStyle
 */
@property (nonatomic, assign) NSInteger level;
@end