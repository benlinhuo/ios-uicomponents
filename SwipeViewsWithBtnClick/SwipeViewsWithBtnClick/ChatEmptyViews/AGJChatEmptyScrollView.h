//
//  AGJChatEmptyScrollView.h
//  Angejia
//
//  Created by benlinhuo on 16/3/3.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import "AGJCustomView.h"
#import "AGJBroker.h"

@protocol AGJChatEmptyScrollViewDelegate <NSObject>

- (void)gotoBrokerDetailPage:(AGJBroker *)broker;
- (void)gotoChatDetailPage:(AGJBroker *)broker;

@end

@interface AGJChatEmptyScrollView : AGJCustomView

@property (nonatomic, weak) id<AGJChatEmptyScrollViewDelegate> emptyDelegate;

- (void)showContentData;

@end
