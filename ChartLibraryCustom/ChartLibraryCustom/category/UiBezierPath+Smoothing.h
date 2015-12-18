//
//  UiBezierPath+Smoothing.h
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/12.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Smoothing)
- (UIBezierPath *) smoothedPath: (int) granularity;
- (UIBezierPath*)smoothedPathWithGranularity:(NSInteger)granularity minY:(CGFloat)minY maxY:(CGFloat)maxY;

@end
