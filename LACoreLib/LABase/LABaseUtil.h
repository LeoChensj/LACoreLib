//
//  LABaseUtil.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/8.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LABaseDefines.h"


@interface LABaseUtil : NSObject

LA_EXTERN BOOL LAIsMainQueue(void);
LA_EXTERN BOOL LAIsMainThread(void);

LA_EXTERN void LADispatchSyncMainSafe(dispatch_block_t block);
LA_EXTERN void LADispatchAsyncMain(dispatch_block_t block);
LA_EXTERN void LADispatchAsyncDefault(dispatch_block_t block);

LA_EXTERN void LADispatchDelayMain(NSTimeInterval delay, dispatch_block_t block);
LA_EXTERN void LADispatchDelayDefault(NSTimeInterval delay, dispatch_block_t block);

LA_EXTERN BOOL LABlockInvoke(dispatch_block_t block, const char * _Nullable filePath, int line);

@end
