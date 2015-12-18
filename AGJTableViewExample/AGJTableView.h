//
//  AGJTableView.h
//  Angejia
//
//  Created by benlinhuo on 15/12/16.
//  Copyright © 2015年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFSErrorMessageView.h"

@class AGJTableView;
@protocol AGJTableViewDelegate <NSObject>

@optional
- (void)AGJTableViewDidTriggerRefresh:(AGJTableView *)AGJTableView;

@end

@interface AGJTableView : UITableView

@property (nonatomic, weak) id<AGJTableViewDelegate> pullDelegate;

/**
 * 由调用者决定啥时候隐藏“加载中”
 */
@property (nonatomic, assign) BOOL pullTableIsRefreshing;

@property (nonatomic, strong, readonly) BFSErrorMessageView *errorView;

- (void)showMessageType:(BFSErrorMessageType)type target:(id)target action:(SEL)action;
- (void)showMessageType:(BFSErrorMessageType)type target:(id)target action:(SEL)action withMessage:(NSString *)sMsg;
- (void)showMessageTitle:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action;
- (void)showMessageTitle:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action topMargin:(CGFloat)topMargin;
- (void)showMessageTitle:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action highLightButton:(BOOL)showHighLightButton highLightButtonText:(NSString *)text;
- (void)cleanMessage;

@end
