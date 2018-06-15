//
//  LANavigationBar.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/15.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LANavigationBar.h"
#import "LABase.h"
#import "LAUI.h"

@implementation LANavigationBar

- (instancetype)initWithBarType:(UIBarStyle)barStyle
                backgroundImage:(UIImage *)backgroundImage
                   barTintColor:(UIColor *)barTintColor
                    translucent:(BOOL)translucent
                     titileFont:(UIFont *)titileFont
                     titleColor:(UIColor *)titleColor
                       haveLine:(BOOL)haveLine;
{
    if(self = [super init])
    {
        self.barStyle = barStyle;

        [self setBackgroundImage:backgroundImage
                   forBarMetrics:UIBarMetricsDefault];
        
        if(!translucent)
        {
            [self setBarTintColor:barTintColor];
        }
        
        [self setTranslucent:translucent];
        
        self.titleTextAttributes = ({
            NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
            [attrs la_setObject:titileFont
                         forKey:NSFontAttributeName];
            [attrs la_setObject:titleColor
                         forKey:NSForegroundColorAttributeName];
            attrs;
        });
        
        
        if(!haveLine)
        {
            [self setShadowImage:[UIImage new]];
        }
    }
    
    return self;
}

@end
