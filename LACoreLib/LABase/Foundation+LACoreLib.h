//
//  Foundation+LACoreLib.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/6.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LABaseDefines.h"


@interface NSObject (LACoreLib)

@end




@interface NSString (LACoreLib)

- (BOOL)la_isPhoneNumber;

- (BOOL)la_isEmail;

- (BOOL)la_isUrl;

- (BOOL)la_isBeginsWith:(NSString *)string;

- (BOOL)la_isEndsWith:(NSString *)string;

- (BOOL)la_containsString:(NSString *)subString;

- (NSString *)la_replaceString:(NSString *)olderString withString:(NSString *)newerString;

- (NSString *)la_substringWithRange:(NSRange)range;

- (NSString *)la_AppendingString:(NSString *)string;

- (NSString *)la_removeSubString:(NSString *)subString;

- (NSString *)la_removeWhiteSpaces;

- (NSData *)la_convertToData;

- (NSString *)la_encodingWithUTF8;

- (CGSize)la_attrStrSizeWithFont:(UIFont *)font
                         maxSize:(CGSize)maxSize
                     lineSpacing:(CGFloat)lineSpacing;

- (NSString *)la_md5;

- (NSDictionary *)la_toDictionary;

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








LA_EXTERN NSString * const kLADateFormatFull;
LA_EXTERN NSString * const kLADateFormatDate;
LA_EXTERN NSString * const kLADateFormatDateChinese;
LA_EXTERN NSString * const kLADateFormatDateShort;
LA_EXTERN NSString * const kLADateFormatDateShortChinese;
LA_EXTERN NSString * const kLADateFormatMouthDay;
LA_EXTERN NSString * const kLADateFormatMouthDayChinese;
LA_EXTERN NSString * const kLADateFormatTime;
LA_EXTERN NSString * const kLADateFormatTimeExtra;
LA_EXTERN NSString * const kLADateFormatWeekNumber;
LA_EXTERN NSString * const kLADateFormatWeekStringShort;
LA_EXTERN NSString * const kLADateFormatWeekStringLong;

@interface NSDate (LACoreLib)

@property (nonatomic, assign, readonly) NSInteger la_year;
@property (nonatomic, assign, readonly) NSInteger la_month;
@property (nonatomic, assign, readonly) NSInteger la_day;
@property (nonatomic, assign, readonly) NSInteger la_weekday;
@property (nonatomic, assign, readonly) NSInteger la_hour;
@property (nonatomic, assign, readonly) NSInteger la_minute;
@property (nonatomic, assign, readonly) NSInteger la_second;


//create
+ (NSDate *)la_dateWithYear:(NSUInteger)year
                   month:(NSUInteger)month
                     day:(NSUInteger)day;

+ (NSDate *)la_dateWithYear:(NSUInteger)year
                   month:(NSUInteger)month
                     day:(NSUInteger)day
                    hour:(NSUInteger)hour
                  minute:(NSUInteger)minute
                  second:(NSUInteger)second;

+ (NSDate *)la_dateFromDateFormat:(NSString *)format;



//compare
- (BOOL)la_isEqualToDay:(NSDate *)date;
- (BOOL)la_isEqualToTime:(NSDate *)date;
- (BOOL)la_isLessDate:(NSDate *)date;
- (BOOL)la_isGreaterDate:(NSDate *)date;
- (BOOL)la_isLessOrEqualToDate:(NSDate *)date;
- (BOOL)la_isGreaterOrEqualToDate:(NSDate *)date;


//set add
- (NSDate *)la_dateBySettingYear:(NSUInteger)year;
- (NSDate *)la_dateByAddingYear:(NSUInteger)year;

- (NSDate *)la_dateBySettingMonth:(NSUInteger)month;
- (NSDate *)la_dateByAddingMonth:(NSUInteger)month;

- (NSDate *)la_dateBySettingDay:(NSUInteger)day;
- (NSDate *)la_dateByAddingDays:(NSUInteger)days;

- (NSDate *)la_dateBySettingHour:(NSUInteger)hour;
- (NSDate *)la_dateBySettingMinute:(NSUInteger)minute;
- (NSDate *)la_dateBySettingSecond:(NSUInteger)second;
- (NSDate *)la_dateBySettingHour:(NSUInteger)hour
                          minute:(NSUInteger)minute
                          second:(NSUInteger)second;

- (NSDate *)la_dateByAddingHour:(NSUInteger)hour;
- (NSDate *)la_dateByAddingMinute:(NSUInteger)minute;
- (NSDate *)la_dateByAddingSecond:(NSUInteger)second;
- (NSDate *)la_dateByAddingHour:(NSUInteger)hour
                      minute:(NSUInteger)minute
                      second:(NSUInteger)second;


//to string
- (NSString *)la_stringFromDateFormat:(NSString *)format;

@end







