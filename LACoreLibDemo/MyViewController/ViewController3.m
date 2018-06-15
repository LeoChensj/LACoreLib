//
//  ViewController3.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "ViewController3.h"
#import "TestViewController2.h"

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
    //TestViewController2 *vc = [TestViewController2 new];
    
    //[self.navigationController pushViewController:vc animated:YES];
    //[self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
