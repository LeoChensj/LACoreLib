//
//  TestNetworkApi.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/25.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "PNetworkBaseApi.h"

@interface TestNetworkApi : PNetworkBaseApi

- (instancetype)init_with_page:(NSInteger)page size:(NSInteger)size context:(NSString *)context;

@end
