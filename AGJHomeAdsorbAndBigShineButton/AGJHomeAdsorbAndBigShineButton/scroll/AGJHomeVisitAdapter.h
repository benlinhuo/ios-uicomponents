//
//  AGJHomeVisitAdapter.h
//  Angejia
//
//  Created by Liulexun on 16/4/28.
//  Copyright © 2016年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AGJHomeVisitAdapterDelegate <NSObject>

- (void)visitTableViewDidScrollView:(UIScrollView *)scrollView;
@end

@interface AGJHomeVisitAdapter : NSObject <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id <AGJHomeVisitAdapterDelegate> delegate;

@end
