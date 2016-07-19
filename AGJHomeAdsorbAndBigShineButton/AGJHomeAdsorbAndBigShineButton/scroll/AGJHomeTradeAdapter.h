//
//  AGJHomeTradeAdapter.h
//  Angejia
//
//  Created by Liulexun on 16/5/13.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AGJHomeTradeAdapterDelegate <NSObject>

- (void)tradeTableViewdidScroll:(UIScrollView *)scrollView;

@end

@interface AGJHomeTradeAdapter : NSObject <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <AGJHomeTradeAdapterDelegate> delegate;
@end
