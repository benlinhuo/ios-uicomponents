//
//  AGJSliderView.m
//  Angejia
//
//  Created by benlinhuo on 15/9/1.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import "AGJSliderView.h"
#import "NSString+BFSSizeWithFont.h"
#import "UIView+BFS.h"

@interface AGJSliderView ()

@property (nonatomic) BOOL isNeedAddTag;
@property (nonatomic, assign) CGFloat unitValue;
@property (nonatomic, assign) CGFloat endValue;
@property (nonatomic, assign) NSInteger currentFont;

@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentLabelConstant;

@end

@implementation AGJSliderView

- (void)configWithParams:(NSDictionary *)dict
{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat startValue = dict[@"startValue"] ? [dict[@"startValue"] floatValue] : 50;
    self.endValue = dict[@"endValue"] ? [dict[@"endValue"] floatValue] : 800;
    self.unitValue = dict[@"unitValue"] ? [dict[@"unitValue"] floatValue] : 5;
    NSString *startText = dict[@"startText"];
    NSString *endText = dict[@"endText"];
    self.currentFont = dict[@"currentFont"] ? [dict[@"currentFont"] integerValue] : 20;
    self.isNeedAddTag = [dict[@"isNeedAddTag"] boolValue];
    
    if (startText && ![startText isEqualToString:@""]) {
        self.leftLabel.text = startText;
    }
    if (endText && ![endText isEqualToString:@""]) {
        self.rightLabel.text = endText;
    }
    if (self.currentFont) {
        self.currentLabel.font = [UIFont systemFontOfSize:self.currentFont];
    }
    
    self.sliderView.minimumValue = 0;
    self.sliderView.maximumValue = (self.endValue - startValue) / self.unitValue;
    
    // UISlider
    CGFloat currentValue = dict[@"currentValue"] ? [dict[@"currentValue"] floatValue] : self.sliderView.minimumValue;
    self.sliderView.value = currentValue;
    
    [self.sliderView setMinimumTrackImage:[self setLeftPartImage] forState:UIControlStateNormal];
    [self.sliderView setMaximumTrackImage:[self setRightPartImage] forState:UIControlStateNormal];
    [self.sliderView setThumbImage:[self setThumbImage] forState:UIControlStateNormal];
    
    [self.sliderView addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderValueChange
{
    NSInteger sliderValue = round(self.sliderView.value);
    NSInteger value = sliderValue * self.unitValue + 50;
    NSString *valueStr = [NSString stringWithFormat:@"%ld", (long)value];
    if (value == self.endValue && self.isNeedAddTag) {
        valueStr = [NSString stringWithFormat:@"%ld+", (long)value];
    }
    self.currentLabel.text = [NSString stringWithFormat:@"%@", valueStr];
    //位置
    CGFloat width = [self.currentLabel.text rtSizeWithFont:[UIFont systemFontOfSize:self.currentFont]].width;
    self.currentLabelConstant.constant = self.sliderView.value / (self.sliderView.maximumValue + 12.5) * self.width + 12.5 - width / 2; //25 是圆圈的半径宽度

}

- (UIImage *)setLeftPartImage
{
    return [[UIImage imageNamed:@"Base1"] stretchableImageWithLeftCapWidth:4 topCapHeight:0];
}

- (UIImage *)setRightPartImage
{
    return [[UIImage imageNamed:@"Base"] stretchableImageWithLeftCapWidth:4 topCapHeight:0];
}

- (UIImage *)setThumbImage
{
    return [UIImage imageNamed:@"Rectangle"];
}

@end
