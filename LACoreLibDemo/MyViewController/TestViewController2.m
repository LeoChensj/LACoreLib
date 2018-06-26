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

#import "TestNetworkApi.h"


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
//    TestViewController1 *vc = [TestViewController1 new];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    LA_WS(ws);
    
    [self la_showLoadingView];
    TestNetworkApi *api = [[TestNetworkApi alloc] init_with_page:1 size:20 context:@"Leo.Chen" finish:YES];
    [api requestWithSuccess:^(__kindof LANetworkBaseApi *api, __kindof NSObject *responseData) {
        
        [ws la_hideLoadingView];
        
    } fail:^(__kindof LANetworkBaseApi *api, LANetworkError *error) {
        
        [ws la_hideLoadingView];
        
    }];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
