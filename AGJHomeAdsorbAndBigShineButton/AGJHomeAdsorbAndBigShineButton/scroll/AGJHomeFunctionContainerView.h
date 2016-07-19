//
//  AGJHomeFunctionScrollView.h
//  Angejia
//
//  Created by Liulexun on 16/4/26.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGJSegmentView.h"

const static CGFloat toolViewHeight = 113;
const static CGFloat segmentViewHeight = 40;
const static CGFloat graySpaceHeight = 10;


@interface AGJHomeFunctionContainerView : UIView
@property (nonatomic, strong) AGJSegmentView *segmentView;//tab切换

- (void)showVisitRedDot;//显示带看红点
- (void)setVisitIndex;//切到带看的tab
//高度
+ (CGFloat)viewHeight;
@end
