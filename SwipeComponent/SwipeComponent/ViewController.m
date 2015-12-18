//
//  ViewController.m
//  SwipeComponent
//
//  Created by benlinhuo on 15/9/4.
//  Copyright (c) 2015年 benlinhuo. All rights reserved.
//

#import "ViewController.h"

#define kWidthOfScreen [UIScreen mainScreen].bounds.size.width
#define kHeightOfScreen [UIScreen mainScreen].bounds.size.height
#define kImageViewCount 3

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic) NSInteger imageCount;
@property (nonatomic, strong) NSMutableDictionary *mDicImageData;
@property (nonatomic) NSInteger currentImageIndex;

@property (nonatomic, strong) UIScrollView *scrV;
@property (nonatomic, strong) UIImageView *imgLeft;
@property (nonatomic, strong) UIImageView *imgCenter;
@property (nonatomic, strong) UIImageView *imgRight;
@property (nonatomic, strong) UIPageControl *pageC;
@property (nonatomic, strong) UILabel *lblImageDesc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

- (void)layoutUI
{
    self.view.backgroundColor = [UIColor blackColor];
    
    [self loadImageData];
    [self addScrollView];
    [self addImageViewsToScrollView];
    [self addPageControl];
    [self addLabel];
    [self setDefaultInfo];
}

- (void)loadImageData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ImageInfo" ofType:@"plist"];
    _mDicImageData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    _imageCount = _mDicImageData.count;
}

- (void)addScrollView
{
    _scrV = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrV.contentSize = CGSizeMake(kWidthOfScreen * kImageViewCount, kHeightOfScreen);
    _scrV.contentOffset = CGPointMake(kWidthOfScreen, 0);
    _scrV.pagingEnabled = YES;
    _scrV.showsHorizontalScrollIndicator = NO;
    _scrV.delegate = self;
    [self.view addSubview:_scrV];
}

- (void)addImageViewsToScrollView
{
    _imgLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidthOfScreen, kHeightOfScreen)];
    _imgLeft.contentMode = UIViewContentModeScaleAspectFit;
    [_scrV addSubview:_imgLeft];
    
    _imgCenter = [[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfScreen, 0, kWidthOfScreen, kHeightOfScreen)];
    _imgCenter.contentMode = UIViewContentModeScaleAspectFit;
    [_scrV addSubview:_imgCenter];
    
    _imgRight = [[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfScreen * 2, 0, kWidthOfScreen, kHeightOfScreen)];
    _imgRight.contentMode = UIViewContentModeScaleAspectFit;
    [_scrV addSubview:_imgRight];
}

- (void)addPageControl
{
    _pageC = [[UIPageControl alloc] init];
    //根据页数返回 UIPageControl 合适的大小
    CGSize size = [_pageC sizeForNumberOfPages:_imageCount];
    _pageC.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageC.center = CGPointMake(kWidthOfScreen / 2, kHeightOfScreen - 80);
    _pageC.numberOfPages = _imageCount;
    _pageC.pageIndicatorTintColor = [UIColor whiteColor];
    _pageC.currentPageIndicatorTintColor = [UIColor brownColor];
    //设置是否允许用户交互；默认值为 YES，当为 YES 时，针对点击控件区域左（当前页索引减一，最小为0）右（当前页索引加一，最大为总数减一），可以编写 UIControlEventValueChanged 的事件处理方法
    _pageC.userInteractionEnabled = NO;
    [self.view addSubview:_pageC];
    
}

- (void)addLabel
{
    _lblImageDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, kWidthOfScreen, 40)];
    _lblImageDesc.textAlignment = NSTextAlignmentCenter;
    _lblImageDesc.textColor = [UIColor whiteColor];
    _lblImageDesc.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    _lblImageDesc.text = @"Fucking now.";
    [self.view addSubview:_lblImageDesc];
}

- (void)setDefaultInfo
{
    _currentImageIndex = 0;
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

- (void)setInfoByCurrentImageIndex:(NSInteger)currentImageIndex
{
    NSString *currentImageNamed = [NSString stringWithFormat:@"%lu.png", (unsigned long)currentImageIndex];
    _imgCenter.image = [UIImage imageNamed:currentImageNamed];
    
    NSInteger leftIndex = (currentImageIndex - 1 + _imageCount) % _imageCount;
    _imgLeft.image = [UIImage imageNamed:[NSString stringWithFormat: @"%lu.png", (unsigned long)leftIndex]];
    
    NSInteger rightIndex = (currentImageIndex + 1) % _imageCount;
    _imgRight.image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu.png", (unsigned long)rightIndex]];
    
    
    _pageC.currentPage = currentImageIndex;
    _lblImageDesc.text = _mDicImageData[currentImageNamed];
    
}

- (void)reloadImage
{
    CGPoint contentOffset = [_scrV contentOffset];
    if (contentOffset.x > kWidthOfScreen) {// 往左滑动
        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
    } else if (contentOffset.x < kWidthOfScreen) {
        _currentImageIndex = (_currentImageIndex - 1 + _imageCount) % _imageCount;
    }
    
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
    
    _scrV.contentOffset = CGPointMake(kWidthOfScreen, 0);
    _pageC.currentPage = _currentImageIndex;
    
    NSString *currentImageNamed = [NSString stringWithFormat:@"%lu.png", (unsigned long)_currentImageIndex];
    _lblImageDesc.text = _mDicImageData[currentImageNamed];
}

@end
