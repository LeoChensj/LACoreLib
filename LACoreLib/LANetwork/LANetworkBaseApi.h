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
typedef void (^LANetworkBaseApiSuccessBlock)(__kindof LANetworkBaseApi *api, __kindof NSObject *responseData);
typedef void (^LANetworkBaseApiFailBlock)(__kindof LANetworkBaseApi *api, LANetworkError *error);






@interface LANetworkBaseApi : NSObject


/*
 requestTask
 */
@property (nonatomic, strong, readonly) NSURLSessionDataTask *requestTask;

/*
 url
 */
@property (nonatomic, strong, readonly) NSString *baseUrl;
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
- (NSString *)configBaseUrl;

- (NSString *)configRequestUrl;

- (NSTimeInterval)configRequestTimeoutInterval;

- (NSDictionary *)configRequestHeaders;

- (NSDictionary *)configRequestParam;

- (LARequestMethod)configRequestMethod;

- (LARequestSerializerType)configRequestSerializerType;

- (LAResponseSerializerType)configResponseSerializerType;



/*
 检查respCode，返回是否业务成功
 */
- (BOOL)checkRespCode;





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
