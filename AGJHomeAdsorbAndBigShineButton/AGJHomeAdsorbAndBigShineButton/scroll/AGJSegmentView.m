//
//  AGJSegmentView.m
//  Angejia
//
//  Created by Liulexun on 15/12/16.
//  Copyright © 2015年 Plan B Inc. All rights reserved.
//

#import "AGJSegmentView.h"
#import "UIColor+AngejiaStyle.h"
#import "UIFont+AngejiaStyle.h"
#import "AGJSegmentButton.h"
#import "UIView+BFS.h"

static CGFloat slidViewHeight = 3;

@interface AGJSegmentView ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIView *slidView;
@property (nonatomic, assign) CGFloat slidViewWidth;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@end

@implementation AGJSegmentView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titles = titles;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    for (NSInteger i = 0; i < self.titles.count; i++) {
        AGJSegmentButton *button  = [[AGJSegmentButton alloc] initWithFrame:CGRectMake(self.slidViewWidth * i, 0, self.slidViewWidth, self.height - slidViewHeight)];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            [button showSelect];
        }
        [self.buttonsArray addObject:button];
    }
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    bottomLine.backgroundColor = [UIColor angejiaBackgroundColor];
    [self addSubview:bottomLine];
    
    UIView *slidView = self.slidView;
    [self addSubview:slidView];
}

- (void)buttonTouched:(AGJSegmentButton *)button
{
    NSInteger index = button.tag - 100;
    [self setSelectedSegmentIndex:index];
}

- (void)setSlidViewLeft:(CGFloat)left
{
    self.slidView.left = left;
}

- (void)setSelectedSegmentIndex:(NSInteger)index
{
    self.selectedIndex = index;
//    self.slidView.centerX = self.slidViewWidth / 2 + self.slidViewWidth * index;
    BOOL isRedDot = NO;
    if (index < self.buttonsArray.count) {
        for (NSInteger i = 0; i < self.buttonsArray.count; i++) {
            AGJSegmentButton *button = self.buttonsArray[i];
            if (i == index) {
                if (button.isRedDotShown) {
                    isRedDot = YES;
                }
                [button showSelect];
            } else {
                [button deSelect];
            }
        }
        if (self.indexChangeBlock) {
            self.indexChangeBlock(index, isRedDot);
        }
    }
}

- (UIView *)slidView
{
    if (!_slidView) {
        _slidView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - slidViewHeight - 0.5, self.slidViewWidth, slidViewHeight)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, slidViewHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"pic_tab_home.imageset"];
        [_slidView addSubview:imageView];
        imageView.centerX = self.slidViewWidth / 2;
    }
    return _slidView;
}

- (CGFloat)slidViewWidth
{
    if (self.titles.count == 0) {
        return self.width;
    }
    if (!_slidViewWidth) {
        _slidViewWidth = self.width / self.titles.count;
    }
    return _slidViewWidth;
}

- (NSMutableArray *)buttonsArray
{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}
@end
