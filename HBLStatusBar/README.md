####简介
这个组件是在 APP 内，模拟苹果系统通知栏接收消息并展示这样的一个交互。如图：
![][https://github.com/benlinhuo/ios-uicomponents/blob/master/HBLStatusBar/images/showImg.png]


####原理简单介绍
创建了一个 UIWindow，上图中消息展示的整个区域都是添加到这个 window 中的(这个 window 的层级设置到我们正常 APP 的层级之上)。这个 window 还添加了 viewController，如下代码：
```javascript
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


// 将需要展示的 UI 添加到这个 window 的 rootViewController 的 view 中
[self.overlayWindow.rootViewController.view addSubview:self.topBar];

```








































