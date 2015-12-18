//
//  SparkCircleView.h
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/14.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SparkCircleView : UIView

@property (nonatomic, assign) CGFloat duration;

- (instancetype)initWithFrame:(CGRect)frame
                  strokeWidth:(CGFloat)strokeWidth
                  radianWidth:(CGFloat)radianWidth;

@end
