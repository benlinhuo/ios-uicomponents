###AGJTableView 

#####上拉刷新的原理

其实就是在 UITableView 的上面加一个 headerView （上拉看到的样式，它的位置是负值），然后通过 UIScrollView（UITableView 本身就是继承于 UIScrollView ） 的offset设置位置设置当前是否看到 headerView 。


##### MessageInterceptor

其中用到了一个技术点是 消息动态转发机制：MessageInterceptor（自己写的）。

AGJTableView 继承于 UITableView ，假设我们的ViewController 使用了AGJTableView（关系描述）。这样我们其实在调用 UIScrollViewDelegate 的方法时，默认只有 ViewController 这个类才能调用，但是我们想要把滚动调用 UIScrollViewDelegate 的方法进行的一些操作封装在 AGJTableView 类中（写成一个组件）。这样我们就必须要在 AGJTableView 中调用，所以就对消息转发做了一层变化（即 MessageInterceptor 类内容）
```javascript

1. MessageInterceptor.h 文件
#import <Foundation/Foundation.h>

@interface MessageInterceptor : NSObject

@property (nonatomic, assign) id receiver;
@property (nonatomic, assign) id middleMan;

@end



2. MessageInterceptor.m 文件
#import "MessageInterceptor.h"

@implementation MessageInterceptor
@synthesize receiver;
@synthesize middleMan;

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (middleMan && [middleMan respondsToSelector:aSelector]) { return middleMan; }
    if (receiver && [receiver respondsToSelector:aSelector]) { return receiver; }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if (middleMan && [middleMan respondsToSelector:aSelector]) { return YES; }
    if (receiver && [receiver respondsToSelector:aSelector]) { return YES; }
    return [super respondsToSelector:aSelector];
}

@end
```

可以看到上述代码中有一个方法是：forwardingTargetForSelector。它重写了原来默认的消息转发机制，在默认的消息接收者 ViewController 没有某个方法的时候，它会去调用 forwardingTargetForSelector 这个方法，而该方法内部是会先去调用 middleMan 的该方法，如下代码，可以看到 middleMan 就是 self （即 AGJTableView 自身）。

所以在 ViewController （默认接收者）没有对应方法时，可以去调用 AGJTableView 中的该方法，这样就实现了上述的要求。

```javascript
3. AGJTableView.m 文件部分源码
@implementation AGJTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerView];
        
        _delegateInterceptor = [[MessageInterceptor alloc] init];
        _delegateInterceptor.middleMan = self;
        _delegateInterceptor.receiver = self.delegate;
        super.delegate = (id)_delegateInterceptor;
        
        _pullTableIsRefreshing = NO;
    }
    return self;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if (_delegateInterceptor) {
        super.delegate = nil;
        _delegateInterceptor.receiver = delegate;
        super.delegate = (id)_delegateInterceptor;
    } else {
        super.delegate = delegate;
    }
}
```


还有一点需要说明的是：UIScrollViewDelegate 和 UITableViewDelegate 都有一个属性是 delegate，而UITableView 继承了 UIScrollView 。所以我们在使用 UITableView 的时候，如 ViewController，只要设置 _tableView.delegate = self. 便可以在 ViewController 中，既使用 UIScrollViewDelegate，也可以使用 UITableViewDelegate。因为二者的属性重名了（且二者是继承关系）。


##### 调用”加载中“消失的时机

其实它总共有三个状态，可以见该文件夹下的图：1> 下拉刷新; 2> 松开刷新; 3> 努力加载中。第三个状态啥时候被触发消失呢，比如可以在请求数据的API结束以后，所以这个是由使用这个组件 AGJTableView 的使用者决定的。我们通过一个属性来开启或关闭第三个状态（即只要设置 _tableView.pullTableIsRefreshing = NO 便可以结束第三个状态，回到已经加载过的正常浏览状态）。
```javascript
AGJTalbeView.h文件
/**
 * 由调用者决定啥时候隐藏“加载中”
 */
@property (nonatomic, assign) BOOL pullTableIsRefreshing;




AGJTableView.m文件
- (void)setPullTableIsRefreshing:(BOOL)isRefreshing
{
    // 由非加载中->加载中
    if (isRefreshing) {
        [_headerView startLoadingAnimationWithScrollView:self];
        _pullTableIsRefreshing = YES;
        
    } else if (!isRefreshing) {
        //由 加载中 -> 非加载中
        [_headerView refreshScrollViewDataSourceDidFinishedLoading:self];
        _pullTableIsRefreshing = NO;
    }
}

```


###MJRefresh 实现原理解析
MJRefresh 这个类实现了下拉刷新和上拉刷新的功能。AGJTableView 只实现了下拉刷新的功能。二者实现的原理不同。下面对 MJRefresh 的实现原理做一个分析。
##### MJRefresh 类结构图（官方的）
这个类库，支持只要是 UIScrollView 或者其子类的下拉和上拉刷新功能。下拉和上拉的 view 都是在下面图中的各类来实现。真正把这样的 view 插入到 UIScrollView 中的是 UIScrollView+MJRefresh.h 文件中。

![alt MJRefresh 类结构图][./images/mjrefresh.png] 

##### MJRefresh 下拉刷新原理

在 UIScrollView+MJRefresh.h 文件中，有如下一段代码：
```javascript
- (void)setMj_header:(MJRefreshHeader *)mj_header
{
    if (mj_header != self.mj_header) {
        // 删除旧的，添加新的
        [self.mj_header removeFromSuperview];
        [self insertSubview:mj_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"mj_header"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshHeaderKey,
                                 mj_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_header"]; // KVO
    }
}

1. 把下拉刷新的 view 放置到整个 UIScrollView 的最上面：[self insertSubview:mj_header atIndex:0];
```

接下来就是 MJRefreshHeader 的实现。先从它的父类 MJRefreshComponent 类说起。

当我们在把该 view 添加到 UIScrollView 中的时候，会执行如下方法：
```javascript
// 即将被添加到父视图的时候调用
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 如果不是UIScrollView，不做任何事情
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    // 旧的父控件移除监听
    [self removeObservers];
    
    if (newSuperview) { // 新的父控件
        // 设置宽度
        self.mj_w = newSuperview.mj_w;
        // 设置位置
        self.mj_x = 0;
        
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        /**
         当所有collectionCell的高度和没有占满整个parent container的时候，当下拉的时候都不会触发scrollViewDidScroll。
         所以在创建collectionView的时候添加
         self.collectionView.alwaysBounceVertical = YES;
         这样就解决问题了。
         */
        _scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        // 添加监听
        [self addObservers];
    }
}

- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:MJRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:MJRefreshKeyPathContentSize options:options context:nil];
    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:MJRefreshKeyPathPanState options:options context:nil];
}

该方法做了以下几件事：
1. 设置该 view 的宽度和位置
2. 添加 KVO ，包括的属性有 UIScrollView 的 contentOffset，contentSize。以及 self.scrollView.panGestureRecognizer ，这个主要是为更复杂的手势操作做准备。当这些属性发生变化时，有对应的处理方法。

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}

```

下拉刷新真正的样式变化以及功能变化是在 MJRefresh 类中处理。它在方法 scrollViewContentOffsetDidChange 中，根据手滑动的距离，来判断当前应该是什么状态（state，不同 state）。 state 的 setter 方法中，根据当前是不同 state，展示不同的样式以及不同的交互。
```javascript
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的refreshing状态
    if (self.state == MJRefreshStateRefreshing) {
        if (self.window == nil) return;
        
        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
        self.scrollView.mj_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
     _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState != MJRefreshStateRefreshing) return;
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复inset和offset
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            self.scrollView.mj_insetT += self.insetTDelta;
            
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
        }];
    } else if (state == MJRefreshStateRefreshing) {
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            // 增加滚动区域
            CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
            self.scrollView.mj_insetT = top;
            
            // 设置滚动位置
            self.scrollView.mj_offsetY = - top;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];// 以 block 的形式，让外部调用者刷新数据
        }];
    }
}
```

根据类结构图，其它的下拉刷新的类，主要就是用于定制样式了，真正的功能实现就是上述两个类。

##### MJRefresh 上拉刷新原理
这和下拉刷新的 view 公用一个基类 MJRefreshComponent 。因为不论是上拉还是下拉，它其实就是一段 view ，根据它插入的位置来决定它是上拉还是下拉，所以它们是可以有公用的 view 类的。

上拉在 UIScrollView+MJRefresh.m 中实现如下：
```javascript
- (void)setMj_footer:(MJRefreshFooter *)mj_footer
{
    if (mj_footer != self.mj_footer) {
        // 删除旧的，添加新的
        [self.mj_footer removeFromSuperview];
        [self addSubview:mj_footer];
        
        // 存储新的
        [self willChangeValueForKey:@"mj_footer"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshFooterKey,
                                 mj_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_footer"]; // KVO
    }
}

我们可以看到它直接用的 addSubview 方法，所以这个 footerView 需要时刻更新它位置的 top 值。

```

上拉不同于下拉的区别就开始于 MJRefreshFooter 类，这个类比较简单。没什么特别说的。下拉的功能实现主要以 MJRefreshAutoFooter 类来说明（暂不考虑可以自动回弹的控件）

在 addSubview FooterView 的时候需要更新展示的位置(同时在 UIScrollView 的 contentSize 发生变化时，也更新位置)，如下代码：
```javascript
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) { // 新的父控件
        if (self.hidden == NO) {
            self.scrollView.mj_insetB += self.mj_h;
        }
        
        // 设置位置
        self.mj_y = _scrollView.mj_contentH;
    } else { // 被移除了
        if (self.hidden == NO) {
            self.scrollView.mj_insetB -= self.mj_h;
        }
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 设置位置
    self.mj_y = self.scrollView.mj_contentH;
}
```

对于上拉刷新，有三个状态是需要开始刷新数据的(contentOffset 变化，和 panState，拖拽手势的状态)。如下代码：
```javascript
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state != MJRefreshStateIdle || !self.automaticallyRefresh || self.mj_y == 0) return;
    
    if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { // 内容超过一个屏幕
        // 这里的_scrollView.mj_contentH替换掉self.mj_y更为合理
        if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h * self.triggerAutomaticallyRefreshPercent + _scrollView.mj_insetB - self.mj_h) {
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y <= old.y) return;
            
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
    if (self.state != MJRefreshStateIdle) return;
    
    if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
        if (_scrollView.mj_insetT + _scrollView.mj_contentH <= _scrollView.mj_h) {  // 不够一个屏幕
            if (_scrollView.mj_offsetY >= - _scrollView.mj_insetT) { // 向上拽
                [self beginRefreshing];
            }
        } else { // 超出一个屏幕
            if (_scrollView.mj_offsetY >= _scrollView.mj_contentH + _scrollView.mj_insetB - _scrollView.mj_h) {
                [self beginRefreshing];
            }
        }
    }
}

```

开始刷新方法如下，一般情况下，执行 self.state = MJRefreshStateRefreshing; 。如下代码：
```javascript
- (void)beginRefreshing
{
    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
        self.alpha = 1.0;
    }];
    self.pullingPercent = 1.0;
    // 只要正在刷新，就完全显示
    if (self.window) {
        self.state = MJRefreshStateRefreshing;
    } else {
        // 预发当前正在刷新中时调用本方法使得header insert回置失败
        if (self.state != MJRefreshStateRefreshing) {
            self.state = MJRefreshStateWillRefresh;
            // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
            [self setNeedsDisplay];
        }
    }
}
```

而该类中在设置 state 为 MJRefreshStateRefreshing 之后，就会执行自动加载数据的方法（以 block 的形式让外部调用者加载数据并展示）。
```javascript
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    if (state == MJRefreshStateRefreshing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self executeRefreshingCallback];
        });
    }
}
```











