//
//  UIColor+BFS.h
//  BIFService
//
//  Created by wysasun on 14/12/3.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BFS)

+ (UIColor *)colorWithHex:(uint) hex alpha:(CGFloat)alpha;
+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
