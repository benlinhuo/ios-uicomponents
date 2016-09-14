//
//  HBLNavigationBarView.h
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/4.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@protocol HBLNavigationBarViewDelegate  <NSObject>

- (void)doBack;

@end

@interface HBLNavigationBarView : UIView

@property (nonatomic, weak) id<HBLNavigationBarViewDelegate> delegate;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView scrollHeight:(CGFloat)height;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
