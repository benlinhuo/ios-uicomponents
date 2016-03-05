//
//  AGJGoldBrokerCardView.h
//  Angejia
//
//  Created by benlinhuo on 16/3/1.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJCustomView.h"
#import "AGJBroker.h"

@protocol AGJGoldBrokerCardViewDelegate <NSObject>

- (void)gotoBrokerDetailPage:(AGJBroker *)broker;
- (void)gotoChatDetailPage:(AGJBroker *)broker;

@end

@interface AGJGoldBrokerCardView : AGJCustomView

@property (nonatomic, weak) id<AGJGoldBrokerCardViewDelegate> goldBrokerDelegate;

@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
- (void)configWithBroker:(AGJBroker *)broker;

@end
