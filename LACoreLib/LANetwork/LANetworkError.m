//
//  LANetworkError.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/22.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LANetworkError.h"


@interface LANetworkError ()

@property (nonatomic, strong, readwrite) NSString *url;
@property (nonatomic, assign, readwrite) NSInteger code;
@property (nonatomic, strong, readwrite) NSString *msg;

@end



@implementation LANetworkError

+ (instancetype)errorWithUrl:(NSString *)url
                        type:(LANetworkErrorType)type
{
    LANetworkError *error = [[LANetworkError alloc] init];
    error.url = url;
    
    if(type == LANetworkErrorTypeNoNetwork)
    {
        error.code = LANetworkErrorTypeNoNetwork;
        error.msg = @"没有网络";
    }
    else if(type == LANetworkErrorTypeServerDown)
    {
        error.code = LANetworkErrorTypeServerDown;
        error.msg = @"服务器宕机";
    }
    else if(type == LANetworkErrorTypeCodeFail)
    {
        error.code = LANetworkErrorTypeCodeFail;
        error.msg = @"接口业务失败";
    }
    else if(type == LANetworkErrorTypeDataError)
    {
        error.code = LANetworkErrorTypeDataError;
        error.msg = @"返回数据错误";
    }
    else
    {
        error.code = LANetworkErrorTypeUnknown;
        error.msg = @"未知错误";
    }
    
    return error;
}

+ (instancetype)errorWithUrl:(NSString *)url
                        code:(NSInteger)code
                         msg:(NSString *)msg
{
    LANetworkError *error = [[LANetworkError alloc] init];
    error.url = url;
    error.code = code;
    error.msg = msg;
    
    return error;
}

@end
