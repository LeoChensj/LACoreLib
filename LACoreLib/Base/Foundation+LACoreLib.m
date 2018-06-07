//
//  Foundation+LACoreLib.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/6.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "Foundation+LACoreLib.h"

#import "LADefines.h"
#import "LADefaultValue.h"



@implementation NSObject (LACoreLib)

@end


@implementation NSArray (LACoreLib)

- (NSArray *)la_subarrayWithRange:(NSRange)range
{
    NSUInteger start = range.location;
    NSUInteger length = range.length;
    
    if(start >= self.count)
    {
        LACoreLibWarn(@"start(%lu) is out of array.count(%lu)", start, self.count);
        
        start = 0;
        length = 0;
    }
    
    if(start + length > self.count)
    {
        LACoreLibWarn(@"length(%lu) is too long from start(%lu) for array.count(%lu)",
                      length, start, self.count);
        
        length = self.count - start;
    }
    
    return [self subarrayWithRange:NSMakeRange(start, length)];
}

- (NSArray *)la_filterArrayWithBlock:(BOOL (^)(NSUInteger, id))block
{
    if(block)
    {
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
        
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(block(idx, obj))
            {
                [result la_addObject:obj];
            }
            
        }];
        
        return [NSArray arrayWithArray:result];
    }
    else
    {
        return [NSArray arrayWithArray:self];
    }
}

- (NSArray *)la_mapArrayWithBlock:(id (^)(NSUInteger, id))block
{
    if(block)
    {
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
        
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
                [result la_addObject:block(idx, obj)];
            
        }];
        
        return [NSArray arrayWithArray:result];
    }
    else
    {
        return [NSArray arrayWithArray:self];
    }
}

- (id)la_objectAtIndex:(NSUInteger)index
{
    if(index < self.count)
    {
        return [self objectAtIndex:index];
    }
    else
    {
        LACoreLibWarn(@"index %lu is out of array %lu", index, self.count);
        
        return nil;
    }
}

- (NSArray *)la_objectsAtIndexes:(NSIndexSet *)indexes
{
    return [self objectsAtIndexes:[indexes indexesPassingTest:^BOOL(NSUInteger idx, BOOL *stop) {
        
        BOOL result = idx < self.count;
        if (result == NO)
        {
            LACoreLibWarn(@"index %lu is out of array %lu", idx, self.count);
        }
        
        return result;
        
    }]];
}

- (NSString *)la_toJSON
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end





@implementation NSArray (LACoreLibDefaultValue)

- (BOOL)la_boolAtIndex:(NSUInteger)index
          defaultValue:(BOOL)defaultValue
{
    return LABool([self la_objectAtIndex:index], defaultValue);
}

- (NSInteger)la_integerAtIndex:(NSUInteger)index
                  defaultValue:(NSInteger)defaultValue
{
    return LAInteger([self la_objectAtIndex:index], defaultValue);
}

- (double)la_doubleAtIndex:(NSUInteger)index
              defaultValue:(double)defaultValue
{
    return LADouble([self la_objectAtIndex:index], defaultValue);
}

- (NSString *)la_stringAtIndex:(NSUInteger)index
                  defaultValue:(NSString * _Nullable)defaultValue
{
    return LAString([self la_objectAtIndex:index], defaultValue);
}

- (NSArray *)la_arrayAtIndex:(NSUInteger)index
                defaultValue:(NSArray * _Nullable)defaultValue
{
    return LAArray([self la_objectAtIndex:index], defaultValue);
}

- (NSDictionary *)la_dictionaryAtIndex:(NSUInteger)index
                          defaultValue:(NSDictionary * _Nullable)defaultValue
{
    return LADictionary([self la_objectAtIndex:index], defaultValue);
}

@end




@implementation NSMutableArray (LACoreLib)

- (void)la_addObject:(id)obj
{
    if(obj)
    {
        [self addObject:obj];
    }
    else
    {
        LACoreLibWarn(@"add nil object to array");
    }
}

- (void)la_insertObject:(id)obj
                atIndex:(NSUInteger)index
{
    if(obj)
    {
        if(index > self.count)
        {
            index = self.count;
        }
        
        [self insertObject:obj atIndex:index];
    }
    else
    {
        LACoreLibWarn(@"insert nil object to array");
    }
}

- (void)la_removeObjectAtIndex:(NSUInteger)index
{
    if(index < self.count)
    {
        [self removeObjectAtIndex:index];
    }
    else
    {
        LACoreLibWarn(@"remove index(%lu) out of array(%lu)", index, self.count);
    }
}

@end





@implementation NSDictionary (LACoreLib)

- (NSDictionary *)la_mappedDictionaryWithBlock:(id (^)(id key, id obj))block
{
    if(block)
    {
        __block NSMutableDictionary *results = [NSMutableDictionary dictionary];
        
        [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [results la_setObject:block(key, obj) forKey:key];
            
        }];
        
        return results;
    }
    else
    {
        return [NSDictionary dictionaryWithDictionary:self];
    }
}

- (NSString *)la_toJSON
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end




@implementation NSDictionary (LACoreLibDefaultValue)

- (BOOL)la_boolForKey:(id<NSCopying>)key
         defaultValue:(BOOL)defaultValue
{
    return LABool([self objectForKey:key], defaultValue);
}

- (NSInteger)la_integerForKey:(id<NSCopying>)key
                 defaultValue:(NSInteger)defaultValue
{
    return LAInteger([self objectForKey:key], defaultValue);
}

- (double)la_doubleForKey:(id<NSCopying>)key
             defaultValue:(double)defaultValue
{
    return LADouble([self objectForKey:key], defaultValue);
}

- (NSString *)la_stringForKey:(id<NSCopying>)key
                 defaultValue:(NSString * _Nullable)defaultValue
{
    return LAString([self objectForKey:key], defaultValue);
}

- (NSArray *)la_arrayForKey:(id<NSCopying>)key
               defaultValue:(NSArray * _Nullable)defaultValue
{
    return LAArray([self objectForKey:key], defaultValue);
}

- (NSDictionary *)la_dictionaryForKey:(id<NSCopying>)key
                         defaultValue:(NSDictionary * _Nullable)defaultValue
{
    return LADictionary([self objectForKey:key], defaultValue);
}

@end





@implementation NSMutableDictionary (LACoreLib)

- (void)la_setObject:(id)obj forKey:(id)aKey
{
    if(obj && aKey)
    {
        [self setObject:obj forKey:aKey];
    }
    else
    {
        LACoreLibWarn(@"object or key is nil");
    }
}

- (id _Nullable)la_objectForKey:(id)key
                      createIfNotExists:(id(^)(void))createBlock
{
    id object = [self objectForKey:key];
    
    if(!object && createBlock)
    {
        object = createBlock();
        [self la_setObject:object forKey:key];
    }
    
    return object;
}

@end





@implementation NSMutableSet (LACoreLib)

- (void)la_addObject:(id)object
{
    if(!object)
    {
        [self addObject:object];
    }
    else
    {
        LACoreLibWarn(@"add nil object to Set");
    }
}

@end





@implementation NSUserDefaults (LACoreLib)

- (void)la_setObject:(id)object forKey:(NSString *)key
{
    if(object && key)
    {
        @try {
            [self setObject:object forKey:key];
        }
        @catch (NSException *ex) {
            LACoreLibWarn(@"set object(%@) for key(%@) in %@ failed: %@",
                           object, key, self,
                           [ex description]);
        }
        @finally {}
    }
    else
    {
        LACoreLibWarn(@"object or key is nil");
    }
}

@end




@implementation NSException (LACoreLib)

- (NSString *)la_description
{
    return [NSString stringWithFormat:@"(%@, %@, %@, %@)",
            NSStringFromClass([self class]),
            self.name,
            self.reason,
            self.userInfo];
}

@end





@implementation NSBundle (LACoreLib)

+ (NSString * _Nullable)la_mainBundle_identifier
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (NSString * _Nullable)la_mainBundle_version
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString * _Nullable)la_mainBundle_shortVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString * _Nullable)la_mainBundle_name
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (NSString * _Nullable)la_mainBundle_displayName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

@end























