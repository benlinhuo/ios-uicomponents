//
//  BFSFilterTableViewCell.m
//  iFangBroker
//
//  Created by wysasun on 14/12/16.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "BFSFilterTableViewCell.h"
#import "UIColor+BFS.h"

static const uint  FILTER_TABLEVIEW_CELL_COLOR  = 0x3EA0DD;

@implementation BFSFilterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _filterTableViewCellStyle = nil;
    
    return self;
}

- (void)setFilterTableViewCellStyle:(NSMutableDictionary*) cellStyle
{
    _filterTableViewCellStyle = cellStyle;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [self setSelectStyle];
    } else {
        [self setNormalStyle];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [self setSelectStyle];
    } else {
        [self setNormalStyle];
    }
}

- (void)setNormalStyle
{
    self.contentView.backgroundColor = self.backgroundColor;
    self.textLabel.textColor = [UIColor grayColor];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    if(_filterTableViewCellStyle != nil) {
        id value = [_filterTableViewCellStyle objectForKey:@"CellLabelTextColor"];
        if(value != nil) {
            uint color = [value intValue];
            self.textLabel.textColor = [UIColor colorWithHex:color alpha:1.0];
        } else {
            self.textLabel.textColor = [UIColor grayColor];
        }
        
    } else {
        self.textLabel.textColor = [UIColor grayColor];
    }
}

- (void) setSelectStyle
{
    if(_filterTableViewCellStyle != nil) {
        id value = [_filterTableViewCellStyle objectForKey:@"CellLabelSelectTextColor"];
        if(value != nil) {
            uint color = [value intValue];
            self.textLabel.highlightedTextColor = [UIColor colorWithHex:color alpha:1.0];
        } else {
            self.textLabel.highlightedTextColor = [UIColor colorWithHex:FILTER_TABLEVIEW_CELL_COLOR alpha:1.0];
        }
        
    } else {
        self.textLabel.highlightedTextColor = [UIColor colorWithHex:FILTER_TABLEVIEW_CELL_COLOR alpha:1.0];
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
}

@end