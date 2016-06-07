//
//  HBLStatusBarNotification.m
//  HBLStatusBar
//
//  Created by benlinhuo on 16/6/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLStatusBarNotification.h"
#import "UIView+BFS.h"

@interface HBLStatusBarNotificationViewController : UIViewController

@end


// Use a custom view controller, so the statusBarStyle doesn't change
@implementation HBLStatusBarNotificationViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [UIApplication sharedApplication].statusBarStyle;
}

@end

@interface HBLStatusBarNotification ()

@property (nonatomic, strong, readonly) UIWindow *overlayWindow;
@property (nonatomic, strong, readonly) HBLNotificationView *topBar;

@property (nonatomic, strong) NSTimer *dismissTimer;

@end


@implementation HBLStatusBarNotification

@synthesize overlayWindow = _overlayWindow;
@synthesize topBar = _topBar;


+ (HBLStatusBarNotification*)sharedInstance {
    static dispatch_once_t once;
    static HBLStatusBarNotification *sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[HBLStatusBarNotification alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(notificationViewDidRemovedFromSuperView) name:HBLNotificationNotificationViewDidRemovedFromSuperView object:nil];
    });
    return sharedInstance;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (UIWindow *)overlayWindow;
{
    if(_overlayWindow == nil) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.height = HBLNotificationViewStatusBarHeight;
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.userInteractionEnabled = YES;
        _overlayWindow.windowLevel = UIWindowLevelStatusBar;
        _overlayWindow.rootViewController = [[HBLStatusBarNotificationViewController alloc] init];
        _overlayWindow.rootViewController.view.backgroundColor = [UIColor clearColor];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000 // only when deployment target is < ios7
        _overlayWindow.rootViewController.wantsFullScreenLayout = YES;
#endif
    }
    return _overlayWindow;
}


- (HBLNotificationView *)topBar;
{
    if(_topBar == nil) {
        _topBar = [HBLNotificationView loadFromXibIfViewAtLastIndex];
#define TAG_TOPVIEW 45
        _topBar.width = self.overlayWindow.rootViewController.view.width;
        _topBar.tag = TAG_TOPVIEW;
    }
    
    return _topBar;
}


+ (HBLNotificationView *)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image jumpInfo:(NSDictionary *)info
{
    // create & show window
    HBLNotificationView *view = [[self sharedInstance] showWithTitle:title subTitle:subTitle image:image imageString:nil jumpInfo:info];
    return view;
}

+ (HBLNotificationView *)showDefaultImageWithTitle:(NSString *)title subTitle:(NSString *)subTitle jumpInfo:(NSDictionary *)info
{
    // create & show window
    UIImage *image = [UIImage imageNamed:@"bg_bwzf_pre"];
    HBLNotificationView *view = [[self sharedInstance] showWithTitle:title subTitle:subTitle image:image imageString:nil jumpInfo:info];
    return view;
}

+ (HBLNotificationView *)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageString:(NSString *)imageString jumpInfo:(NSDictionary *)info
{
    // create & show window
    HBLNotificationView *view = [[self sharedInstance] showWithTitle:title subTitle:subTitle image:nil imageString:imageString jumpInfo:info];
    return view;
}

- (HBLNotificationView *)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image imageString:(NSString *)imageString  jumpInfo:(NSDictionary *)info
{
    
    [self.overlayWindow setHidden:NO];
    if (!_topBar) {
        [self.overlayWindow.rootViewController.view addSubview:self.topBar];
        self.topBar.bottom = 0;
    }
    
    _overlayWindow.userInteractionEnabled = YES;
    if (image) {
        [self.topBar showWithTitle:title subTitle:subTitle image:image jumpInfo:info];
    } else if (imageString){
        [self.topBar showWithTitle:title subTitle:subTitle imageString:imageString jumpInfo:info];
    } else {
        [self.topBar showWithTitle:title subTitle:subTitle imageString:nil jumpInfo:info];
    }
    
    //超时隐藏
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(dismissAnimated) target:self argument:nil];
    
    [self setDismissTimerWithInterval:8.0f];
    
    return self.topBar;
}


- (void)setDismissTimerWithInterval:(NSTimeInterval)interval;
{
    [self.dismissTimer invalidate];
    self.dismissTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]
                                                 interval:interval target:self selector:@selector(dismissAnimated) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.dismissTimer forMode:NSRunLoopCommonModes];
}

+ (void)dismiss;
{
    [[HBLStatusBarNotification sharedInstance] dismissAnimated];
}

- (void)dismissAnimated;
{
    [self.topBar hideSelfWithAnimation];
}

-(void)notificationViewDidRemovedFromSuperView{
    [self.overlayWindow setHidden:YES];
    [_topBar removeFromSuperview];
    _overlayWindow.userInteractionEnabled = NO;
    _topBar = nil;
}

@end
