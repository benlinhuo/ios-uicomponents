//
//  JKButton.m
//  ChartLibraryCustom
//
//  Created by benlinhuo on 15/9/20.
//  Copyright © 2015年 benlinhuo. All rights reserved.
//

#import "JKButton.h"

@implementation JKButton

// 复写
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW) / 2;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
