//
//  AGJSegmentButton.h
//  Angejia
//
//  Created by Liulexun on 16/3/31.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGJSegmentButton : UIButton
@property (nonatomic, assign, readonly) BOOL isRedDotShown;
- (void)deSelect;
- (void)showSelect;
- (void)showRedDot;
- (void)hideRedDot;
@end
