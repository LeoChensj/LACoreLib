//
//  LANavigationBar.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/15.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LANavigationBar : UINavigationBar

- (instancetype)initWithBarType:(UIBarStyle)barStyle
                backgroundImage:(UIImage *)backgroundImage
                   barTintColor:(UIColor *)barTintColor
                    translucent:(BOOL)translucent
                     titileFont:(UIFont *)titileFont
                     titleColor:(UIColor *)titleColor
                       haveLine:(BOOL)haveLine;

@end
