//
//  ViewController1.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "ViewController1.h"

#import "TestViewController1.h"


@interface ViewController1 ()

@end


@implementation ViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Leo";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController1 *vc = [TestViewController1 new];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end