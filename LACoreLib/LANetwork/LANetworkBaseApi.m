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

@property (nonatomic, strong) NSString *baseDevUrl;
@property (nonatomic, strong) NSString *baseTestUrl;
@property (nonatomic, strong) NSString *basePreUrl;
@property (nonatomic, strong) NSString *baseProUrl;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;
@property (nonatomic, strong) NSDictionary *requestHeaders;
@property (nonatomic, strong) NSDictionary *requestParam;
@property (nonatomic, assign) LARequestMethod requestMethod;
@property (nonatomic, assign) LARequestSerializerType requestSerializerType;
@property (nonatomic, assign) LAResponseSerializerType responseSerializerType;
@property (nonatomic, strong) NSString *response;
@property (nonatomic, strong) LANetworkBaseApiSuccessBlock blockSuccess;
@property (nonatomic, strong) LANetworkBaseApiFailBlock blockFail;

@end




@implementation LANetworkBaseApi

- (instancetype)init
{
    if(self = [super init])
    {
        self.baseDevUrl = [self configBaseDevUrl];
        self.baseTestUrl = [self configBaseTestUrl];
        self.basePreUrl = [self configBasePreUrl];
        self.baseProUrl = [self configBaseProUrl];
        self.requestUrl = [self configRequestUrl];
        self.requestTimeoutInterval = [self configRequestTimeoutInterval];
        self.requestHeaders = [self configRequestHeaders];
        self.requestMethod = [self configRequestMethod];
        self.requestParam = [self configRequestParam];
        self.requestSerializerType = [self configRequestSerializerType];
        self.responseSerializerType = [self configResponseSerializerType];
    }
    
    return self;
}



- (NSString *)configBaseDevUrl
{
    return nil;
}

- (NSString *)configBaseTestUrl
{
    return nil;
}

- (NSString *)configBasePreUrl
{
    return nil;
}

- (NSString *)configBaseProUrl
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

- (LARequestMethod)configRequestMethod
{
    return LARequestMethodGet;
}

- (NSDictionary *)configRequestParam
{
    return nil;
}

- (LARequestSerializerType)configRequestSerializerType
{
    return LARequestSerializerTypeHTTP;
}

- (LAResponseSerializerType)configResponseSerializerType
{
    return LAResponseSerializerTypeHTTP;
}

- (NSString *)configKeyForCode
{
    return @"code";
}

- (NSString *)configKeyForMsg
{
    return @"msg";
}

- (BOOL)configRetCodeSuccessCondition
{
    return ([self getRetCode] == 0);
}





- (BOOL)checkRetCodeIsSuccess
{
    return [self configRetCodeSuccessCondition];
}

- (NSInteger)getRetCode
{
    if(self.responseDict)
    {
        NSNumber *retCode = [self.responseDict objectForKey:[self configKeyForCode]];
        
        return retCode.integerValue;
    }
    
    return LANetworkErrorTypeUnknown;
}

- (NSString *)getRetMsg
{
    if(self.responseDict)
    {
        return [self.responseDict objectForKey:[self configKeyForMsg]];
    }
    
    return nil;
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



- (void)dealloc
{
    LALog(@"dealloc-%@", NSStringFromClass([self class]));
}

@end
