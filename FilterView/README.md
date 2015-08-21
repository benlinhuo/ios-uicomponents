##FilterView

这是APP里面使用它来进行筛选的一个组件，具体样式有如下三个图：
![alt picture one](./1.jpg "图一")
![alt picture one](./2.jpg "图二")
![alt picture one](./3.jpg "图三")
可以看出，这三个图的最上层筛选，是通过按钮进行类别区分的，如“区域”，“价格”，“户型”，“排序”。这四个都是继承于 UIButton 的 BFSFilterButton 。

第一个图，是最简单的筛选的一个样式，如价格筛选，直接选择“200-300万元”，则表示我们想要选择价格处于“200-300万元”之间的房源列表。

第二个图，通过点击按钮展开的下拉 View 其实是个父子关系的View，左右都是 BFSTableView ,左侧 BFSTableView 的宽度就是整个屏幕的宽度，右侧的是覆盖在左侧，且宽度是左侧的 7/16.

第三个图，其实第一个和第二个都是该组件默认就有的样式。后来因为设计师加了第三图展示的效果，于是就针对已有的组件进行扩展，心想着设计师的思想可能不是一时就固定的，以后还不定会改成什么样子呢。所以除了默认样式以外，我们就扩充接口，能让使用者自己定义展开的 View 样式。


###下面针对这个组件进行代码的解析
![alt picture one](./4.jpg "图四")

我们解析，可以针对上图4开讲，1 表示 BFSFilterButton，2 表示 BFSFilterTableView，3 表示 BFSFilterTableViewCell，与 BFSFilterTableViewCell 对应的模型是 BFSFilterItem 。其中该组件还有“更多”选项，但是因为还没使用案例，也没尝试，所以还不知道该怎么使用（应该不难，同二手房列表页面）。BFSFilterView 就是123所代码的整体部分。

####BFSFilterButton

该类的主要作用是画出图中指定的按钮样式，左文字右图。同时该类还有如下属性 
1. unfolded: 用于表示该 button 当前状态下，它对应的下拉 View 是否是展开的。
2. index: 因为在 BFSFilterView 类中，是有buttons的一个集合的，这样可以方便获取
3. buttonPulledViewType: 因为我们后来扩展了该组件，于是就新加了这个下拉 View 的类型，用来表示是使用默认样式，还是自定义 View 设置样式

方法有：
1. - (void)showSeparator:(BOOL)show; 一排3个按钮，则最后一个按钮时不需要右侧的分割线的，所以我们给了接口设置。
2. - (void)setSeparatorMarginForTop:(CGFloat)top andBottom:(CGFloat)bottom; 我们可以看到上图，分割线不是整个的贯穿于整个按钮右侧，而是距离上下都是有间隔的，这个函数就是用于设置的。


####BFSFilterTableViewCell

该类是表示在默认样式下的一个 UITableViewCell ，它很简单，它更多的也是用于样式的渲染以及考虑到 cell 的复用问题。它只有一个属性和方法，如下：

1. @property (nonatomic, retain) NSMutableDictionary *filterTableViewCellStyle; 我们可以看到该属性是一个 NSDictionary 类型，看到上面截图有底色为灰色和白色两种样式，字体我们是可以自己外部设置的，通过这个属性值来设置自己想要的样式。如下代码：
```javascript
 NSMutableDictionary  * filterTableViewCellStyle = [NSMutableDictionary dictionary];
[filterTableViewCellStyle setValue:[NSNumber numberWithInt:0xF15F00] forKey:@"CellLabelSelectTextColor"];
[filterTableViewCellStyle setValue:[NSNumber numberWithInt:0x000000] forKey:@"CellLabelTextColor"];
[_filterView setFilterTableViewCellStyle:filterTableViewCellStyle];
```

2. - (void)setFilterTableViewCellStyle:(NSMutableDictionary*) cellStyle; 从上代码已经可以看到用到了这个方法，它就是为上述的属性提供了 set 方法。


####BFSFilterItem

该类是上述 BFSFilterTableViewCell 对应的数据模型。它的属性比较多，这边只记录用的较多的 name 和 value 属性，其实 name 是用于展示到UI中的，value 是它真正对应的值，用于查询。这个类比较简单，注释也比较多，直接看源代码即可。需要注意的一点是：我们的 BFSFilterButton 对应的数据模型也是这个。


####BFSFilterTableView

该类创建一个 tableview ,不过因为可能是有父子层级结构出现，所以就有了属性 childTableView 和 parentTableView. 这个类好像都没什么需要特别解析的。它就是创建一个 tableview ,如果有多层级的 tableview，也是在这个类中创建和操作的。该类中值得说的一个点是，每当我选择了价格“200-300万元”这个选项之后，它再次展示的时候，会将这个选项作为我们看见的第一项。方法如下：

```javascript
- (void)reloadData
{
    [super reloadData];
    if (self.filterItem && self.filterItem.selectedItems.count) {
        //该方法是 UITableView 自带的一个方法，用于选择该选项，且滚动到 top 位置
        [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.filterItem.selectedItems[0] intValue] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        // 这是自己写的一个方法。该方法就是处理可能二层级关系的选中执行 selectedBlock 方法
        [self didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.filterItem.selectedItems[0] intValue] inSection:0] byUser:NO];
    }
}
```


####BFSFilterView

这是整个组件的核心类，用于组织创建。因为这个组件是外部给数据，内部渲染默认样式，所以就有了类似于 UITableView 的两个代理 protocol （BFSFilterViewDataSource ＋ BFSFilterViewDelegate）

#####BFSFilterViewDataSource
```javascript
@protocol BFSFilterViewDataSource<NSObject>
@required
/**
* 指定个数，它可以通过 private方法，UpdateMaxAllowShownCountToDefault 来更新，后面可以用于判断是否需要“更多”按钮。
*/
- (NSInteger)numberOfItemsForFilterView:(BFSFilterView *)filterView;
- (NSInteger)filterView:(BFSFilterView *)filterView tagAtIndex:(NSInteger)index;
/**
* 该方法用于设置每个 index ，对应的数据是什么，用数据生成对应的 BFSFilterItem 项，多维数组，第一纬表示 button 的数据
*/
- (BFSFilterItem *)filterView:(BFSFilterView *)filterView itemAtIndex:(NSInteger)index;

@optional
- (NSString *)getMinPrice;
- (NSString *)getMaxPrice;

/**
 * 扩充组件，新加入的方法，用于指定每个对应的button 展示的 默认样式，还是自定义样式
 * 用于设置 BFSFilterButton 点击之后，展开的view类型，可以是默认，也可以是自定义
 */
- (NSInteger)filterView:(BFSFilterView *)filterView buttonPulledViewTypeAtIndex:(NSInteger)index;

/**
 * 扩充组件，传入自定义的 view 到组件内部，给其组织。button 是为了给到外部，当自定义的 View 中的选项发生变化时，button 中的文案也应该跟着变化。
 * 用于设置对应的自定义view
 */
- (UIView *)filterView:(BFSFilterView *)filterView customViewAtIndex:(NSInteger)index correspondingButton:(BFSFilterButton *)button;
@end
```

#####BFSFilterViewDelegate
```javascript
@protocol BFSFilterViewDelegate<NSObject>
@required
/**
 *  用户选中筛选项以后的回调
 *
 *  @param filterView  筛选视图
 *  @param selectItems 具体选中的筛选项
 *  @param indexPath 包含选中的筛选项的层次信息
 */
- (void)filterView:(BFSFilterView *)filterView didSelectedItems:(NSArray */*BFSFilterItems * */)selectItems atIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  用户自定义价格筛选
 *
 */
- (void)didSecetedPriceBlock:(NSString *)minPrice theMaxPrice:(NSString *)maxPrice;

/**
 *  更多筛选项
 *
 */
- (void)showMoreFilter;

@end
```

关于这个类，需要解析的方法如下：
1. - (void)updateUIWithDataSource; 这个方法主要是用于获取 datasource 的，它调用了 BFSFilterViewDataSource 协议中的几个方法，具体见源码。将所有的数据给赋值给了变量 forest 。
2. - (void)updateUIWithForest; 利用上述拿到的数据来渲染UI，分以下几个步骤：
```javascript
2.1 移除所有之前创建的元素
2.2 根据数据，创建对应的 BFSFilterButton UI。且为该 button 添加对应事件 filterButtonClicked
2.3 因为之前可能已经有选中的选项了，所以等再次展示的时候，需要主动设置其中某个选项为选中状态。
```
3. - (void)filterButtonClicked:(BFSFilterButton *)sender; 点击事件，如果点击非按钮状态，则自动隐藏；如果点击按钮，则展开的变为非展开，非展开的变为展开状态。这里需要注意的一点：需要判断，当前 button 对应的下拉 View 是否是自定义的，如果是的话，就要调用新增的一个获取该 view 的 protocol 方法。
4. - (void)hiddenFilterTableView; 这是需要注意的方法，它隐藏不是真的隐藏，而是都把它从父view 中移除，等再次重现的时候再重建，至于为什么是这样的设计，也是有点不解。但是如果是自定义的 customview ，则是可以在组件外部，自己不要每次重建 customview ,这样的代价比较高，且每次还要重新选中已选中的选项。在 AGJBrokerListViewController.m 中，我是用懒加载的方式创建的，也就是再次展示的时候原先的内容还是存在的，只不过它从父view 中移除了而已。
```javascript
- (void)hiddenFilterTableView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.shadowView removeFromSuperview];
    [self.shadowView removeAllSubviews];
    [self.shadowView_top_assistant removeFromSuperview];
}
```


### 总结

<<<<<<< HEAD
目前项目中使用了这个组件的类有 xxxPropertyListViewController 和 xxxBrokerListViewController 。可参见其使用。
=======
目前项目中使用了这个组件的类有 xxxPropertyListViewController 和 xxxBrokerListViewController 。可参见其使用。
>>>>>>> image
