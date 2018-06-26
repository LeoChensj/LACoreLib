//
//  LAControllerFactory.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/19.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LAControllerFactory.h"


@interface LAControllerFactory ()

@property (nonatomic, strong)NSMutableArray <NSDictionary *>*dataArray;

@end


@implementation LAControllerFactory

LA_SINGLE_IMP


+ (void)registerControllerWithBlock:(dispatch_block_t)block
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, block);
}

- (void)registerController:(Class)vcClass
                       url:(NSString *)url
            isRequireLogin:(BOOL)isRequireLogin
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:vcClass forKey:@"class"];
    [dict setObject:url forKey:@"url"];
    [dict setObject:@(isRequireLogin) forKey:@"isRequireLogin"];
    
    [self.dataArray la_addObject:dict];
}


- (Class)controllerClassForUrl:(NSString *)url
{
    Class vcClass = nil;
    
    NSArray <NSDictionary *>*dataArray = [self.dataArray la_filterArrayWithBlock:^BOOL(NSUInteger idx, NSDictionary *obj) {
        
        NSString *theUrl = obj[@"url"];
        
        return [url isEqualToString:theUrl];
        
    }];
    
    if(dataArray.count > 0)
    {
        vcClass = dataArray.firstObject[@"class"];
    }
    
    return vcClass;
}

- (BOOL)isRequireLoginForUrl:(NSString *)url
{
    NSArray <NSDictionary *>*dataArray = [self.dataArray la_filterArrayWithBlock:^BOOL(NSUInteger idx, NSDictionary *obj) {
        
        NSString *theUrl = obj[@"url"];
        NSNumber *isRequireLogin = obj[@"isRequireLogin"];
        
        return [url isEqualToString:theUrl] && isRequireLogin.boolValue;
        
    }];
    
    return (dataArray.count > 0);
}








#pragma mark - Reader
- (NSMutableArray<NSDictionary *> *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}



@end
