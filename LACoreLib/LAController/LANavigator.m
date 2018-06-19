//
//  LANavigator.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/19.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LANavigator.h"
#import "LAControllerFactory.h"
#import "LANavigationController.h"


@implementation LANavigator

+ (void)navigationToUrl:(NSString *)url
                 vcInfo:(NSDictionary *)vcInfo
               animated:(BOOL)animated
{
    Class vcClass = [[LAControllerFactory shareInstance] controllerClassForUrl:url];
    
    UINavigationController *navigationController = [self currentNavigationController];
    
    
    [self navigationToController:[vcClass new]
                          vcInfo:vcInfo
          inNavigationController:navigationController
                        animated:animated];
}

+ (void)presentToUrl:(NSString *)url
              vcInfo:(NSDictionary *)vcInfo
          navigation:(Class)navigationControllerClass
            animated:(BOOL)animated
{
    Class vcClass = [[LAControllerFactory shareInstance] controllerClassForUrl:url];
    id vc = [vcClass new];
    UIViewController *theVC = vc;
    
    UINavigationController *navigationController = [self currentNavigationController];
    
    if(navigationControllerClass)
    {
        UINavigationController *nav = [navigationControllerClass new];
        nav.viewControllers = @[vc];
        theVC = nav;
    }
    
    [navigationController.topViewController presentViewController:theVC animated:animated completion:nil];
}






#pragma mark - Helper
+ (void)navigationToController:(LABaseViewController *)vc
                        vcInfo:(NSDictionary *)vcInfo
        inNavigationController:(UINavigationController *)navigationController
                      animated:(BOOL)animated
{
    LA_AS(vc, LABaseViewController, controller);
    
    if(!controller)
    {
        LACoreLibWarn(@"(LANavigator) push nil");
        
        return;
    }
    
    if(!navigationController)
    {
        LACoreLibWarn(@"(LANavigator) can't find navigationController");
        
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:vcInfo];
    
    LA_AS(navigationController.topViewController, LABaseViewController, topViewController);
    
    if(topViewController)
    {
        [dict setObject:topViewController
                 forKey:LABaseViewControllerInfoKeyPreviousController];
    }
    
    
    [vc setValue:dict forKey:@"info"];
    
    
    
    [navigationController pushViewController:vc
                                    animated:animated];
}

+ (UINavigationController *)currentNavigationController
{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *root = keyWindow.rootViewController;
    
    while (root.presentedViewController)
    {
        root = root.presentedViewController;
    }
    
    if([root isKindOfClass:[UINavigationController class]])
    {
        LA_AS(root, UINavigationController, navigationController);
        
        return navigationController;
    }
    else if([root isKindOfClass:[UITabBarController class]])
    {
        LA_AS(root, UITabBarController, tabBarController);
        
        return tabBarController.selectedViewController;
    }
    
    return root.navigationController;
}

@end
