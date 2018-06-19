//
//  TestViewController1.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "TestViewController1.h"
#import "LABaseViewController+LAHelper.h"


@interface TestViewController1 ()

@property (nonatomic, assign)BOOL statusBarStyleFlag;

@end

@implementation TestViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"test1";
    
    self.statusBarStyleFlag = NO;
}

- (UIStatusBarStyle)configStatusBarStyle
{
    return (self.statusBarStyleFlag
            ? UIStatusBarStyleDefault
            : UIStatusBarStyleLightContent);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.statusBarStyleFlag = !self.statusBarStyleFlag;
    [self setNeedsStatusBarAppearanceUpdate];
    
    if(self.statusBarStyleFlag)
    {
        [self la_showLoadingView];
    }
    else
    {
        [self la_hideLoadingView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
