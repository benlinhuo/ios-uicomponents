//
//  ChartView.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/12.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import "ChartView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation ChartView
/**
 *
 *
 *  @param frame         整个圆形所占的正方形 frame
 *  @param radianWidth   中心为空的弧形宽度
 *  @param
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame
                  radianWidth:(CGFloat)radianWidth

{
    self = [super initWithFrame:frame];
    if (self) {
        BOOL clockwise = NO; // 不是顺时针
        CGPoint point = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        CGFloat radius = self.frame.size.height * 0.5 - radianWidth / 2;
        CGFloat startAngle = -270.0f;
        CGFloat endAngele = -270.1f;
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:point
                                                                  radius:radius
                                                              startAngle:DEGREES_TO_RADIANS(startAngle)
                                                                endAngle:DEGREES_TO_RADIANS(endAngele)
                                                               clockwise:clockwise];
        
        
    }
    
    return self;
}

@end
