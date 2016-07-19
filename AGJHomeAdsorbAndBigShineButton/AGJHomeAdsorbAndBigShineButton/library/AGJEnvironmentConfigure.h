//
//  AGJEnvironmentConfigure.h
//  Angejia
//
//  Created by zhujinhui on 15/9/22.
//  Copyright © 2015年 Plan B Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define weakify(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define strongify(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#define IPHONE6 ((fabs([UIScreen mainScreen].bounds.size.width - 375) < 1)?YES:NO)
#define IPHONE6PLUS ((fabs([UIScreen mainScreen].bounds.size.width - 414) < 1)?YES:NO)
#define IPHONE4_AND_4S ((fabs([UIScreen mainScreen].bounds.size.width - 320) < 1) && (fabs([UIScreen mainScreen].bounds.size.height - 480) < 1)?YES:NO)
#define IPHONE5_AND_5S ((fabs([UIScreen mainScreen].bounds.size.width - 320) < 1) && (fabs([UIScreen mainScreen].bounds.size.height - 568) < 1)?YES:NO)

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define iOS7_0 @"7.0"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define APP_DELEGATE   [UIApplication sharedApplication].delegate
#define APP_ROOTVIEWCONTROLLER ((UIViewController *) ((AppDelegate *) [UIApplication sharedApplication].delegate).window.rootViewController)


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
#define MAX_ALLOWED_VERSION_GREATER_THAN_OR_EQUAL_TO_8
#endif

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)


#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define SetSafeStringNil(value) \
((value == nil) ? (@"") : ([NSString stringWithFormat:@"%@",value]))

#define IsStringNotNil(value) \
(value && value.length > 0)

#define IsArrayItemsCountMoreThanZero(value) \
((value) && ([value isKindOfClass:[NSArray class]]) && (value.count > 0))

#define AngejiaScheme @"openangejia"

/**
 * 小图
 */
#define IMAGE_URL_SIZE_ADAPTER_SMALL(imageUrl) [NSString stringWithFormat:@"%@?imageView2/0/w/%li",imageUrl,(long)SCREEN_WIDTH]

#define IMAGE_URL_SIZE_ADAPTER(imageUrl) [NSString stringWithFormat:@"%@?imageView2/0/w/%li",imageUrl,(long)SCREEN_WIDTH * 2]
#define IMAGE_URL_SIZE_ADAPTER2(imageUrl) [NSString stringWithFormat:@"%@?imageView2/0/w/%li",imageUrl,(long)(SCREEN_WIDTH * 1.5)]
//用于列表页小图， 100 x 75
#define IMAGE_URL_SIZE_ADAPTER_LIST(imageUrl) [NSString stringWithFormat:@"%@?imageView2/0/w/%d/h/%d", imageUrl, 100 * 2, 75 * 2]

#define IMAGE_URL_SIZE_ADAPTER_LIST2(imageUrl, width, height) [NSString stringWithFormat:@"%@?imageView2/0/w/%d/h/%d", imageUrl, width * 2, height * 2]
#define IMAGE_URL_SIZE_ADAPTER_LIST3(imageUrl, height) [NSString stringWithFormat:@"%@?imageView2/0/w/%li/h/%d", imageUrl, (long)SCREEN_WIDTH * 2, height * 2]


//schemes
#ifdef DEBUG
#define WeiXinScheme @"wxf802e263f3001aae"
#else
#define WeiXinScheme @"wx9a86bc1625cee986"
#endif

//-------------------以下是跟host相关的----------------------------

#define HOST_MOCK @"HOST_MOCK"

#define HOST_MASTER @""

#define HOST_ONLINE @"api.angejia.com"

#define HOST_DEBUG ([[[NSUserDefaults standardUserDefaults] stringForKey:@"version"] isEqualToString:@"online"] ? @"api.angejia.com" : ([NSString stringWithFormat:@"api.%@.%@.angejia.com",[[NSUserDefaults standardUserDefaults] stringForKey:@"version"],[[NSUserDefaults standardUserDefaults] stringForKey:@"enviorenment"]]))


#ifdef DEBUG

#define HOST HOST_DEBUG

#else

#define HOST HOST_ONLINE

#endif

//---------------------------------------------------------------

#define PIX_1 (1.0f/[UIScreen mainScreen].scale)


#define LOGINKEY_ONLINE @"d469cbdf558c33038b759cd96"
#define LOGINKEY_OFFLINE @"6f72dcdb"

#define APPKEY_WEIBO         @"2220067600"

#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"

#define PREFIX_APPURL_WEIBO @"wb2220067600://response"

extern NSString * const UMengAppKey;
extern NSString * const GaoDeAPIKey;
extern NSString * const ServerPhoneNumber;

