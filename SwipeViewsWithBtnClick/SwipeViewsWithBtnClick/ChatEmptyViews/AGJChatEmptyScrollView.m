//
//  AGJChatEmptyScrollView.m
//  Angejia
//
//  Created by benlinhuo on 16/3/3.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJChatEmptyScrollView.h"
#import "AGJLandscapeScrollView.h"
#import "AGJGoldBrokerCardView.h"
#import "UIColor+BFS.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface AGJChatEmptyScrollView() <AGJGoldBrokerCardViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewConstant;

//UI
@property (nonatomic, strong) NSMutableArray *viewsData;
@property (nonatomic, strong) AGJLandscapeScrollView *scrollContainerView;

@end

@implementation AGJChatEmptyScrollView

- (void)awakeFromNib
{
    _containerView.backgroundColor = [UIColor colorWithHex:0xEEEEEE alpha:1];
}

- (void)showContentData
{
    NSArray *brokers = @[
                         @{
                             @"avatar": @"http://7tebqs.com2.z0.glb.qiniucdn.com/FjBCDRqa-yvLYDNYElaa9ENaWc4X",
                             @"dealCount": @"1",
                             @"isGoldMedal": @"1",
                             @"name":@"张兰",
                             @"reviewVisitRate": @"100",
                             @"surroundingArea":@"擅长内容：xxx",
                             @"visitReviewGoodCount": @"6"
                             },
                         @{
                             @"avatar": @"http://7teb43.com2.z0.glb.qiniucdn.com/FlqdfHWM8F9pyBtMf_gzMh4kFgdt",
                             @"dealCount": @"1",
                             @"isGoldMedal": @"1",
                             @"name":@"黄药师",
                             @"reviewVisitRate": @"100",
                             @"surroundingArea":@"擅长内容：yyy",
                             @"visitReviewGoodCount": @"6"
                             },
                         @{
                             @"avatar": @"http://7tebqs.com2.z0.glb.qiniucdn.com/Ftqp4CbhS5iUvY1ZTCVXlfOs9YRI",
                             @"dealCount": @"1",
                             @"isGoldMedal": @"1",
                             @"name":@"翊一",
                             @"reviewVisitRate": @"100",
                             @"surroundingArea":@"擅长内容：zzzz",
                             @"visitReviewGoodCount": @"6"
                             }
                         ];
    NSMutableArray *views = [NSMutableArray array];
    [brokers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AGJBroker *broker = [[AGJBroker alloc] init];
        [broker loadPropertiesWithData:obj];
        AGJGoldBrokerCardView *view = [AGJGoldBrokerCardView loadFromXibIfViewAtFirstIndex];
        
        view.layer.borderColor = [UIColor colorWithHex:0xE6E6E6 alpha:1].CGColor;
        view.layer.borderWidth = 1.f;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 3.f;
        view.goldBrokerDelegate = self;
        
        [view configWithBroker:broker];
        [views addObject:view];
        
    }];
    self.viewsData = views;
    
    CGFloat w = 210;
    CGFloat h = 286;
    CGFloat interval = 15;
    NSDictionary *dic = @{
                          @"viewHeight":@(h),
                          @"viewWidth":@(w),
                          @"viewInterval":@(interval)
                          };
    CGFloat left = (SCREEN_WIDTH - w) / 2;
    self.scrollContainerView = [[AGJLandscapeScrollView alloc] initWithViews:views frame:CGRectMake(0, 0, w + interval, h) params:dic];
    [self.containerView addSubview:self.scrollContainerView];
    self.leftViewConstant.constant = (left - interval);
}

// 这是重点代码
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden) {
        return [super hitTest:point withEvent:event];
    }
    __block UIView *view1 = nil;
    __block UIView *view2 = nil;
    for (AGJGoldBrokerCardView *card in self.viewsData) {
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

#pragma mark - AGJGoldBrokerCardViewDelegate
- (void)gotoBrokerDetailPage:(AGJBroker *)broker
{
    if (self.emptyDelegate && [self.emptyDelegate respondsToSelector:@selector(gotoBrokerDetailPage:)]) {
        [self.emptyDelegate gotoBrokerDetailPage:broker];
    }
}

- (void)gotoChatDetailPage:(AGJBroker *)broker
{
    if (self.emptyDelegate && [self.emptyDelegate respondsToSelector:@selector(gotoChatDetailPage:)]) {
        [self.emptyDelegate gotoChatDetailPage:broker];
    }
}

@end
