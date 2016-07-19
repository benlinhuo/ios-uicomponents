//
//  AGJSegmentView.h
//  Angejia
//
//  Created by Liulexun on 15/12/16.
//  Copyright © 2015年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IndexChangeBlock)(NSInteger index, BOOL isRedDot);

@interface AGJSegmentView : UIView
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
- (void)setSelectedSegmentIndex:(NSInteger)index;
- (void)setSlidViewLeft:(CGFloat)left;


@end
