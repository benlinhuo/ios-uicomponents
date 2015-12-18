//
//  BezierPathAnimation.h
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/16.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BezierPathAnimation : UIView

- (instancetype)initWithPosition:(CGPoint)position;
- (void)configWithSelector:(SEL)selector;
- (void)animationEventTypeOne;
- (void)animationEventTypeTwo;

@end
