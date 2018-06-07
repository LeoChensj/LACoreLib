//
//  LADefaultValue.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/7.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LADefaultValue.h"

#define CHECK_NIL_OR_NULL() \
if (value == nil || [value isKindOfClass:[NSNull class]]) {\
    return defaultValue;\
}


BOOL LABool(id value, BOOL defaultValue)
{
    CHECK_NIL_OR_NULL();
    
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)value boolValue];
    }
    
    if ([value isKindOfClass:[NSString class]])
    {
        return [(NSString *)value boolValue];
    }
    
    return defaultValue;
}

NSInteger LAInteger(id value, NSInteger defaultValue)
{
    CHECK_NIL_OR_NULL();
    
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)value integerValue];
    }
    
    if ([value isKindOfClass:[NSString class]])
    {
        return [(NSString *)value integerValue];
    }
    
    return defaultValue;
}

double LADouble(id value, double defaultValue)
{
    CHECK_NIL_OR_NULL();
    
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)value doubleValue];
    }
    
    if ([value isKindOfClass:[NSString class]])
    {
        return [(NSString *)value doubleValue];
    }
    
    return defaultValue;
}

NSString * LAString(id value, NSString * _Nullable defaultValue)
{
    CHECK_NIL_OR_NULL();
    
    if ([value isKindOfClass:[NSString class]])
    {
        return (NSString *)value;
    }
    
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)value stringValue];
    }
    
    return defaultValue;
}

NSArray * LAArray(id value, NSArray * _Nullable defaultValue)
{
    CHECK_NIL_OR_NULL();
    
    if ([value isKindOfClass:[NSArray class]])
    {
        return (NSArray *)value;
    }
    
    return defaultValue;
}

NSDictionary * LADictionary(id value, NSDictionary * _Nullable defaultValue)
{
    CHECK_NIL_OR_NULL();
    
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return (NSDictionary *)value;
    }
    
    return defaultValue;
}










