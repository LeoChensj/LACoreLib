//
//  LANavigationBarButton.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LANavigationBarButtonType) {
    LANavigationBarButtonTypeText = 0,
    LANavigationBarButtonTypeImage,
};


@interface LANavigationBarButton : UIButton

@property (nonatomic, assign)LANavigationBarButtonType type;


+ (instancetype)buttonWithBarType:(LANavigationBarButtonType)buttonType;


- (void)setText:(NSString *)text
          color:(UIColor *)color
           font:(UIFont *)font;

- (void)setImage:(UIImage *)image;

@end
