//
//  AGJCustomView.m
//  Angejia
//
//  Created by kyson on 15/6/21.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import "AGJCustomView.h"

@implementation AGJCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(id) loadFromXibIfViewAtLastIndex{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

+(id) loadFromXibIfViewAtFirstIndex{
    NSLog(@"className = %@", [self class]);
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}



@end
