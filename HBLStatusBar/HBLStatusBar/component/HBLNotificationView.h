//
//  HBLNotificationView.h
//  HBLStatusBar
//
//  Created by benlinhuo on 16/6/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const HBLNotificationNotificationViewDidRemovedFromSuperView = @"com.hbl.common.notificationview.NotificationViewDidRemovedFromSuperView";

static NSString *const HBLJumpWithChatMessageIdentifer = @"com.hbl.member.chatMessage.jump";

static const CGFloat HBLNotificationViewStatusBarHeight = 78.f;

typedef NS_ENUM(NSUInteger, HBLJumpType) {
    HBLJumpTypeOne = 3,
    HBLJumpTypeTwo,
    HBLJumpTypeThree, 
};

@interface HBLNotificationView : UIView

- (void)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image jumpInfo:(NSDictionary *)info;
- (void)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageString:(NSString *)imageString jumpInfo:(NSDictionary *)info;

- (void)hideSelfWithAnimation;

+ (id)loadFromXibIfViewAtLastIndex;

@end
