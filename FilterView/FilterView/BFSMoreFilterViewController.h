//
//  BFSMoreFilterViewController.h
//  iFangBroker
//
//  Created by wysasun on 14/12/20.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFSFilterItem.h"
@class BFSFilterView;
/**
 *  点击更多出来的viewcontroller
 */
@interface BFSMoreFilterViewController : UIViewController
@property (nonatomic, strong) NSArray *filterItems;
@property (nonatomic, weak) BFSFilterView *filterView;
@end
