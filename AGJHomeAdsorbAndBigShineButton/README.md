### 简介
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这个项目中包含了两个效果：一个是动画，类似水的波浪往外推的效果；第二个是多个 card 切换，以及往上推的时候会自动吸附到 navigationbar 上。

### 第一个动画效果
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这个效果很简单，就是 CABaseAnimation 的简单运用。核心代码如下：

```
// 创建 CAShapeLayer
- (void)configWithColor:(UIColor *)color
{
    CGRect pathFrame = CGRectMake(-[AGJLayerAnimationView buttonWidth] / 2, -[AGJLayerAnimationView buttonWidth] / 2, [AGJLayerAnimationView buttonWidth], [AGJLayerAnimationView buttonWidth]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:[AGJLayerAnimationView buttonWidth] * 1.5 / 2 / 2];
    CGPoint shapePosition = CGPointMake([AGJLayerAnimationView buttonWidth] / 2, [AGJLayerAnimationView buttonWidth] / 2);
    _shapeLayer1 = [CAShapeLayer layer];
    _shapeLayer1.path = path.CGPath;
    _shapeLayer1.position = shapePosition;
    if (color) {
        _shapeLayer1.fillColor = color.CGColor;

    }
    _shapeLayer1.opacity = 0;
    _shapeLayer1.strokeColor = [UIColor clearColor].CGColor;
    _shapeLayer1.lineWidth = 2.0;
    [self.layer addSublayer:_shapeLayer1];
    
    _shapeLayer2 = [CAShapeLayer layer];
    _shapeLayer2.path = path.CGPath;
    _shapeLayer2.position = shapePosition;
    if (color) {
        _shapeLayer2.fillColor = color.CGColor;

    }
    _shapeLayer2.opacity = 0;
    _shapeLayer2.strokeColor = [UIColor clearColor].CGColor;
    _shapeLayer2.lineWidth = 2.0;
    [self.layer addSublayer:_shapeLayer2];
}

// 为每个 shapeLayer 添加动画
- (CAAnimationGroup *)animationGoup
{
    if (!_animationGoup) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)];
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @0.3;
        alphaAnimation.toValue = @0;
        
        _animationGoup = [CAAnimationGroup animation];
        _animationGoup.delegate = self;
        _animationGoup.animations = @[scaleAnimation, alphaAnimation];
        _animationGoup.duration = 5.0f;
        _animationGoup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        _animationGoup.repeatCount = HUGE_VALF;
    }
    return _animationGoup;
}

```

### 第二个 scroll 的效果
* 三个 Tab 切换的效果
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这个很简单，就是设置 UIScrollView 的某个属性即可

```
_scrollView.pagingEnabled = YES;
_scrollView.showsHorizontalScrollIndicator = NO;
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这个效果，还需要监测 UIScrollView 的滚动，因为 tab 下的红色标志也要跟着变化位置。

```
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self.topFunctionView.segmentView setSelectedSegmentIndex:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.topFunctionView.segmentView setSlidViewLeft:scrollView.contentOffset.x / 3];
}
```


* 自动吸附的效果

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这个效果也是通过监测三个 Tab  下的 UITableView 滚动，然后在滚动一定距离，就自动吸附到最顶端位置

```
- (void)tableViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isScrolling) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    __weak typeof(self) weakSelf = self;
    
    if (offsetY > 0 && !self.isScrolledTop) {
        self.isScrolling = YES;
        [UIView animateWithDuration:0.5
                         animations:^{
                             weakSelf.topFunctionView.frame = CGRectMake(weakSelf.topFunctionView.frame.origin.x, weakSelf.topFunctionView.frame.origin.y - toolViewHeight - graySpaceHeight, weakSelf.topFunctionView.frame.size.width, weakSelf.topFunctionView.frame.size.height);
                             weakSelf.scrollView.frame = CGRectMake(weakSelf.scrollView.frame.origin.x, weakSelf.scrollView.frame.origin.y - toolViewHeight - graySpaceHeight, weakSelf.scrollView.frame.size.width, weakSelf.scrollView.frame.size.height);
                             
                         } completion:^(BOOL finished){
                             weakSelf.isScrolling = NO;
                             weakSelf.isScrolledTop = YES;
                             
                         }];
    }
    
    if (offsetY < 0 && weakSelf.isScrolledTop) {
        weakSelf.isScrolling = YES;
        [UIView animateWithDuration:0.5
                         animations:^{
                             weakSelf.topFunctionView.frame = CGRectMake(weakSelf.topFunctionView.frame.origin.x, weakSelf.topFunctionView.frame.origin.y + toolViewHeight + graySpaceHeight, weakSelf.topFunctionView.frame.size.width, weakSelf.topFunctionView.frame.size.height);
                             weakSelf.scrollView.frame = CGRectMake(weakSelf.scrollView.frame.origin.x, weakSelf.scrollView.frame.origin.y + toolViewHeight + graySpaceHeight, weakSelf.scrollView.frame.size.width, weakSelf.scrollView.frame.size.height);
                             
                         } completion:^(BOOL finished){
                             weakSelf.isScrolling = NO;
                             weakSelf.isScrolledTop = NO;
                             
                         }];
    }
}

```
