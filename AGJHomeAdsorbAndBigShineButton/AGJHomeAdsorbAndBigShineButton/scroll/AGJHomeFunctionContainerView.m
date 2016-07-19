//
//  AGJHomeFunctionScrollView.m
//  Angejia
//
//  Created by Liulexun on 16/4/26.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJHomeFunctionContainerView.h"
#import "UIView+Line.h"
#import "AGJUI.h"
#import "AGJSegmentButton.h"
#import "AGJEnvironmentConfigure.h"

@interface AGJHomeFunctionContainerView ()

@end

@implementation AGJHomeFunctionContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor agjBgPageColor];
    
    AGJSegmentView *segmentView = self.segmentView;
    [self addSubview:segmentView];
}

- (void)showVisitRedDot
{
    if (self.segmentView.selectedIndex != 1) {
        AGJSegmentButton *visitButton = self.segmentView.buttonsArray[1];
        [visitButton showRedDot];
    }
}

- (void)setVisitIndex
{
    [self.segmentView setSelectedSegmentIndex:1];
}

- (AGJSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [[AGJSegmentView alloc] initWithFrame:CGRectMake(0, toolViewHeight + graySpaceHeight, SCREEN_WIDTH, segmentViewHeight) titles:[self titles]];
    }
    return _segmentView;
}

- (NSArray *)titles
{
    return @[@"需求找房", @"我的看房", @"我的交易"];
}

+ (CGFloat)viewHeight
{
    return toolViewHeight + graySpaceHeight + segmentViewHeight;
}

@end
