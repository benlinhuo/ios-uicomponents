//
//  HBLNavigationBarObject.h
//  HBLNavigationBar
//
//  Created by benlinhuo on 16/9/4.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@protocol HBLNavigationBarObjectDelegate  <NSObject>

- (void)doBack;

@end


@interface HBLNavigationBarObject : NSObject

@property (nonatomic, weak) id<HBLNavigationBarObjectDelegate> delegate;

- (instancetype)initWithNaviationController:(UINavigationController *)navController navigationItem:(UINavigationItem *)navItem scrollView:(UIScrollView *)scrollView changeHeight:(CGFloat)height;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)resetNavigationBar;


@end
