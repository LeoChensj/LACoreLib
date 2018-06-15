//
//  LATabBarItem.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/13.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LATabBarItem : UIControl

@property (nonatomic, assign)BOOL isSelect;
@property (nonatomic, assign)BOOL isNotice;
@property (nonatomic, assign)NSUInteger badgeNumber;


- (instancetype)initWithNormalImage:(UIImage *)normalImage
                        selectImage:(UIImage *)selectImage
                        normalColor:(UIColor *)normalColor
                        selectColor:(UIColor *)selectColor
                              title:(NSString *)title
                          titleFont:(UIFont *)titleFont;

@end
