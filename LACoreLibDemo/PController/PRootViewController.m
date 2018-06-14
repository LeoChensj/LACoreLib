//
//  PRootViewController.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "PRootViewController.h"
#import "LACoreLib.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"


@interface PRootViewController ()

@end


@implementation PRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (LATabBar *)la_configTabBar
{
    LATabBarItem *item1 = [[LATabBarItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabbar_10"]
                                                        selectImage:[UIImage imageNamed:@"tabbar_11"]
                                                        normalColor:[UIColor lightGrayColor]
                                                        selectColor:[UIColor colorWithCSS:@"#328BEF"]
                                                              title:@"Leo"
                                                          titleFont:[UIFont systemFontOfSize:10]];
    
    LATabBarItem *item2 = [[LATabBarItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabbar_20"]
                                                        selectImage:[UIImage imageNamed:@"tabbar_21"]
                                                        normalColor:[UIColor lightGrayColor]
                                                        selectColor:[UIColor colorWithCSS:@"#328BEF"]
                                                              title:@"Chen"
                                                          titleFont:[UIFont systemFontOfSize:10]];
    
    LATabBarItem *item3 = [[LATabBarItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabbar_30"]
                                                        selectImage:[UIImage imageNamed:@"tabbar_31"]
                                                        normalColor:[UIColor lightGrayColor]
                                                        selectColor:[UIColor colorWithCSS:@"#328BEF"]
                                                              title:@"发现"
                                                          titleFont:[UIFont systemFontOfSize:10]];
    
    LATabBarItem *item4 = [[LATabBarItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabbar_40"]
                                                        selectImage:[UIImage imageNamed:@"tabbar_41"]
                                                        normalColor:[UIColor lightGrayColor]
                                                        selectColor:[UIColor colorWithCSS:@"#328BEF"]
                                                              title:@"我的"
                                                          titleFont:[UIFont systemFontOfSize:10]];
    
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithCSS:@"#cccccc"];
    
    LATabBar *tabBar = [[LATabBar alloc] initWithItems:@[item1, item2, item3, item4]
                                               topLine:line];
    
    
    
    return tabBar;
}

- (NSArray<UIViewController *> *)la_configViewControllers
{
    ViewController1 *vc1 = [ViewController1 new];
    ViewController2 *vc2 = [ViewController2 new];
    ViewController3 *vc3 = [ViewController3 new];
    ViewController4 *vc4 = [ViewController4 new];
    
    return @[vc1, vc2, vc3, vc4];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
