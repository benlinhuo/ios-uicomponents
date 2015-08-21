//
//  BFSFilterTableViewCell.h
//  iFangBroker
//
//  Created by wysasun on 14/12/16.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFSFilterTableViewCell : UITableViewCell

@property (nonatomic, retain) NSMutableDictionary *filterTableViewCellStyle;


/**
 *
 * @param cellStyle
 * 
 * key: CellLabelTextColor, value: [NSNumber numberWithInt]
 * key: CellLabelSelectTextColor, value: [NSNumber numberWithInt]
 *
 */
- (void)setFilterTableViewCellStyle:(NSMutableDictionary*) cellStyle;

@end
