//
//  PBaseViewController.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "PBaseViewController.h"
#import "PErrorView.h"


@interface PBaseViewController ()

@end


@implementation PBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIColor *)configColorForTitle
{
    return [UIColor la_colorWithCSS:@"#328BEF"];
}

- (UIFont *)configFontForTitle
{
    return [UIFont systemFontOfSize:18];
}

- (void)configNavigationBarButtons
{
    [super configNavigationBarButtons];
    
    [self.btnBack setImage:[UIImage imageNamed:@"ic_back_black"]];
}

- (LAErrorView *)configNetworkErrorView
{
    return [[PErrorView alloc] init];
}

- (LAErrorView *)configNoDataErrorView
{
    return [[PErrorView alloc] init];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
