//
//  LANetworkBaseApi.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/22.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LANetworkBaseApi.h"
#import "LANetworkManager.h"


@interface LANetworkBaseApi ()

@property (nonatomic, strong, readwrite) NSString *baseUrl;
@property (nonatomic, strong, readwrite) NSString *requestUrl;
@property (nonatomic, assign, readwrite) NSTimeInterval requestTimeoutInterval;
@property (nonatomic, strong, readwrite) NSDictionary *requestHeaders;
@property (nonatomic, strong, readwrite) NSDictionary *requestParam;
@property (nonatomic, assign, readwrite) LARequestMethod requestMethod;
@property (nonatomic, assign, readwrite) LARequestSerializerType requestSerializerType;
@property (nonatomic, assign, readwrite) LAResponseSerializerType responseSerializerType;
@property (nonatomic, strong, readwrite) NSString *response;
@property (nonatomic, strong, readwrite) LANetworkBaseApiSuccessBlock blockSuccess;
@property (nonatomic, strong, readwrite) LANetworkBaseApiFailBlock blockFail;

@end




@implementation LANetworkBaseApi

- (instancetype)init
{
    if(self = [super init])
    {
        self.baseUrl = [self configBaseUrl];
        self.requestUrl = [self configRequestUrl];
        self.requestTimeoutInterval = [self configRequestTimeoutInterval];
        self.requestHeaders = [self configRequestHeaders];
        self.requestParam = [self configRequestParam];
        self.requestMethod = [self configRequestMethod];
        self.requestSerializerType = [self configRequestSerializerType];
        self.responseSerializerType = [self configResponseSerializerType];
    }
    
    return self;
}





- (NSString *)configBaseUrl
{
    return nil;
}

- (NSString *)configRequestUrl
{
    return nil;
}

- (NSTimeInterval)configRequestTimeoutInterval
{
    return 60;
}

- (NSDictionary *)configRequestHeaders
{
    return nil;
}

- (NSDictionary *)configRequestParam
{
    return nil;
}

- (LARequestMethod)configRequestMethod
{
    return LARequestMethodGet;
}

- (LARequestSerializerType)configRequestSerializerType
{
    return LARequestSerializerTypeHTTP;
}

- (LAResponseSerializerType)configResponseSerializerType
{
    return LAResponseSerializerTypeHTTP;
}


- (BOOL)checkRespCode
{
    return YES;
}










- (void)requestWithSuccess:(LANetworkBaseApiSuccessBlock)blockSuccess
                      fail:(LANetworkBaseApiFailBlock)blockFail
{
    self.blockSuccess = blockSuccess;
    self.blockFail = blockFail;
    
    [[LANetworkManager shareInstance] addRequest:self];
}

- (void)cancel
{
    [[LANetworkManager shareInstance] cancelRequest:self];
}


@end
