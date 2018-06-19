//
//  TestViewController3.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/19.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "TestViewController3.h"
#import "LANavigator.h"
#import "TestViewController1.h"
#import "LABaseViewController+LAHelper.h"


@interface TestViewController3 ()

@end

@implementation TestViewController3

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"test3";
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)configNavigationBarButtons
{
    [self.btnBack setText:@"取消"
                    color:[UIColor grayColor]
                     font:[UIFont systemFontOfSize:14]];
    
    self.btnBack.hidden = NO;
}

- (void)onBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [LANavigator navigationToUrl:@"tvc2" vcInfo:nil animated:YES];
}

@end
