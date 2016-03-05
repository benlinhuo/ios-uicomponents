
####组件
该组件的难点在于不仅可以滚动（本身 UIScrollView 就有按页滚动的机制，self.scrollView.pagingEnabled = YES; // 开启分页），滚动的 view 中有可以点击的按钮，且该view 也可以点击。重点代码是在 AGJChatEmptyScrollView.m 中有如下代码：
```javascript
// 这是重点代码
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden) {
        return [super hitTest:point withEvent:event];
    }
    __block UIView *view1 = nil;
    __block UIView *view2 = nil;
    for (AGJGoldBrokerCardView *card in self.viewsData) {
        // self 是 card.chatBtn 的父视图，如果使用如下方法获取的 point1，在 通过 hitTest 方法获取的 view1 ，如果 view1 不为空，则直接返回 view1 （不可理解的点是：对于按钮所在范围来说，本应该需要区分是点击还是拖动的，如下处理，当是拖动时，返回view1 而不是 self.scrollContainerView，这样如何会当作拖动处理。）
        CGPoint point1 = [card.chatBtn convertPoint:point fromView:self];
        CGPoint point2 = [card convertPoint:point fromView:self];
        
        view1 = [card.chatBtn hitTest:point1 withEvent:event];
        view2 = [card hitTest:point2 withEvent:event];
        
        if (view2) {
            return view2;
        }
        if (view1) {
            return view1;
        }
    }
    return self.scrollContainerView;
}
```