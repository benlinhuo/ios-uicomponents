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









