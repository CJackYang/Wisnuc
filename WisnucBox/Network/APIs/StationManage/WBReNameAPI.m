//
//  WBReNameAPI.m
//  WisnucBox
//
//  Created by wisnuc-imac on 2017/11/29.
//  Copyright © 2017年 JackYang. All rights reserved.
//

#import "WBReNameAPI.h"

@implementation WBReNameAPI
+ (instancetype)apiWithName:(NSString *)name{
    WBReNameAPI * api = [WBReNameAPI new];
    api.name = name;
    return api;
}
- (JYRequestMethod)requestMethod{
    return JYRequestMethodPatch;
}


/// 请求的URL
- (NSString *)requestUrl{
    return WB_UserService.currentUser.isCloudLogin ? [NSString stringWithFormat:@"%@%@?resource=%@&method=PATCH", kCloudAddr, kCloudCommonJsonUrl, [@"station/info" base64EncodedString]] : @"station/info";
}

- (id)requestArgument{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_name,@"name", nil];
    return dic;
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:(WB_UserService.currentUser.isCloudLogin ? WB_UserService.currentUser.cloudToken : [NSString stringWithFormat:@"JWT %@", WB_UserService.defaultToken]) forKey:@"Authorization"];
    return dic;
}
@end
