//
//  LABaseDefines.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/8.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#ifndef LABaseDefines_h
#define LABaseDefines_h

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define LALog(...)              NSLog(__VA_ARGS__)
#define LACoreLibWarn(...)      NSLog(@"LACoreLibWarn:" __VA_ARGS__)
#else
#define LALog(...)
#define LACoreLibWarn(...)
#endif



#define LA_EXTERN                   extern

#define LA_UNUSED_VAR(var)          ((void)(var))

#define LA_IS(obj, cls)             (obj != nil && [obj isKindOfClass:[cls class]])

#define LA_IS_STRING(obj)           (LA_IS(obj, NSString))
#define LA_IS_NUMBER(obj)           (LA_IS(obj, NSNumber))
#define LA_IS_ARRAY(obj)            (LA_IS(obj, NSArray))
#define LA_IS_DICTIONARY(obj)       (LA_IS(obj, NSDictionary))
#define LA_IS_SET(obj)              (LA_IS(obj, NSSet))
#define LA_IS_DATA(obj)             (LA_IS(obj, NSData))

#define LA_IS_VALID_STRING(obj)     (LA_IS_STRING(obj) && [obj length])
#define LA_IS_VALID_NUMBER(obj)     (LA_IS_NUMBER(obj))
#define LA_IS_VALID_ARRAY(obj)      (LA_IS_ARRAY(obj) && [obj count])
#define LA_IS_VALID_DICTIONARY(obj) (LA_IS_DICTIONARY(obj) && [obj count])
#define LA_IS_VALID_SET(obj)        (LA_IS_SET(obj) && [obj count])
#define LA_IS_VALID_DATA(obj)       (LA_IS_DATA(obj) && [obj length])
#define LA_IS_VALID_DELEGATE(d, s)  (d && [d respondsToSelector:s])

#define LA_AS(obj, cls, var)        cls *var = nil; if (LA_IS(obj, cls)) var = (cls *)obj;


#define LA_SINGLE_DEF \
+ (instancetype)shareInstance;

#define LA_SINGLE_IMP \
+ (instancetype)shareInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}



#define $(format, ...)              [NSString stringWithFormat:format, ##__VA_ARGS__]

#define LA_WS(ws)                   __weak typeof(self) ws = self;



#endif /* LABaseDefines_h */
