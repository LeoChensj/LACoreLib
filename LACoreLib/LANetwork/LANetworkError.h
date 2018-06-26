//
//  LANetworkError.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/22.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , LANetworkErrorType) {
    LANetworkErrorTypeUnknown = -10000,     //未知
    LANetworkErrorTypeNoNetwork,            //无网
    LANetworkErrorTypeServerDown,           //服务器宕机
    LANetworkErrorTypeCodeFail,             //接口业务失败
    LANetworkErrorTypeDataError,            //返回数据错误
};



@interface LANetworkError : NSObject

@property (nonatomic, strong, readonly) NSString *url;
@property (nonatomic, assign, readonly) NSInteger code;
@property (nonatomic, strong, readonly) NSString *msg;


+ (instancetype)errorWithUrl:(NSString *)url
                        type:(LANetworkErrorType)type;

+ (instancetype)errorWithUrl:(NSString *)url
                        code:(NSInteger)code
                         msg:(NSString *)msg;





@end
