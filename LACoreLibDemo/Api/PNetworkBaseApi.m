//
//  PNetworkBaseApi.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/25.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "PNetworkBaseApi.h"

@implementation PNetworkBaseApi

- (NSString *)configBaseDevUrl
{
    return @"http://127.0.0.1:8080";
}

- (NSString *)configBaseTestUrl
{
    return @"";
}

- (NSString *)configBasePreUrl
{
    return @"";
}

- (NSString *)configBaseProUrl
{
    return @"";
}

- (NSString *)configKeyForCode
{
    return @"retCode";
}

- (NSString *)configKeyForMsg
{
    return @"retMsg";
}

- (BOOL)configRetCodeSuccessCondition
{
    return ([self getRetCode] >= 0);
}

@end
