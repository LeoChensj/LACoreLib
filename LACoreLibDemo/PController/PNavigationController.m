//
//  PNavigationController.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/15.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "PNavigationController.h"

@interface PNavigationController ()

@end

@implementation PNavigationController

- (LANavigationBar *)la_configNavigationBar
{
    return [[LANavigationBar alloc] initWithBarType:UIBarStyleDefault
                                    backgroundImage:nil
                                       barTintColor:[UIColor whiteColor]
                                        translucent:NO
                                         titileFont:[UIFont systemFontOfSize:16]
                                         titleColor:[UIColor blackColor]
                                           haveLine:NO];
}

@end
