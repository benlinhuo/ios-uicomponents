//
//  ChartDotView.h
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/12.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartDotView : UIControl

@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *centerColor;

@property (nonatomic, readonly) NSDictionary *info;

- (void)configWithData:(NSDictionary *)data;

@end
