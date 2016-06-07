//
//  HBLNotificationView.m
//  HBLStatusBar
//
//  Created by benlinhuo on 16/6/7.
//  Copyright © 2016年 Benlinhuo. All rights reserved.
//

#import "HBLNotificationView.h"
#import "UIView+BFS.h"
#import "UIColor+BFS.h"

@interface HBLNotificationView ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statesMessage;
@property (weak, nonatomic) IBOutlet UIView *sliderBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) NSDictionary *jumpInfo;

@end

@implementation HBLNotificationView

-(void)awakeFromNib{
    self.backgroundColor = [UIColor colorWithHex:0x3E3E3E alpha:1.f];
    _sliderBarView.layer.cornerRadius = _sliderBarView.height/2;
    self.backgroundColor = [UIColor clearColor];
    self.bottomView.alpha = 0.f;
    self.topView.alpha = .8f;
    
    self.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    tap.delaysTouchesBegan = YES;
    [self addGestureRecognizer:tap];
    
}

-(void)layoutSubviews{
    _sliderBarView.centerX = self.centerX;
}

-(void)hideSelfWithAnimation{
    //隐藏
    if (self.bottom != 0) {
        
        [UIView animateWithDuration:.5f  animations:^{
            self.bottom = 0;
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:HBLNotificationNotificationViewDidRemovedFromSuperView object:nil];
        }];
    }
    
}

-(void)pan:(UIPanGestureRecognizer *)gesture{
    
    [UIView animateWithDuration:0.3f animations:^{
        self.bottom = [gesture locationInView:self].y > HBLNotificationViewStatusBarHeight ? HBLNotificationViewStatusBarHeight : [gesture locationInView:self].y;
    } completion:^(BOOL finished) {
        if (gesture.state != UIGestureRecognizerStateChanged) {
            //隐藏
            [self hideSelfWithAnimation];
        }
    }];
}


-(void)tapped:(UITapGestureRecognizer *)tap {
    
    if (self.bottom != 0) {
        [UIView animateWithDuration:.5f  animations:^{
            self.bottom = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:HBLNotificationNotificationViewDidRemovedFromSuperView object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:HBLJumpWithChatMessageIdentifer object:_jumpInfo];
        }];
    }
}

-(void)showWithStatus:(NSString *)status{
    _statesMessage.text = status;
}

- (void)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image jumpInfo:(NSDictionary *)info
{
    [self showWithTitle:title subTitle:subTitle jumpInfo:info];
    _noticeImageView.image = image;
}

- (void)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageString:(NSString *)imageString jumpInfo:(NSDictionary *)info
{
    [self showWithTitle:title subTitle:subTitle jumpInfo:info];
    _noticeImageView.image = [UIImage imageNamed:@"bg_bwzf_pre"];

}

- (void)showWithTitle:(NSString *)title subTitle:(NSString *)subTitle jumpInfo:(NSDictionary *)info
{
    _jumpInfo = info;
    if (title.length > 0) {
        _titleLabel.text = title;
    } else {
        _titleLabel.text = @"通知";
    }
    
    if (subTitle.length > 0) {
        _statesMessage.text = subTitle;
    } else {
        _statesMessage.text = @"有一条新消息";
    }
    [self showSelfWithAnimation];
}

- (void)showSelfWithAnimation
{
    [UIView animateWithDuration:.4f
                     animations:^{
                         self.bottom = HBLNotificationViewStatusBarHeight;
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

+ (id)loadFromXibIfViewAtLastIndex
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
