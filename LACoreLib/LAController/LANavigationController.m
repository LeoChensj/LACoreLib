//
//  LANavigationController.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LANavigationController.h"


@interface LANavigationController ()

@property (nonatomic, strong)LANavigationBar *la_navigationBar;

@end


@implementation LANavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.la_navigationBar = [self la_configNavigationBar];
    [self setValue:self.la_navigationBar forKey:@"navigationBar"];
}

- (LANavigationBar *)la_configNavigationBar;
{
    return [[LANavigationBar alloc] initWithBarType:UIBarStyleDefault
                                    backgroundImage:nil
                                       barTintColor:nil
                                        translucent:YES
                                         titileFont:[UIFont systemFontOfSize:16]
                                         titleColor:[UIColor blackColor]
                                           haveLine:YES];
}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

@end
