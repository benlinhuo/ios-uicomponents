//
//  AGJHomeGuidView.h
//  AGJHomeAdsorbAndBigShineButton
//
//  Created by benlinhuo on 16/7/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGJLayerAnimationView.h"

@protocol AGJHomeGuidViewDelegate <NSObject>
@optional
- (void)didHelpmeButtonTouched;

@end

@interface AGJHomeGuidView : UIView
//@property (nonatomic, strong) UIButton *selfButton;//自己找房button
@property (nonatomic, strong) AGJLayerAnimationView *animationView;
@property (nonatomic, weak) id <AGJHomeGuidViewDelegate> delegate;
@end

