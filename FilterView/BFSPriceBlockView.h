//
//  FBPriceBlockView.h
//  iFangBroker
//
//  Created by 成桂 余 on 15/7/21.
//  Copyright (c) 2015年 Angejia Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedPriceBlock)(NSString *minPrice, NSString *maxPrice);

@interface BFSPriceBlockView : UIView <UITextFieldDelegate>

@property (nonatomic, strong)UILabel *promptLabel;
@property (nonatomic, strong)UITextField *minPrice;
@property (nonatomic, strong)UITextField *maxPrice;
@property (nonatomic, strong)UILabel *lineLabel;
@property (nonatomic, strong)UILabel *unitLabel;
@property (nonatomic, strong)UIButton *operationButton;

@property (nonatomic, strong) SelectedPriceBlock selectedPriceBlock;

@end
