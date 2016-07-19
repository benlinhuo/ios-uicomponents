//
//  AGJHomeFindHouseAdapter.h
//  Angejia
//
//  Created by Liulexun on 16/4/27.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGJHomeFunctionContainerView.h"

@protocol AGJHomeFindHouseAdapterDelegate <NSObject>

- (void)findHouseTableViewDidScrollView:(UIScrollView *)scrollView;

@end

@interface AGJHomeFindHouseAdapter : NSObject <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <AGJHomeFindHouseAdapterDelegate> delegate;

@end
