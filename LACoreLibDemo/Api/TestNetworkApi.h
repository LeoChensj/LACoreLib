//
//  TestNetworkApi.h
//
//
//  Copyright © Leo.Chen All rights reserved.
//

#import "PNetworkBaseApi.h"

@interface TestNetworkApi : PNetworkBaseApi

- (instancetype)init_with_page:(NSInteger)page size:(NSInteger)size context:(NSString *)context finish:(BOOL)finish;

@end
