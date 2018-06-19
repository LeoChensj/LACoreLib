//
//  MyControllerRegister.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/19.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "MyControllerRegister.h"

#import "LAControllerFactory.h"

#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "TestViewController1.h"
#import "TestViewController2.h"
#import "TestViewController3.h"


@implementation MyControllerRegister

+ (void)registerMyController
{
    [LAControllerFactory registerControllerWithBlock:^{
        
        [[LAControllerFactory shareInstance] registerController:[ViewController1 class]
                                                            url:@"vc1"
                                                 isRequireLogin:NO];
        
        [[LAControllerFactory shareInstance] registerController:[ViewController2 class]
                                                            url:@"vc2"
                                                 isRequireLogin:NO];
        
        [[LAControllerFactory shareInstance] registerController:[ViewController3 class]
                                                            url:@"vc3"
                                                 isRequireLogin:NO];
        
        [[LAControllerFactory shareInstance] registerController:[ViewController4 class]
                                                            url:@"vc4"
                                                 isRequireLogin:NO];
        
        [[LAControllerFactory shareInstance] registerController:[TestViewController1 class]
                                                            url:@"tvc1"
                                                 isRequireLogin:NO];
        
        [[LAControllerFactory shareInstance] registerController:[TestViewController2 class]
                                                            url:@"tvc2"
                                                 isRequireLogin:NO];
        
        [[LAControllerFactory shareInstance] registerController:[TestViewController3 class]
                                                            url:@"tvc3"
                                                 isRequireLogin:NO];
        
    }];
}

@end
