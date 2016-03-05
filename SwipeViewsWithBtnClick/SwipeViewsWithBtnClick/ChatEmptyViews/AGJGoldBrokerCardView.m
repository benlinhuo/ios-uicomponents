//
//  AGJGoldBrokerCardView.m
//  Angejia
//
//  Created by benlinhuo on 16/3/1.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJGoldBrokerCardView.h"
#import "UIImageView+WebCache.h"
#import "NSString+BFSSizeWithFont.h"
#import "UIColor+BFS.h"

@interface AGJGoldBrokerCardView ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *goldTagImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodReviewNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *surroundAreaLabel;

@property (nonatomic, strong) AGJBroker *brokerData;

@end

@implementation AGJGoldBrokerCardView

- (void)awakeFromNib
{
    _avatarImgView.layer.cornerRadius = 3.f;
    _avatarImgView.layer.masksToBounds = YES;
    _avatarImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    _surroundAreaLabel.numberOfLines = 0; // 多行
    
    _chatBtn.layer.borderColor = [UIColor colorWithHex:0xFF6D4B alpha:1].CGColor;
    _chatBtn.layer.borderWidth = 1.f;
    _chatBtn.layer.masksToBounds = YES;
    _chatBtn.layer.cornerRadius = 3.f;
    
    UIImage *chatImg = [UIImage imageNamed:@"icon_agent_wechat_commission"];
    [_chatBtn setImage:chatImg forState:UIControlStateNormal];
    [_chatBtn setImage:chatImg forState:UIControlStateHighlighted];
    [_chatBtn setImageEdgeInsets:UIEdgeInsetsMake(3, 30, 3, 50)];
    
    NSString *title = @"微聊";
    [_chatBtn setTitle:title forState:UIControlStateNormal];
    [_chatBtn setTitle:title forState:UIControlStateHighlighted];
    [_chatBtn setTitleEdgeInsets:UIEdgeInsetsMake(6, 20, 5, 5)];
    
    // 交互
    [_chatBtn addTarget:self action:@selector(gotoChatDetailPage) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoBrokerDetailPage)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)configWithBroker:(AGJBroker *)broker
{
    self.brokerData = broker;
    if (broker.avatar && ![broker.avatar isEqualToString:@""]) {
        [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:broker.avatar] placeholderImage:[UIImage imageNamed:@"broker_default"]];
    } else {
        self.avatarImgView.image = [UIImage imageNamed:@"broker_default"];
    }
    if (broker.isGoldMedal && [broker.isGoldMedal isEqualToString:@"1"]) {
        self.goldTagImgView.hidden = NO;
    } else {
        self.goldTagImgView.hidden = YES;
    }
    
    self.nameLabel.text = broker.name;
    
    NSString *goodNum = [NSString stringWithFormat:@"%@条", broker.visitReviewGoodCount];
    self.goodReviewNumLabel.attributedText = [self generateAttributedStringWithString:goodNum];
    
    NSString *goodRate = [NSString stringWithFormat:@"%@%%", broker.reviewVisitRate];
    self.goodRateLabel.attributedText = [self generateAttributedStringWithString:goodRate];
    
    NSString *dealCount = [NSString stringWithFormat:@"%@套", broker.dealCount];
    self.dealCountLabel.attributedText = [self generateAttributedStringWithString:dealCount];
    
    // 最多两行
    self.surroundAreaLabel.text = broker.surroundingArea;
}

#pragma mark - private method

- (NSMutableAttributedString *)generateAttributedStringWithString:(NSString *)str
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str.length - 1, 1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x8D8C92 alpha:1] range:NSMakeRange(str.length - 1, 1)];
    return attrString;
}

#pragma mark - delegate
- (void)gotoBrokerDetailPage
{
    if (self.goldBrokerDelegate && [self.goldBrokerDelegate respondsToSelector:@selector(gotoBrokerDetailPage:)]) {
        [self.goldBrokerDelegate gotoBrokerDetailPage:self.brokerData];
    }
}

- (void)gotoChatDetailPage
{
    if (self.goldBrokerDelegate && [self.goldBrokerDelegate respondsToSelector:@selector(gotoChatDetailPage:)]) {
        [self.goldBrokerDelegate gotoChatDetailPage:self.brokerData];
    }
}

@end
