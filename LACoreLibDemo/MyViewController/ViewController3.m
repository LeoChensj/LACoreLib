//
//  ViewController3.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "ViewController3.h"
#import "TestViewController3.h"
#import "PNavigationController.h"
#import "LANavigator.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"发现";
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [LANavigator presentToUrl:@"tvc3" vcInfo:nil navigation:[PNavigationController class] animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
