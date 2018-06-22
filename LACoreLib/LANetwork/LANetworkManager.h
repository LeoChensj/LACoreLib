//
//  LANetworkManager.h
//  LACoreLibDemo
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



@interface LANetworkManager : NSObject

LA_SINGLE_DEF


@property (nonatomic, assign, readonly) LANetworkStatus status;
@property (nonatomic, assign, readonly) BOOL isAvailable;
@property (nonatomic, assign, readonly) BOOL isWWAN;
@property (nonatomic, assign, readonly) BOOL isWiFi;


- (void)startMonitoring;
- (void)stopMonitoring;




- (void)addRequest:(LANetworkBaseApi *)api;

- (void)cancelRequest:(LANetworkBaseApi *)api;

@end
