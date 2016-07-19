//
//  UIView+Line.h
//  Angejia
//
//  Created by wysasun on 15/2/11.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AGJLineAlignment){
    AGJLineAlignmentBottom = 0,
    AGJLineAlignmentTop = 1,
    AGJLineAlignmentLeft = 2,
    AGJLineAlignmentRight = 3,
};

@interface UIView (Line)
- (void)changeToLineWithLineAlignment:(AGJLineAlignment)alignment;
- (UIView *)addTopLine;//顶部加线条
- (UIView *)addBottomLine;//底部加线条
- (void)addTopLineWithColor:(UIColor *)color;
- (void)addBottomLineWithColor:(UIColor *)color;
- (UIImageView *)addArrowRight;
- (void)addErrorLayer;
- (void)removeErrorLayer;

@end
