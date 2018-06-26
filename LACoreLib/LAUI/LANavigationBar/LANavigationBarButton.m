//
//  LANavigationBarButton.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LANavigationBarButton.h"



@implementation LANavigationBarButton

+ (instancetype)buttonWithBarType:(LANavigationBarButtonType)buttonType
{
    LANavigationBarButton *button = [[LANavigationBarButton alloc] initWithFrame:CGRectZero];
    button.type = buttonType;
    
    return button;
}

- (void)setText:(NSString *)text
          color:(UIColor *)color
           font:(UIFont *)font
{
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    self.titleLabel.font = font;
}

- (void)setImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}



@end
