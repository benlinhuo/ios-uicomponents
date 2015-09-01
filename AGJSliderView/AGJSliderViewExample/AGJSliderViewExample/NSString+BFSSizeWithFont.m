//
//  NSString+BFSSizeWithFont.m
//  BIFService
//
//  Created by wysasun on 14/12/3.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import "NSString+BFSSizeWithFont.h"

@implementation NSString (BFSSizeWithFont)

- (CGSize)rtSizeWithFont:(UIFont *)font{
    CGSize returnSize = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    returnSize.height = ceilf(returnSize.height);
    return returnSize;
}

- (CGSize)rtSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize returnSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:font}
                                           context:nil].size;
    returnSize.height = ceilf(returnSize.height);
    return returnSize;
}

- (CGSize)rtSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode{
    CGSize returnSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:font}
                                           context:nil].size;
    returnSize.height = ceilf(returnSize.height);
    return returnSize;
}

@end
