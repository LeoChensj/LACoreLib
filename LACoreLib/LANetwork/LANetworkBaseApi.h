//
//  LANetworkBaseApi.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/22.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LANetworkError.h"


#pragma mark - ENUM
typedef NS_ENUM(NSInteger , LARequestMethod) {
    LARequestMethodGet = 0,
    LARequestMethodPost,
    LARequestMethodHead,
    LARequestMethodPut,
    LARequestMethodDelete,
    LARequestMethodPatch
};

typedef NS_ENUM(NSInteger , LARequestSerializerType) {
    LARequestSerializerTypeHTTP = 0,
    LARequestSerializerTypeJSON,
};

typedef NS_ENUM(NSInteger , LAResponseSerializerType) {
    LAResponseSerializerTypeHTTP = 0,
    LAResponseSerializerTypeJSON,
};



#pragma mark - Callback Block Define
@class LANetworkBaseApi;
typedef void (^LANetworkBaseApiSuccessBlock)(LANetworkBaseApi *api, NSObject *responseData);
typedef void (^LANetworkBaseApiFailBlock)(LANetworkBaseApi *api, LANetworkError *error);






@interface LANetworkBaseApi : NSObject

/*
 requestTask
 */
@property (nonatomic, strong, readonly) NSURLSessionDataTask *requestTask;


/*
 url
 */
@property (nonatomic, strong, readonly) NSString *baseDevUrl;
@property (nonatomic, strong, readonly) NSString *baseTestUrl;
@property (nonatomic, strong, readonly) NSString *basePreUrl;
@property (nonatomic, strong, readonly) NSString *baseProUrl;

@property (nonatomic, strong, readonly) NSString *requestUrl;

/*
 超时时间
 */
@property (nonatomic, assign, readonly) NSTimeInterval requestTimeoutInterval;

/*
 请求头 header
 */
@property (nonatomic, strong, readonly) NSDictionary *requestHeaders;

/*
 请求参数
 */
@property (nonatomic, strong, readonly) NSDictionary *requestParam;

/*
 请求方法
 */
@property (nonatomic, assign, readonly) LARequestMethod requestMethod;


/*
 请求的SerializerType
 */
@property (nonatomic, assign, readonly) LARequestSerializerType requestSerializerType;

/*
 返回的SerializerType
 */
@property (nonatomic, assign, readonly) LAResponseSerializerType responseSerializerType;

/*
 返回数据
 */
@property (nonatomic, strong, readonly) NSDictionary *responseDict;


/*
 成功回调
 */
@property (nonatomic, strong, readonly) LANetworkBaseApiSuccessBlock blockSuccess;

/*
 失败回调
 */
@property (nonatomic, strong, readonly) LANetworkBaseApiFailBlock blockFail;





#pragma mark - Config
/*
 基础开发url
 */
- (NSString *)configBaseDevUrl;

/*
 基础测试url
 */
- (NSString *)configBaseTestUrl;

/*
 基础预发布url
 */
- (NSString *)configBasePreUrl;

/*
 基础生产url
 */
- (NSString *)configBaseProUrl;

/*
 url后缀，或者整个url
 */
- (NSString *)configRequestUrl;

/*
 配置超时时间
 默认:60s
 */
- (NSTimeInterval)configRequestTimeoutInterval;

/*
 配置请求头
 */
- (NSDictionary *)configRequestHeaders;

/*
 配置请求方法
 默认:Get
 */
- (LARequestMethod)configRequestMethod;

/*
 配置请求参数
 */
- (NSDictionary *)configRequestParam;

/*
 配置请求数据格式
 默认:HTTP
 */
- (LARequestSerializerType)configRequestSerializerType;

/*
 配置响应数据格式
 默认:HTTP
 */
- (LAResponseSerializerType)configResponseSerializerType;

/*
 配置业务返回码对应的key
 默认:code
 */
- (NSString *)configKeyForCode;

/*
 配置业务返回msg对应的key
 默认:msg
 */
- (NSString *)configKeyForMsg;

/*
 配置返回码成功条件
 默认:返回码等于0表示业务成功
 */
- (BOOL)configRetCodeSuccessCondition;





#pragma mark - Helper
/*
 检查respCode，返回是否业务成功
 */
- (BOOL)checkRetCodeIsSuccess;

/*
 获取接口返回码
 */
- (NSInteger)getRetCode;

/*
 获取接口返回msg
 */
- (NSString *)getRetMsg;



#pragma mark - Request
/*
 发起请求
 */
- (void)requestWithSuccess:(LANetworkBaseApiSuccessBlock)blockSuccess
                      fail:(LANetworkBaseApiFailBlock)blockFail;

/*
 取消请求
 */
- (void)cancel;


@end
