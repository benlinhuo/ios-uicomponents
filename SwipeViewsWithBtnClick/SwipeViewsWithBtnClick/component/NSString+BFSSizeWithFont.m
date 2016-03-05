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

// 专门为微聊中16号字体计算高度（性能优化）,目前只有 BIFChatMessageTextCell 这个类用到了
- (CGSize)rtSizeWithFont16AndConstrainedWidth:(CGFloat)width
{
    CGFloat oneLineheight = 20.f; // 一行的高度
    CGFloat oneWordWidth = 16.f;
    return [self baseCalculateTextSizeWithOneLineHeight:oneLineheight oneWordWidth:oneWordWidth width:width];
    
}

- (CGSize)rtSizeWithFont14AndConstrainedWidth:(CGFloat)width
{
    CGFloat oneLineheight = 18.f; // 一行的高度
    CGFloat oneWordWidth = 16.f;
    return [self baseCalculateTextSizeWithOneLineHeight:oneLineheight oneWordWidth:oneWordWidth width:width];
}

- (CGSize)baseCalculateTextSizeWithOneLineHeight:(CGFloat)oneLineheight oneWordWidth:(CGFloat)oneWordWidth width:(CGFloat)width
{
    NSInteger lineCount = ceil((self.length * oneWordWidth) / width);
    CGFloat allWidth = width; // 大于等于一行
    if (lineCount == 1) {
        allWidth = self.length * oneWordWidth;
    }
    return CGSizeMake(allWidth, lineCount * oneLineheight);
}

- (NSString *)htmlStringRule
{
    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                      options:0
                                                                                        error:nil];
    
    NSString *tempStr = [NSString stringWithString:self];
    
    tempStr =[regularExpretion stringByReplacingMatchesInString:tempStr options:NSMatchingReportProgress range:NSMakeRange(0, tempStr.length) withTemplate:@""];//替换所有html和换行匹配元素为"-"
    
    regularExpretion =[NSRegularExpression regularExpressionWithPattern:@"-{1,}" options:0 error:nil] ;
    tempStr = [regularExpretion stringByReplacingMatchesInString:tempStr options:NSMatchingReportProgress range:NSMakeRange(0, tempStr.length) withTemplate:@""];//把多个"-"匹配为一个"-"
    return tempStr;
}

@end
