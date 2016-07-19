//
//  AGJEnvironmentConfigure.m
//  Angejia
//
//  Created by zhujinhui on 15/9/22.
//  Copyright © 2015年 Plan B Inc. All rights reserved.
//

#import "AGJEnvironmentConfigure.h"

#if defined(DEBUG) && DEBUG
NSString * const UMengAppKey = @"54cef417fd98c546d2000d3f";
NSString * const GaoDeAPIKey = @"6ab5e3dbdb4140f005ed5f66270bba49";
NSString * const ServerPhoneNumber = @"4006561033";

#else
NSString * const UMengAppKey = @"54d1883efd98c5bc3e00072a";
NSString * const GaoDeAPIKey = @"e5137e5efe6e86404da449f64d272c3f";
NSString * const ServerPhoneNumber = @"4006561033";
#endif

#define USER_DEFAULTS_DEMAND_LIST               @"USER_DEFAULTS_DEMAND"
#define USER_DEFAULTS_APPCONFIG                 @"USER_DEFAULTS_APPCONFIG"
#define USER_DEFAULTS_SEARCHFILTER              @"USER_DEFAULTS_SEARCHFILTER"
#define USER_DEFAULTS_HASH_AREA                 @"USER_DEFAULTS_HASH_AREA"
#define USER_DEFAULTS_HASH_CITY                 @"USER_DEFAULTS_HASH_CITY"
#define USER_DEFAULTS_HASH_APPCONFIG            @"USER_DEFAULTS_HASH_APPCONFIG"
#define USER_DEFAULTS_ISAPIDEBUG                @"USER_DEFAULTS_ISAPIDEBUG"
#define USER_DEFAULTS_ISUPLOADERRORLOG                @"USER_DEFAULTS_ISUPLOADERRORLOG"
#define USER_DEFAULTS_CURRENTCITY             @"USER_DEFAULTS_CURRENTCITY"
#define USER_DEFAULTS_DISTRICTSOFCURRENTCITY(__CITYID)     [NSString stringWithFormat:@"USER_DEFAULTS_DISTRICTSOFCURRENTCITY.%@",__CITYID]


