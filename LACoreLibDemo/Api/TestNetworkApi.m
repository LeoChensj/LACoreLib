//
//  TestNetworkApi.h
//
//
//  Copyright © Leo.Chen All rights reserved.
//

#import "TestNetworkApi.h"

@interface TestNetworkApi ()
{
	NSInteger _page;
	NSInteger _size;
	NSString * _context;
	BOOL _finish;
}
@end

@implementation TestNetworkApi

- (instancetype)init_with_page:(NSInteger)page size:(NSInteger)size context:(NSString *)context finish:(BOOL)finish
{
	if(self = [super init])
	{
		_page = page;
		_size = size;
		_context = context;
		_finish = finish;
	}

	return self;
}

- (NSString *)configRequestUrl
{
	return @"/api/test/list";
}

- (LARequestMethod)configRequestMethod
{
	return LARequestMethodPost;
}

- (NSDictionary *)configRequestParam
{
	return @{@"page": @(_page), @"size": @(_size), @"context": _context, @"finish": @(_finish)};
}

@end
