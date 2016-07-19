//
//  AGJLayerAnimationView.h
//  Angejia
//
//  Created by benlinhuo on 16/7/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGJLayerAnimationView : UIView
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
- (void)beginAnimation;
- (void)stopAnimation;
+ (CGFloat)buttonWidth;
@end
