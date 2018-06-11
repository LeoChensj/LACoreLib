//
//  AppDelegate.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/5.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "LACoreLib.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //NSArray *array = @[@21, @2, @13, @25, @8];
    
    //NSLog(@"%@", [array la_subarrayWithRange:NSMakeRange(3, 4)]);
    
    /*
    NSArray *res = [array la_filteredArrayWithBlock:^BOOL(NSUInteger idx, id obj) {
        
        if(idx == 2 && LA_IS_NUMBER(obj))
        {
            return NO;
        }
        
        return YES;
        
    }];
    NSLog(@"%@", res);
    */
    
    /*
    NSArray *res = [array la_mapArrayWithBlock:^id(NSUInteger idx, id obj) {
        
        LA_AS(obj, NSNumber, model);
        
        return @(model.integerValue+1);
        
    }];
    LALog(@"%@", res);
    */
    
    //LALog(@"%@", [array la_toJSON]);
    
    //LALog(@"%li", [array la_integerAtIndex:12 defaultValue:888]);
    
//    LALog(@"%@", [NSBundle la_mainBundle_identifier]);
//    LALog(@"%@", [NSBundle la_mainBundle_version]);
//    LALog(@"%@", [NSBundle la_mainBundle_shortVersion]);
//    LALog(@"%@", [NSBundle la_mainBundle_name]);
//    LALog(@"%@", [NSBundle la_mainBundle_displayName]);
    
    //NSDate *date = [NSDate date];
    //LALog(@"%@", [date la_stringFromDateFormat:kLADateFormatFull]);
    
    //NSString *asd = [@"asdwqrergedaqwre" stringByReplacingOccurrencesOfString:@"asd" withString:@"123"];
    
    //NSLog(@"asd=%@", asd);
    
    //NSRange range = [@"qw123yrtasd" rangeOfString:@""];
    
    NSString *string = @"https://LeoChensj.com?id=123";
    
    NSLog(@"%@", [string la_encodingWithUTF8]);
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
