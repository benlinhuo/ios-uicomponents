//
//  NSString+BFSSizeWithFont.h
//  BIFService
//
//  Created by wysasun on 14/12/3.
//  Copyright (c) 2014年 Plan B Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (BFSSizeWithFont)

- (CGSize)rtSizeWithFont:(UIFont *)font;
- (CGSize)rtSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)rtSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

// 专门为微聊中16号字体计算高度（性能优化）,目前只有 BIFChatMessageTextCell 这个类用到了
- (CGSize)rtSizeWithFont16AndConstrainedWidth:(CGFloat)width;
- (CGSize)rtSizeWithFont14AndConstrainedWidth:(CGFloat)width;

//html正则表达，用来计算高度
- (NSString *)htmlStringRule;

@end
