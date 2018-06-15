//
//  ViewController2.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "ViewController2.h"

#import "TestViewController2.h"


@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Chen";
}

- (UIColor *)configColorForTitle
{
    return [UIColor redColor];
}

- (UIFont *)configFontForTitle
{
    return [UIFont systemFontOfSize:18];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController2 *vc = [TestViewController2 new];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
