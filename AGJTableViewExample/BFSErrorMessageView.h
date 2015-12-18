//
//  BFSErrorMessageView.h
//  BIFService
//
//  Created by wysasun on 14/12/3.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BFSErrorMessageType) {
    BFSErrorTypeNoNetWork      = 0,        //无数据提示
    BFSErrorTypeCityNotOpen    = 1 << 0,   //城市服务未开通
    BFSErrorTypeNoData         = 1 << 1    //无网络
};


@interface BFSErrorMessageView : UIView
@property (nonatomic, assign) UIEdgeInsets imageEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;
@property (nonatomic, strong, readonly) UIButton *highLightBtn;

- (void)showInView:(UIView *)view type:(BFSErrorMessageType)type target:(id)target action:(SEL)action;
- (void)showInView:(UIView *)view type:(BFSErrorMessageType)type target:(id)target action:(SEL)action withMsg:(NSString*)sMsg;
- (void)showInView:(UIView *)view title:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action;
- (void)showInView:(UIView *)view title:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action topMargin:(CGFloat)topMargin;
- (void)showInView:(UIView *)view title:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action highLightButton:(BOOL)showHighLightButton highLightButtonText:(NSString *)text;
- (void)dismiss;
- (void)dismissAnimation:(BOOL)animation;

- (NSString *)messageForType:(BFSErrorMessageType)type;
- (UIImage *)imageForType:(BFSErrorMessageType)type;

@end
