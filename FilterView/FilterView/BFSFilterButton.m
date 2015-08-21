//
//  BFSFilterButton.m
//  iFangBroker
//
//  Created by wysasun on 14/12/16.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "BFSFilterButton.h"
#import "NSString+BFSSizeWithFont.h"
#import "UIColor+BFS.h"
#import "UIView+BFS.h"

@interface BFSFilterButton ()

@property (nonatomic, strong) UIView *separator;

@property (nonatomic, strong) NSArray * vContraintForSeparator;

@property (nonatomic)  CGFloat  separatorTopMargin;

@property (nonatomic)  CGFloat  separatorBottomMargin;

@end

static const CGFloat BFSFilterButtonPadding = 2;
static const CGFloat BFSFilterSeparatorMargin = 8; // default value for separtor margin

@implementation BFSFilterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.separatorTopMargin = BFSFilterSeparatorMargin;
        self.separatorBottomMargin = BFSFilterSeparatorMargin;
        
        self.unfolded = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor colorWithHex:0x5F646E alpha:1.0] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithHex:0xF7F7F7 alpha:1]];
        [self addSeparator];
    }
    return self;
}

- (void)addSeparator
{
    if (!_separator) {
        _separator = [UIView new];
        _separator.backgroundColor = [UIColor colorWithHex:0xDEDEE2 alpha:1.0];
        _separator.translatesAutoresizingMaskIntoConstraints = NO;
    }
    if (!_separator.superview) {
        [self addSubview:_separator];
        
        [self setSeparatorMarginForTop:_separatorTopMargin andBottom:_separatorBottomMargin];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_separator(1)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_separator)]];
    }
}

- (void)showSeparator:(BOOL)show
{
    self.separator.hidden = !show;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGFloat imageWidth = self.imageView.width;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - BFSFilterButtonPadding/2, 0, imageWidth + BFSFilterButtonPadding/2);
}

- (void)layoutSubviews
{
    CGFloat titleWidth = ceilf(self.titleLabel.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + BFSFilterButtonPadding/2, 0, -titleWidth - BFSFilterButtonPadding/2);
    [super layoutSubviews];
}

- (void)setUnfolded:(BOOL)unfolded
{
    if (!unfolded) {
        [self setImage:[UIImage imageNamed:@"client_icon_downarrow"] forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:@"client_icon_uparrow"] forState:UIControlStateNormal];
    }
    _unfolded = unfolded;
}


- (void)setSeparatorMarginForTop: (CGFloat) top andBottom:(CGFloat)bottom
{
    if (_vContraintForSeparator) {
        [self removeConstraints: _vContraintForSeparator];
        _vContraintForSeparator = nil;
    }
    
    if (top >= 0.0f) {
        _separatorTopMargin = top;
    }
    
    if (bottom >=0.0f) {
        _separatorBottomMargin = bottom;
    }
    
    NSString * format = [self getVConstraintFormatForSeparator: _separatorTopMargin : _separatorBottomMargin ];
    _vContraintForSeparator = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:NSDictionaryOfVariableBindings(_separator)];
    
    [self addConstraints: _vContraintForSeparator];
}

- (NSString *) getVConstraintFormatForSeparator: (CGFloat) top :(CGFloat)bottom
{
    NSString *format = [NSString stringWithFormat:@"V:|-%f-[_separator]-%f-|" , top, bottom ];
    
    return format;
}

@end
