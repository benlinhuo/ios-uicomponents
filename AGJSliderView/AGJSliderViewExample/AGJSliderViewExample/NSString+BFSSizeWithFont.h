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

@end
