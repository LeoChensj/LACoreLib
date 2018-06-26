//
//  LANavigationController.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LANavigationBar.h"


@interface LANavigationController : UINavigationController

/*
 配置navigationBar
 可以继承自LANavigationBar自定义
 */
- (LANavigationBar *)la_configNavigationBar;

@end
