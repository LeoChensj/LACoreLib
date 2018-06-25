//
//  TestNetworkApi.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/25.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "TestNetworkApi.h"

@interface TestNetworkApi ()
{
    NSInteger _page;
    NSInteger _size;
    NSString *_context;
}
@end

@implementation TestNetworkApi

- (instancetype)init_with_page:(NSInteger)page size:(NSInteger)size context:(NSString *)context
{
    if(self = [super init])
    {
        _page = page;
        _size = size;
        _context = context;
    }
    
    return self;
}

- (NSString *)configRequestUrl
{
    return @"/hello";
}

- (LARequestMethod)configRequestMethod
{
    return LARequestMethodGet;
}

- (NSDictionary *)configRequestParam
{
    return @{@"page": @(_page), @"size": @(_size), @"context": _context};
}

@end
