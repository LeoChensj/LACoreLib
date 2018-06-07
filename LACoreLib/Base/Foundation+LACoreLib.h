//
//  Foundation+LACoreLib.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/6.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LACoreLib)

@end




@interface NSArray<ObjectType> (LACoreLib)

- (NSArray <ObjectType>*)la_subarrayWithRange:(NSRange)range;

- (NSArray <ObjectType>*)la_filterArrayWithBlock:(BOOL (^)(NSUInteger idx, ObjectType obj))block;

- (NSArray <ObjectType>*)la_mapArrayWithBlock:(id (^)(NSUInteger idx, ObjectType obj))block;

- (ObjectType _Nullable)la_objectAtIndex:(NSUInteger)index;

- (NSArray <ObjectType>*)la_objectsAtIndexes:(NSIndexSet *)indexes;

- (NSString *)la_toJSON;

@end





@interface NSArray (LACoreLibDefaultValue)

- (BOOL)la_boolAtIndex:(NSUInteger)index
          defaultValue:(BOOL)defaultValue;

- (NSInteger)la_integerAtIndex:(NSUInteger)index
                  defaultValue:(NSInteger)defaultValue;

- (double)la_doubleAtIndex:(NSUInteger)index
              defaultValue:(double)defaultValue;

- (NSString *)la_stringAtIndex:(NSUInteger)index
                  defaultValue:(NSString * _Nullable)defaultValue;

- (NSArray *)la_arrayAtIndex:(NSUInteger)index
                defaultValue:(NSArray * _Nullable)defaultValue;

- (NSDictionary *)la_dictionaryAtIndex:(NSUInteger)index
                          defaultValue:(NSDictionary * _Nullable)defaultValue;

@end





@interface NSMutableArray<ObjectType> (LACoreLib)

- (void)la_addObject:(ObjectType)obj;

- (void)la_insertObject:(ObjectType)obj
                atIndex:(NSUInteger)index;

- (void)la_removeObjectAtIndex:(NSUInteger)index;

@end





@interface NSDictionary<KeyType, ObjectType> (LACoreLib)

- (NSDictionary<KeyType, id> *)la_mappedDictionaryWithBlock:(id (^)(KeyType key, ObjectType obj))block;

- (NSString *)la_toJSON;

@end



@interface NSDictionary (LACoreLibDefaultValue)

- (BOOL)la_boolForKey:(id<NSCopying>)key
         defaultValue:(BOOL)defaultValue;

- (NSInteger)la_integerForKey:(id<NSCopying>)key
                 defaultValue:(NSInteger)defaultValue;

- (double)la_doubleForKey:(id<NSCopying>)key
             defaultValue:(double)defaultValue;

- (NSString *)la_stringForKey:(id<NSCopying>)key
                 defaultValue:(NSString * _Nullable)defaultValue;

- (NSArray *)la_arrayForKey:(id<NSCopying>)key
               defaultValue:(NSArray * _Nullable)defaultValue;

- (NSDictionary *)la_dictionaryForKey:(id<NSCopying>)key
                         defaultValue:(NSDictionary * _Nullable)defaultValue;

@end





@interface NSMutableDictionary<KeyType, ObjectType> (LACoreLib)

- (void)la_setObject:(ObjectType)obj forKey:(KeyType)aKey;

- (ObjectType _Nullable)la_objectForKey:(KeyType)key
                      createIfNotExists:(ObjectType(^)(void))createBlock;

@end






@interface NSMutableSet<ObjectType> (LACoreLib)

- (void)la_addObject:(ObjectType)object;

@end




@interface NSUserDefaults (LACoreLib)

- (void)la_setObject:(id)object forKey:(NSString *)key;

@end




@interface NSException (LACoreLib)

- (NSString *)la_description;

@end




@interface NSBundle (LACoreLib)

+ (NSString * _Nullable)la_mainBundle_identifier;
+ (NSString * _Nullable)la_mainBundle_version;
+ (NSString * _Nullable)la_mainBundle_shortVersion;
+ (NSString * _Nullable)la_mainBundle_name;
+ (NSString * _Nullable)la_mainBundle_displayName;

@end







