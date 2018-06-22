//
//  LANetworkManager.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/22.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LANetworkManager.h"
#import "AFNetworking.h"
#import "LABase.h"



@interface LANetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end


@implementation LANetworkManager

LA_SINGLE_IMP


- (LANetworkStatus)status
{
    return (LANetworkStatus)([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
}

- (BOOL)isAvailable
{
    return ([self isWWAN] || [self isWiFi]);
}

- (BOOL)isWWAN
{
    return (self.status == LANetworkStatusReachableViaWWAN);
}

- (BOOL)isWiFi
{
    return (self.status == LANetworkStatusReachableViaWiFi);
}



- (void)startMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)stopMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}








- (void)addRequest:(LANetworkBaseApi *)api
{
    LARequestMethod method = api.requestMethod;
    
    NSString *url = [self buildUrl:api];
    
    NSDictionary *requestParam = api.requestParam;
    
    
    if(api.requestSerializerType == LARequestSerializerTypeHTTP)
    {
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    else if(api.requestSerializerType == LARequestSerializerTypeJSON)
    {
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    if (api.responseSerializerType == LAResponseSerializerTypeHTTP)
    {
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    else if (api.responseSerializerType == LAResponseSerializerTypeJSON)
    {
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    self.manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    self.manager.requestSerializer.timeoutInterval = api.requestTimeoutInterval;
    
    
    NSDictionary *header = api.requestHeaders;
    if(header)
    {
        for (id key in header.allKeys)
        {
            id value = [header objectForKey:key];
            
            if(LA_IS_STRING(key) && LA_IS_STRING(value))
            {
                [self.manager.requestSerializer setValue:value forHTTPHeaderField:key];
            }
        }
    }
    
    
    
    switch (method) {
        case LARequestMethodGet:
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                LA_WS(ws);
                NSURLSessionDataTask *task = [self.manager GET:url parameters:requestParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws successCallBackWithApi:api response:responseObject];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws failCallBackWithApi:api error:error];
                    
                }];
                
                [api setValue:task forKey:@"requestTask"];
            }
            break;
            
        case LARequestMethodPost:
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                LA_WS(ws);
                NSURLSessionDataTask *task = [self.manager POST:url parameters:requestParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws successCallBackWithApi:api response:responseObject];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws failCallBackWithApi:api error:error];
                    
                }];
                
                [api setValue:task forKey:@"requestTask"];
            }
            break;
            
        case LARequestMethodHead:
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                LA_WS(ws);
                NSURLSessionDataTask *task = [self.manager HEAD:url parameters:requestParam success:^(NSURLSessionDataTask * _Nonnull task) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws successCallBackWithApi:api response:nil];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws failCallBackWithApi:api error:error];
                    
                }];
                
                [api setValue:task forKey:@"requestTask"];
            }
            break;
            
        case LARequestMethodPut:
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                LA_WS(ws);
                NSURLSessionDataTask *task = [self.manager PUT:url parameters:requestParam success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws successCallBackWithApi:api response:responseObject];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws failCallBackWithApi:api error:error];
                    
                }];
                
                [api setValue:task forKey:@"requestTask"];
            }
            break;
            
        case LARequestMethodDelete:
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                LA_WS(ws);
                NSURLSessionDataTask *task = [self.manager DELETE:url parameters:requestParam success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws successCallBackWithApi:api response:responseObject];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws failCallBackWithApi:api error:error];
                    
                }];
                
                [api setValue:task forKey:@"requestTask"];
            }
            break;
            
        case LARequestMethodPatch:
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                LA_WS(ws);
                NSURLSessionDataTask *task = [self.manager PATCH:url parameters:requestParam success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws successCallBackWithApi:api response:responseObject];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [ws failCallBackWithApi:api error:error];
                    
                }];
                
                [api setValue:task forKey:@"requestTask"];
            }
            break;
            
            
        default:
            break;
    }
    
}

- (void)cancelRequest:(LANetworkBaseApi *)api
{
    [api.requestTask cancel];
    api = nil;
}






#pragma mark - Helper
- (NSString *)buildUrl:(LANetworkBaseApi *)api
{
    NSString *baseUrl = api.baseUrl;
    NSString *requestUrl = api.requestUrl;
    
    if([requestUrl la_isBeginsWith:@"http"] || [requestUrl la_isBeginsWith:@"https"])
    {
        return requestUrl;
    }
    
    return [NSString stringWithFormat:@"%@%@", baseUrl, requestUrl];
}

- (void)successCallBackWithApi:(LANetworkBaseApi *)api
                      response:(id)responseObject
{
    if(!responseObject)
    {  
        if(api.requestMethod == LARequestMethodHead)
        {
            api.blockSuccess ?
            api.blockSuccess(api, nil) :
            nil;
        }
        else
        {
            LANetworkError *error = [LANetworkError errorWithUrl:[self buildUrl:api]
                                                            type:LANetworkErrorTypeDataError];
            api.blockFail ?
            api.blockFail(api, error) :
            nil;
        }
        
        return;
    }
    
//#warning 解密
    NSString *respString = nil;
    if(api.responseSerializerType == LAResponseSerializerTypeHTTP)
    {
        respString = [[NSString alloc] initWithData:responseObject
                                           encoding:NSUTF8StringEncoding];
    }
    else if(api.responseSerializerType == LAResponseSerializerTypeJSON)
    {
        respString = responseObject;
    }
    
    NSDictionary *respDict = [respString la_toDictionary];
    
    
    [api setValue:respDict forKey:@"responseDict"];
    
    

    if([api checkRespCode])
    {
#warning nil -> response
        api.blockSuccess ?
        api.blockSuccess(api, nil) :
        nil;
    }
    else
    {
        LANetworkError *error = [LANetworkError errorWithUrl:[self buildUrl:api]
                                                        type:LANetworkErrorTypeCodeFail];
        api.blockFail ?
        api.blockFail(api, error) :
        nil;
    }
}

- (void)failCallBackWithApi:(LANetworkBaseApi *)api
                      error:(NSError *)err
{
    LANetworkError *error;
    if([self isAvailable])
    {
        error = [LANetworkError errorWithUrl:[self buildUrl:api]
                                        type:LANetworkErrorTypeServerDown];
    }
    else
    {
        error = [LANetworkError errorWithUrl:[self buildUrl:api]
                                        type:LANetworkErrorTypeNoNetwork];
    }
    
    api.blockFail ?
    api.blockFail(api, error) :
    nil;
}



#pragma mark - Reader
- (AFHTTPSessionManager *)manager
{
    if(!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}


- (void)dealloc
{
    LALog(@"dealloc-%@", NSStringFromClass([self class]));
}

@end
