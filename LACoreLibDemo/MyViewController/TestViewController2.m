//
//  TestViewController2.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "TestViewController2.h"
#import "TestViewController1.h"
#import "PNavigationController.h"
#import "LANavigator.h"


@interface TestViewController2 ()

@end

@implementation TestViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"禁止左滑pop";
}


//禁止左滑pop
- (BOOL)configEnablePopGestureRecognizer
{
    return NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController1 *vc = [TestViewController1 new];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
