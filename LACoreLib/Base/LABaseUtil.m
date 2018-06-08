//
//  LABaseUtil.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/8.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABaseUtil.h"

@implementation LABaseUtil

BOOL LAIsMainQueue()
{
    static void *mainQueueKey = &mainQueueKey;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_set_specific(dispatch_get_main_queue(),
                                    mainQueueKey,
                                    mainQueueKey,
                                    NULL);
    });
    
    return dispatch_get_specific(mainQueueKey) == mainQueueKey;
}

BOOL LAIsMainThread()
{
    return [NSThread currentThread].isMainThread;
}

void LADispatchSyncMainSafe(dispatch_block_t block)
{
    if (block == nil) return;
    
    if (LAIsMainQueue())
    {
        LABlockInvoke(block, NULL, 0);
    }
    else if (LAIsMainThread())
    {
        LABlockInvoke(block, NULL, 0);
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            LABlockInvoke(block, NULL, 0);
        });
    }
}

void LADispatchAsyncMain(dispatch_block_t block)
{
    if (block == nil) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LABlockInvoke(block, NULL, 0);
    });
}

void LADispatchAsyncDefault(dispatch_block_t block)
{
    if (block == nil) return;
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        LABlockInvoke(block, NULL, 0);
    });
}

void LADispatchDelayMain(NSTimeInterval delay, dispatch_block_t block)
{
    if (block == nil) return;
    
    delay = MAX(0.0, delay);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       LABlockInvoke(block, NULL, 0);
                   });
}

void LADispatchDelayDefault(NSTimeInterval delay, dispatch_block_t block)
{
    if (block == nil) return;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay * NSEC_PER_SEC)),
                   dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
                       LABlockInvoke(block, NULL, 0);
                   });
}

BOOL LABlockInvoke(dispatch_block_t block, const char * _Nullable filePath, int line)
{
    if (block == nil) return NO;
    
#if DEBUG
    block();
    
    return YES;
#else
    @try {
        block();
        
        return YES;
    }
    @catch(NSException *ex) {
        return NO;
    }
#endif
}

@end
