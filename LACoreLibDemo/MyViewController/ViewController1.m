//
//  ViewController1.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "ViewController1.h"

#import "LANavigator.h"

#import "LANetwork.h"



@interface ViewController1 ()

@end


@implementation ViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Leo";
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[LANavigator navigationToUrl:@"tvc1" vcInfo:nil animated:YES];
    
    NSInteger asd = [LANetworkManager shareInstance].status;
    
    NSLog(@"asd=%li", asd);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
