//
//  BFSErrorMessageView.m
//  BIFService
//
//  Created by wysasun on 14/12/3.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "BFSErrorMessageView.h"
#import "UIColor+BFS.h"
#import "UIView+BFS.h"
#import "NSString+BFSSizeWithFont.h"
typedef NS_ENUM(NSInteger, BFSErrorMessageViewState) {
    BFSErrorMessageViewStateNormal = 0,
    BFSErrorMessageViewStateDismiss,
    BFSErrorMessageViewStateShow,
};

@interface BFSErrorMessageView ()
@property (nonatomic, strong) UIButton *actionBtn;
@property (nonatomic, strong, readwrite) UIButton *highLightBtn;

@property (nonatomic, strong) UIView *visibleView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, assign) __block BFSErrorMessageViewState state;
@property (nonatomic, unsafe_unretained) id btnTarget;
@property (nonatomic, assign) SEL btnAction;

@end

@implementation BFSErrorMessageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        self.visibleView = [[UIView alloc] init];
        self.visibleView.backgroundColor = self.backgroundColor;
        [self addSubview:self.visibleView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 0)];
        self.titleLab.numberOfLines = 0;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.backgroundColor = self.backgroundColor;
        self.titleLab.textColor = [UIColor colorWithHex:0x7B7B7B alpha:1];
        self.titleLab.font = [UIFont systemFontOfSize:16];
        [self.visibleView addSubview:self.titleLab];
        
        self.subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        self.subTitleLab.numberOfLines = 0;
        self.subTitleLab.textAlignment = NSTextAlignmentCenter;
        self.subTitleLab.backgroundColor = self.backgroundColor;
        self.subTitleLab.textColor = [UIColor colorWithHex:0x727272 alpha:1];
        self.subTitleLab.font = [UIFont systemFontOfSize:12];
        [self.visibleView addSubview:self.subTitleLab];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.userInteractionEnabled = YES;
        [self.visibleView addSubview:self.imageView];
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 25, 0);
        
        
        self.actionBtn = [[UIButton alloc] initWithFrame:self.bounds];
        self.actionBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.actionBtn];
        
        self.highLightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
        [self.highLightBtn setBackgroundColor:[UIColor colorWithHex:0xFF8000 alpha:1]];
        [self.highLightBtn setRoundedCorner:5];
        self.highLightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.visibleView addSubview:self.highLightBtn];
    }
    return self;
}

- (void)showInView:(UIView *)view type:(BFSErrorMessageType)type target:(id)target action:(SEL)action{
    [self showInView:view type:type target:target action:action withMsg:nil];
}

- (void)showInView:(UIView *)view type:(BFSErrorMessageType)type target:(id)target action:(SEL)action withMsg:(NSString*)sMsg{
    NSString *subTitle = [self subTitleForType:type];
    NSString *title = [self messageForType:type];
    if (sMsg.length > 0) {
        title = sMsg;
    }
    [self showInView:view title:title image:[self imageForType:type] subTitle:subTitle target:target action:action];
}

- (NSString *)subTitleForType:(BFSErrorMessageType)type{
    switch (type) {
        case BFSErrorTypeNoNetWork:
            return @"请检查网络后重试";
        case BFSErrorTypeCityNotOpen:
        case BFSErrorTypeNoData:
            return @"";
        default:
            return @"请检查网络或点击屏幕重试";
    }
}

- (NSString *)messageForType:(BFSErrorMessageType)type{
    switch (type) {
        case BFSErrorTypeNoData:
            return  @"暂无数据";
        case BFSErrorTypeNoNetWork:
            return @"网络不可用";
        case BFSErrorTypeCityNotOpen:
            return @"城市未开通";
        default:
            return @"";
    }
}

- (UIImage *)imageForType:(BFSErrorMessageType)type{
    switch (type) {
        case BFSErrorTypeNoData:
            return nil;//[UIImage noDataForList];
        case BFSErrorTypeNoNetWork:
            return nil;//[UIImage noNetwork];
        case BFSErrorTypeCityNotOpen:
            return nil;//[UIImage noCityForApp];
        default:
            return nil;
    }
}

- (void)showInView:(UIView *)view title:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action{
    [self showInView:view title:title image:image subTitle:subTitle target:target action:action highLightButton:NO highLightButtonText:@""];
}

- (void)showInView:(UIView *)view title:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action topMargin:(CGFloat)topMargin
{
    [self showInView:view title:title image:image subTitle:subTitle target:target action:action highLightButton:NO highLightButtonText:@""];
    self.top = self.top + topMargin;
    self.height -= topMargin;
}

- (void)showInView:(UIView *)view title:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle target:(id)target action:(SEL)action highLightButton:(BOOL)showHighLightButton highLightButtonText:(NSString *)text
{
    self.state = BFSErrorMessageViewStateShow;
    if (view != nil) {
        self.frame = view.bounds;
        self.backgroundColor = [UIColor whiteColor];
        [view addSubview:self];
        if ([view isKindOfClass:[UITableView class]]) {
            [(UITableView *)view setScrollEnabled:NO];
        }
        self.frame = CGRectMake(0, 0, view.width, view.height);
        self.alpha = 1;
    }
    CGSize visibleViewSize = CGSizeZero;
    [self.imageView setSize:image.size];
    self.imageView.image = image;
    self.imageView.top = visibleViewSize.height;
    
    visibleViewSize = CGSizeMake(MAX(visibleViewSize.width, self.imageView.width), MAX(visibleViewSize.height, self.imageView.bottom));
    
    CGSize titleSize = [title rtSizeWithFont:self.titleLab.font constrainedToSize:CGSizeMake(self.width, 100)];
    self.titleLab.text = title;
    [self.titleLab setSize:titleSize];
    self.titleLab.top = self.imageView.bottom+self.imageEdgeInsets.bottom+self.titleEdgeInsets.top;
    if (titleSize.height == 0) {
        self.titleLab.top -= self.imageEdgeInsets.bottom+self.titleEdgeInsets.top;
    }
    
    visibleViewSize = CGSizeMake(MAX(visibleViewSize.width, titleSize.width), self.titleLab.bottom);
    
    titleSize = [subTitle rtSizeWithFont:self.subTitleLab.font constrainedToSize:CGSizeMake(self.width, 100)];
    self.subTitleLab.text = subTitle;
    self.subTitleLab.backgroundColor = [UIColor clearColor];
    [self.subTitleLab setSize:titleSize];
    if (titleSize.height>0) {
        self.subTitleLab.top = self.titleLab.bottom+4;
        visibleViewSize = CGSizeMake(MAX(visibleViewSize.width, titleSize.width), self.subTitleLab.bottom);
    }
    
    
    if (action == nil) {
        self.actionBtn.hidden = YES;
    }else{
        [self bringSubviewToFront:self.actionBtn];
        self.actionBtn.hidden = NO;
        [self.actionBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.highLightBtn.hidden = YES;
    if (showHighLightButton && action) {
        [self bringSubviewToFront:self.visibleView];
        self.actionBtn.hidden = YES;
        self.highLightBtn.hidden = NO;
        [self.highLightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self.highLightBtn setTitle:text forState:UIControlStateNormal];
        if (subTitle && subTitle.length) {
            self.highLightBtn.top =  self.titleEdgeInsets.bottom + self.subTitleLab.bottom;
        } else {
            self.highLightBtn.top =  self.titleEdgeInsets.bottom + self.titleLab.bottom;
        }
        visibleViewSize = CGSizeMake(MAX(self.highLightBtn.width, MAX(visibleViewSize.width, titleSize.width)), self.highLightBtn.bottom);
    }
    [self.visibleView setSize:visibleViewSize];
    
    self.visibleView.center = self.center;
    self.visibleView.centerY = self.visibleView.centerY - 19;
    self.imageView.centerX = self.visibleView.width/2;
    self.titleLab.centerX = self.visibleView.width/2;
    self.highLightBtn.centerX = self.visibleView.width/2;
    self.subTitleLab.centerX = self.visibleView.width/2;
}

- (void)dismiss{
    [self dismissAnimation:NO];
}

- (void)dismissAnimation:(BOOL)animation{
    if (self.state == BFSErrorMessageViewStateDismiss) {
        return;
    }
    self.state = BFSErrorMessageViewStateDismiss;
    if (self.superview != nil) {
        if (animation) {
            [UIView animateWithDuration:.35 animations:^{
            } completion:^(BOOL finished) {
                if ([self.superview isKindOfClass:[UITableView class]]) {
                    [(UITableView *)self.superview setScrollEnabled:YES];
                }
                if (finished) {
                    [self removeFromSuperview];
                    self.state = BFSErrorMessageViewStateNormal;
                }
            }];
        }else{
            if ([self.superview isKindOfClass:[UITableView class]]) {
                [(UITableView *)self.superview setScrollEnabled:YES];
            }
            [self removeFromSuperview];
            self.state = BFSErrorMessageViewStateNormal;
        }
    }
}


@end
