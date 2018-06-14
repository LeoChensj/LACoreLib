//
//  LATabBarController.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/13.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LATabBar.h"


@interface LATabBarController : UITabBarController

/*
 配置tabBar
 可以继承自LATabBar自定义
 */
- (LATabBar *)la_configTabBar;

/*
 配置viewControllers
 已为你自动加上NavigationController
 */
- (NSArray <UIViewController *>*)la_configViewControllers;

@end
