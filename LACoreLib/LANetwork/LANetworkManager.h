//
//  LANetworkManager.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/22.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LABase.h"
#import "LANetworkBaseApi.h"


typedef NS_ENUM(NSInteger, LANetworkStatus) {
    LANetworkStatusUnknown          = -1,
    LANetworkStatusNotReachable     = 0,
    LANetworkStatusReachableViaWWAN = 1,
    LANetworkStatusReachableViaWiFi = 2,
};

typedef NS_ENUM(NSInteger, LANetworkServerType) {
    LANetworkServerTypeDev = 0,     //开发服务器
    LANetworkServerTypeTest,        //测试服务器
    LANetworkServerTypePre,         //预发布服务器
    LANetworkServerTypePro          //生产服务器
};





typedef void(^LANetworkManagerStatusChangeBlock)(LANetworkStatus status);

@interface LANetworkManager : NSObject

LA_SINGLE_DEF

@property (nonatomic, assign) LANetworkServerType serverType;

@property (nonatomic, assign, readonly) LANetworkStatus status;

@property (nonatomic, assign, readonly) BOOL isAvailable;
@property (nonatomic, assign, readonly) BOOL isWWAN;
@property (nonatomic, assign, readonly) BOOL isWiFi;

@property (nonatomic, strong)LANetworkManagerStatusChangeBlock blockStatusChange;


- (void)startMonitoring;
- (void)stopMonitoring;




- (void)addRequest:(LANetworkBaseApi *)api;

- (void)cancelRequest:(LANetworkBaseApi *)api;

@end
