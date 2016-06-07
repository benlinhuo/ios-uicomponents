//
//  HBLStatusBarNotification.h
//  HBLStatusBar
//
//  Created by benlinhuo on 16/6/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBLNotificationView.h"

@interface HBLStatusBarNotification : NSObject


+ (HBLNotificationView *)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image jumpInfo:(NSDictionary *)info;

+ (HBLNotificationView *)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageString:(NSString *)imageString jumpInfo:(NSDictionary *)info;

+ (HBLNotificationView *)showDefaultImageWithTitle:(NSString *)title subTitle:(NSString *)subTitle jumpInfo:(NSDictionary *)info;

@end
