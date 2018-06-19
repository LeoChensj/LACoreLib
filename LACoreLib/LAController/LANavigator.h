//
//  LANavigator.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/19.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LABaseViewController.h"


@interface LANavigator : NSObject

+ (void)navigationToUrl:(NSString *)url
                 vcInfo:(NSDictionary *)vcInfo
               animated:(BOOL)animated;

+ (void)presentToUrl:(NSString *)url
              vcInfo:(NSDictionary *)vcInfo
          navigation:(Class)navigationControllerClass
            animated:(BOOL)animated;

+ (void)navigationToController:(LABaseViewController *)vc
                        vcInfo:(NSDictionary *)vcInfo
        inNavigationController:(UINavigationController *)navigationController
                      animated:(BOOL)animated;

+ (UINavigationController *)currentNavigationController;

@end
