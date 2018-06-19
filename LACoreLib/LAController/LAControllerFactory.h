//
//  LAControllerFactory.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/19.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LABaseViewController.h"
#import "LABase.h"


@interface LAControllerFactory : NSObject

LA_SINGLE_DEF


/*
 注册控制器
 */
+ (void)registerControllerWithBlock:(dispatch_block_t)block;

- (void)registerController:(Class)vcClass
                       url:(NSString *)url
            isRequireLogin:(BOOL)isRequireLogin;

/*
 通过url路由获取控制器
 */
- (Class)controllerClassForUrl:(NSString *)url;

/*
 是否要求登录
 */
- (BOOL)isRequireLoginForUrl:(NSString *)url;

@end
