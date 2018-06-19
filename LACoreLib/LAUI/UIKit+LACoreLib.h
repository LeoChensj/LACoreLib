//
//  UIKit+LACoreLib.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface UIView (LACoreLib_Frame)

@property (nonatomic) CGFloat la_x;

@property (nonatomic) CGFloat la_y;

@property (nonatomic) CGFloat la_bottom;

@property (nonatomic) CGFloat la_right;

@property (nonatomic) CGFloat la_centerX;

@property (nonatomic) CGFloat la_centerY;

@property (nonatomic) CGFloat la_width;

@property (nonatomic) CGFloat la_height;

@property (nonatomic) CGPoint la_origin;

@property (nonatomic) CGSize la_size;

@end




@interface UIColor (LACoreLib_Hex)

+ (UIColor *)la_colorWithCSS:(NSString *)css;

+ (UIColor *)la_colorWithHex:(NSUInteger)hex;

+ (UIColor *)la_colorWithColor:(UIColor *)color
                      alpha:(CGFloat)alpha;

@end




@interface UIImage (LACoreLib)

+ (UIImage *)la_lanchImage;

+ (UIImage *)la_launchImageFromSize:(CGSize)screenSize
                        orientation:(UIDeviceOrientation)orientation;

+ (UIImage *)la_imageWithColor:(UIColor *)color;

+ (UIImage *)la_imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)la_resizeImageToSize:(CGSize)imageSize;

- (NSData *)la_convertToData;

@end



@interface UIScrollView (LACoreLib)

- (void)la_disableContentInsetAdjust;

@end

@interface UITableView (LACoreLib_EstimatedHeight)

- (void)la_disableEstimatedHeight;

@end




@interface UITextField (QHCoreLib)

- (void)setPlaceholder:(NSString *)placeholder
                 color:(UIColor *)color
                  font:(UIFont *)font;

@end











