//
//  AGJLandscapeScrollView.h
//  Angejia
//
//  Created by benlinhuo on 16/3/2.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGJLandscapeScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
- (instancetype)initWithViews:(NSArray *)views frame:(CGRect)frame params:(NSDictionary *)params;

@end
