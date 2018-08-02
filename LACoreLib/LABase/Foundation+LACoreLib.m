//
//  Foundation+LACoreLib.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/6.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "Foundation+LACoreLib.h"
#import <CommonCrypto/CommonDigest.h>
#import "LADefaultValue.h"



@implementation NSObject (LACoreLib)

@end




@implementation NSString (LACoreLib)

- (BOOL)la_isPhoneNumber
{
    NSString *regex = @"^(13|15|17|18|14)\\d{9}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)la_isEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)la_isUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)la_isBeginsWith:(NSString *)string
{
    if(!string)
    {
        LACoreLibWarn(@"(la_isBeginsWith:) parameter is nil");
        
        return NO;
    }
    
    return [self hasPrefix:string];
}

- (BOOL)la_isEndsWith:(NSString *)string
{
    if(!string)
    {
        LACoreLibWarn(@"(la_isEndsWith:) parameter is nil");
        
        return NO;
    }
    
    return [self hasSuffix:string];
}

- (BOOL)la_containsString:(NSString *)subString
{
    if(!subString)
    {
        LACoreLibWarn(@"(la_containsString:) parameter is nil");
        
        return NO;
    }
    
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

- (NSString *)la_replaceString:(NSString *)olderString withString:(NSString *)newerString
{
    if(!olderString || !newerString)
    {
        LACoreLibWarn(@"(la_replaceString:withString:) parameter is nil");
        
        return [NSString stringWithString:self];
    }
    
    return [self stringByReplacingOccurrencesOfString:olderString withString:newerString];
}

- (NSString *)la_substringWithRange:(NSRange)range
{
    NSUInteger start = range.location;
    NSUInteger length = range.length;
    
    if(start >= self.length)
    {
        LACoreLibWarn(@"start(%lu) is out of string.length(%lu)", start, self.length);
        
        start = 0;
        length = 0;
    }
    
    if(start + length > self.length)
    {
        LACoreLibWarn(@"length(%lu) is too long from start(%lu) for string.length(%lu)",
                      length, start, self.length);
        
        length = self.length - start;
    }
    
    return [self substringWithRange:NSMakeRange(start, length)];
}

- (NSString *)la_AppendingString:(NSString *)string
{
    if(!string || string.length == 0)
    {
        return [NSString stringWithString:self];
    }
    
    return [self stringByAppendingString:string];
}

- (NSString *)la_removeSubString:(NSString *)subString
{
    if(!subString)
    {
        return [NSString stringWithString:self];
    }
    
    NSRange range = [self rangeOfString:subString];
    
    if(range.location != NSNotFound)
    {
        return [self stringByReplacingCharactersInRange:range withString:@""];
    }
    
    return [NSString stringWithString:self];
}

- (NSString *)la_removeWhiteSpaces
{
    return [self stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSData *)la_convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)la_encodingWithUTF8
{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (CGSize)la_attrStrSizeWithFont:(UIFont *)font
                         maxSize:(CGSize)maxSize
                     lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    NSDictionary *dict = @{NSFontAttributeName: font,
                           NSParagraphStyleAttributeName: paragraphStyle};
    
    CGSize size = [self boundingRectWithSize:maxSize
                                          options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:dict
                                          context:nil].size;
    
    return size;
}

- (NSString *)la_md5
{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

- (NSDictionary *)la_toDictionary
{
    if (self.length == 0) {
        return nil;
    }
    NSError *error;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    if (error)
    {
        LACoreLibWarn(@"(la_toDictionary) %@", [error localizedDescription]);
    }
    
    return object;
}

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








NSString * const kLADateFormatFull = @"yyyy-MM-dd HH:mm:ss";
NSString * const kLADateFormatDate = @"yyyy-MM-dd";
NSString * const kLADateFormatDateChinese = @"yyyy年M月d日";
NSString * const kLADateFormatDateShort = @"yy-MM-dd";
NSString * const kLADateFormatDateShortChinese = @"yy年M月d日";
NSString * const kLADateFormatMouthDay = @"MM-dd";
NSString * const kLADateFormatMouthDayChinese = @"M月d日";
NSString * const kLADateFormatTime = @"HH:mm:ss";
NSString * const kLADateFormatTimeExtra = @"HH:mm:ss SSS";
NSString * const kLADateFormatWeekNumber = @"c";
NSString * const kLADateFormatWeekStringShort = @"ccc";
NSString * const kLADateFormatWeekStringLong = @"cccc";


@implementation NSDate (LACoreLib)

- (NSInteger)la_year
{
    return [self la_dateComponentsDate].year;
}

- (NSInteger)la_month
{
    return [self la_dateComponentsDate].month;
}

- (NSInteger)la_day
{
    return [self la_dateComponentsDate].day;
}

- (NSInteger)la_weekday
{
    return [self la_dateComponentsWeekday].weekday;
}

- (NSInteger)la_hour
{
    return [self la_dateComponentsTime].hour;
}

- (NSInteger)la_minute
{
    return [self la_dateComponentsTime].minute;
}

- (NSInteger)la_second
{
    return [self la_dateComponentsTime].second;
}



+ (NSDate *)la_dateWithYear:(NSUInteger)year
                      month:(NSUInteger)month
                        day:(NSUInteger)day
{
    NSDateComponents *components = [self dateComponentsWithYear:year
                                                          month:month
                                                            day:day
                                                           hour:0
                                                         minute:0
                                                         second:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSDate *)la_dateWithYear:(NSUInteger)year
                      month:(NSUInteger)month
                        day:(NSUInteger)day
                       hour:(NSUInteger)hour
                     minute:(NSUInteger)minute
                     second:(NSUInteger)second
{
    NSDateComponents *components = [self dateComponentsWithYear:year
                                                          month:month
                                                            day:day
                                                           hour:hour
                                                         minute:minute
                                                         second:second];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSDate *)la_dateFromDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    
    return [dateFormatter dateFromString:format];
}

- (BOOL)la_isEqualToDay:(NSDate *)date
{
    return self.la_day == date.la_day && self.la_month == date.la_month && self.la_year == date.la_year;
}

- (BOOL)la_isEqualToTime:(NSDate *)date
{
    return self.la_hour == date.la_hour && self.la_minute == date.la_minute && self.la_second == date.la_second;
}

- (BOOL)la_isLessDate:(NSDate *)date
{
    return [self compare:date] == NSOrderedAscending;
}

- (BOOL)la_isGreaterDate:(NSDate *)date
{
    return [self compare:date] == NSOrderedDescending;
}

- (BOOL)la_isLessOrEqualToDate:(NSDate *)date
{
    return [self la_isLessDate:date] || [self isEqualToDate:date];
}

- (BOOL)la_isGreaterOrEqualToDate:(NSDate *)date
{
    return [self la_isGreaterDate:date] || [self isEqualToDate:date];
}


- (NSDate *)la_dateBySettingYear:(NSUInteger)year
{
    NSDateComponents *components = [self la_dateComponentsDateTime];
    components.year = year;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)la_dateByAddingYear:(NSUInteger)year
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components
                                                         toDate:self
                                                        options:0];
}

- (NSDate *)la_dateBySettingMonth:(NSUInteger)month
{
    NSDateComponents *components = [self la_dateComponentsDateTime];
    components.month = month;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)la_dateByAddingMonth:(NSUInteger)month
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = month;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components
                                                         toDate:self
                                                        options:0];
}

- (NSDate *)la_dateBySettingDay:(NSUInteger)day
{
    NSDateComponents *components = [self la_dateComponentsDateTime];
    components.day = day;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)la_dateByAddingDays:(NSUInteger)days
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = days;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components
                                                         toDate:self
                                                        options:0];
}

- (NSDate *)la_dateBySettingHour:(NSUInteger)hour
{
    NSDateComponents *components = [self la_dateComponentsDateTime];
    components.hour = hour;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)la_dateBySettingMinute:(NSUInteger)minute
{
    NSDateComponents *components = [self la_dateComponentsDateTime];
    components.minute = minute;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)la_dateBySettingSecond:(NSUInteger)second
{
    NSDateComponents *components = [self la_dateComponentsDateTime];
    components.second = second;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)dateBySettingHour:(NSUInteger)hour
                       minute:(NSUInteger)minute
                       second:(NSUInteger)second
{
    NSDateComponents *components = [self la_dateComponentsDateTime];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)la_dateByAddingHour:(NSUInteger)hour
{
    return [self la_dateByAddingHour:hour minute:0 second:0];
}

- (NSDate *)la_dateByAddingMinute:(NSUInteger)minute
{
    return [self la_dateByAddingHour:0 minute:minute second:0];
}

- (NSDate *)la_dateByAddingSecond:(NSUInteger)second
{
    return [self la_dateByAddingHour:0 minute:0 second:second];
}

- (NSDate *)la_dateByAddingHour:(NSUInteger)hour
                         minute:(NSUInteger)minute
                         second:(NSUInteger)second
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components
                                                         toDate:self
                                                        options:0];
}

- (NSString *)la_stringFromDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    
    return [dateFormatter stringFromDate:self];
}










#pragma mark - Private
+ (NSDateComponents *)dateComponentsWithYear:(NSUInteger)year
                                       month:(NSUInteger)month
                                         day:(NSUInteger)day
                                        hour:(NSUInteger)hour
                                      minute:(NSUInteger)minute
                                      second:(NSUInteger)second
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    
    return components;
}

- (NSDateComponents *)la_dateComponents:(NSUInteger)components
{
    return [[NSCalendar currentCalendar] components:components fromDate:self];
}

- (NSDateComponents *)la_dateComponentsTime
{
    NSUInteger components = (NSCalendarUnitHour |
                             NSCalendarUnitMinute |
                             NSCalendarUnitSecond);
    
    return [self la_dateComponents:components];
}

- (NSDateComponents *)la_dateComponentsDate
{
    NSUInteger components = (NSCalendarUnitDay |
                             NSCalendarUnitMonth |
                             NSCalendarUnitYear);
    
    return [self la_dateComponents:components];
}

- (NSDateComponents *)la_dateComponentsWeekday
{
    NSUInteger components = (NSCalendarUnitDay |
                             NSCalendarUnitWeekday |
                             NSCalendarUnitWeekday |
                             NSCalendarUnitMonth |
                             NSCalendarUnitYear);
    
    return [self la_dateComponents:components];
}

- (NSDateComponents *)la_dateComponentsDateTime
{
    NSUInteger components = (NSCalendarUnitDay |
                             NSCalendarUnitMonth |
                             NSCalendarUnitYear |
                             NSCalendarUnitHour |
                             NSCalendarUnitMinute |
                             NSCalendarUnitSecond);
    
    return [self la_dateComponents:components];
}

@end



