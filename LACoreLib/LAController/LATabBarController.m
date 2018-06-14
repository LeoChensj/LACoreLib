//
//  LATabBarController.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/13.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LATabBarController.h"
#import "LANavigationController.h"
#import "LABase.h"
#import "LAUI.h"


@interface LATabBarController ()

@property (nonatomic, strong)LATabBar *la_tabBar;

@end

@implementation LATabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    
    self.la_tabBar = [self la_configTabBar];
    [self setValue:self.la_tabBar forKey:@"tabBar"];
    
    __weak typeof(self) weakSelf = self;
    self.la_tabBar.blockSelect = ^(NSUInteger selectIndex) {
        
        weakSelf.selectedIndex = selectIndex;
        
    };
    
    
    
    self.viewControllers = [[self la_configViewControllers] la_mapArrayWithBlock:^id(NSUInteger idx, UIViewController *obj) {
        
        obj.hidesBottomBarWhenPushed = NO;
        return [[LANavigationController alloc] initWithRootViewController:obj];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.tabBar.hidden = NO;
}



- (LATabBar *)la_configTabBar
{
    return nil;
}

- (NSArray<UIViewController *> *)la_configViewControllers
{
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
