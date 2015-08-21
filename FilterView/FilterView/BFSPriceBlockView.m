//
//  FBPriceBlockView.m
//  iFangBroker
//
//  Created by 成桂 余 on 15/7/21.
//  Copyright (c) 2015年 Angejia Inc. All rights reserved.
//

#import "BFSPriceBlockView.h"
#import "BFSMacros.h"
#import "UILabel+BFSStyle.h"
#import "UIButton+BFSStyle.h"
#import "UIColor+BFS.h"
#import "UIView+BFS.h"
#import "UIColor+BFS.h"
#import "NSString+BFSSizeWithFont.h"

@implementation BFSPriceBlockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0xf1f1f1 alpha:1.0];
        [self initView];
    }
    
    return self;
}

- (void)initView
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BFS_ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHex:0xDEDEE2 alpha:1.0];
    
    [self addSubview:lineView];
    
    CGSize size = [@"自定义价格:-万元" rtSizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(BFS_ScreenWidth, 999) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat width = (BFS_ScreenWidth - size.width - 30 - 15 - 6) / 3;
    
    _promptLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_promptLabel setFont:[UIFont systemFontOfSize:14] withColor:[UIColor colorWithHex:0x000000 alpha:1.0] andText:@"自定义价格:"];
    [_promptLabel sizeToFit];
    _promptLabel.centerY = self.centerY;
    _promptLabel.left = 15;
    
    [self addSubview:_promptLabel];
    
    _minPrice = [[UITextField alloc] initWithFrame:CGRectMake(_promptLabel.right + 5, 0, width, 25)];
    _minPrice.placeholder = @"最低";
    [_minPrice setFont:[UIFont systemFontOfSize:14]];
    _minPrice.centerY = self.centerY;
    _minPrice.layer.borderColor = [[UIColor colorWithHex:0xDEDEE2 alpha:1.0] CGColor];
    _minPrice.layer.borderWidth = 0.5;
    _minPrice.layer.masksToBounds = YES;
    _minPrice.returnKeyType = UIReturnKeyNext;
    _minPrice.tag = 1001;
    _minPrice.delegate = self;
    _minPrice.keyboardType = UIKeyboardTypeNumberPad;
    
    [self addSubview:_minPrice];
    
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_lineLabel setFont:[UIFont systemFontOfSize:14] withColor:[UIColor colorWithHex:0x000000 alpha:1.0] andText:@"-"];
    [_lineLabel sizeToFit];
    _lineLabel.centerY = self.centerY;
    _lineLabel.left = _minPrice.right + 3;
    
    [self addSubview:_lineLabel];
    
    _maxPrice = [[UITextField alloc] initWithFrame:CGRectMake(_lineLabel.right + 3, 0, width, 25)];
    _maxPrice.placeholder = @"最高";
    [_maxPrice setFont:[UIFont systemFontOfSize:14]];
    _maxPrice.centerY = self.centerY;
    _maxPrice.layer.borderColor = [[UIColor colorWithHex:0xDEDEE2 alpha:1.0] CGColor];
    _maxPrice.layer.borderWidth = 0.5;
    _maxPrice.layer.masksToBounds = YES;
    _minPrice.returnKeyType = UIReturnKeyDone;
    _minPrice.tag = 1002;
    _maxPrice.delegate = self;
    _maxPrice.keyboardType = UIKeyboardTypeNumberPad;
    
    [self addSubview:_maxPrice];
    
    _unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_unitLabel setFont:[UIFont systemFontOfSize:14] withColor:[UIColor colorWithHex:0x000000 alpha:1.0] andText:@"万元"];
    [_unitLabel sizeToFit];
    _unitLabel.centerY = self.centerY;
    _unitLabel.left = _maxPrice.right + 5;
    
    [self addSubview:_unitLabel];
    
    _operationButton = [[UIButton alloc] initWithFrame:CGRectMake(_unitLabel.right + 5, 0, width, 25)];
    _operationButton.centerY = self.centerY;
    [_operationButton setBackgroundColor:[UIColor colorWithHex:0x3EA0DD alpha:1.0]];
    _operationButton.layer.cornerRadius = 2.0;
    _operationButton.layer.masksToBounds = YES;
    [_operationButton setTitle:@"确定" titleFont:[UIFont systemFontOfSize:14] titleColor:[UIColor colorWithHex:0xFFFFFF alpha:1.0]];
    [_operationButton addTarget:self action:@selector(clickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_operationButton];
}

- (void)clickOperationButton:(UIButton *)button
{
    [_minPrice resignFirstResponder];
    [_maxPrice resignFirstResponder];
    
    NSString *minPrice = _minPrice.text;
    NSString *maxPrice = _maxPrice.text;
    
    if (minPrice.length == 0 && maxPrice.length == 0) {
        return;
    }
    if (minPrice.length && maxPrice.length)
    {
        if ([minPrice integerValue] > [maxPrice integerValue]) {
            return;
        }
    }
    
    if (self.selectedPriceBlock) {
        self.selectedPriceBlock(minPrice, maxPrice);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 1001:
            [_maxPrice becomeFirstResponder];
            break;
            
        case 1002:
            [_maxPrice resignFirstResponder];
            break;
            
        default:
            break;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

@end
