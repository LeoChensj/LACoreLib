//
//  UIKit+LACoreLib.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "UIKit+LACoreLib.h"


@implementation UIView (LACoreLib_Frame)

- (CGFloat)la_x
{
    return self.frame.origin.x;
}

- (void)setLa_x:(CGFloat)la_x
{
    CGRect frame = self.frame;
    frame.origin.x = la_x;
    self.frame = frame;
}

- (CGFloat)la_y
{
    return self.frame.origin.y;
}

- (void)setLa_y:(CGFloat)la_y
{
    CGRect frame = self.frame;
    frame.origin.y = la_y;
    self.frame = frame;
}

- (CGFloat)la_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLa_bottom:(CGFloat)la_bottom
{
    self.frame = CGRectMake(self.la_x, la_bottom - self.la_height, self.la_width, self.la_height);
}

- (CGFloat)la_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLa_right:(CGFloat)la_right
{
    self.frame = CGRectMake(la_right - self.la_width, self.la_y, self.la_width, self.la_height);
}

- (CGFloat)la_centerX
{
    return self.center.x;
}

- (void)setLa_centerX:(CGFloat)la_centerX
{
    CGPoint center = self.center;
    center.x = la_centerX;
    self.center = center;
}

- (CGFloat)la_centerY
{
    return self.center.y;
}

- (void)setLa_centerY:(CGFloat)la_centerY
{
    CGPoint center = self.center;
    center.y = la_centerY;
    self.center = center;
}

- (CGFloat)la_width
{
    return self.frame.size.width;
}

- (void)setLa_width:(CGFloat)la_width
{
    CGRect frame = self.frame;
    frame.size.width = la_width;
    self.frame = frame;
}

- (CGFloat)la_height
{
    return self.frame.size.height;
}

- (void)setLa_height:(CGFloat)la_height
{
    CGRect frame = self.frame;
    frame.size.height = la_height;
    self.frame = frame;
}

- (CGPoint)la_origin
{
    return self.frame.origin;
}

- (void)setLa_origin:(CGPoint)la_origin
{
    CGRect frame = self.frame;
    frame.origin = la_origin;
    self.frame = frame;
}

- (CGSize)la_size
{
    return self.frame.size;
}

- (void)setLa_size:(CGSize)la_size
{
    CGRect frame = self.frame;
    frame.size = la_size;
    self.frame = frame;
}

@end






@implementation UIColor (LACoreLib_Hex)

+ (UIColor *)la_colorWithCSS:(NSString *)css
{
    NSString *colorString = [[css stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self la_colorComponentFrom: colorString start: 0 length: 1];
            green = [self la_colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self la_colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self la_colorComponentFrom: colorString start: 0 length: 1];
            red   = [self la_colorComponentFrom: colorString start: 1 length: 1];
            green = [self la_colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self la_colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self la_colorComponentFrom: colorString start: 0 length: 2];
            green = [self la_colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self la_colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self la_colorComponentFrom: colorString start: 0 length: 2];
            red   = [self la_colorComponentFrom: colorString start: 2 length: 2];
            green = [self la_colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self la_colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (UIColor *)la_colorWithHex:(NSUInteger)hex
{
    CGFloat red, green, blue, alpha;
    
    red = ((CGFloat)((hex >> 16) & 0xFF)) / ((CGFloat)0xFF);
    green = ((CGFloat)((hex >> 8) & 0xFF)) / ((CGFloat)0xFF);
    blue = ((CGFloat)((hex >> 0) & 0xFF)) / ((CGFloat)0xFF);
    alpha = hex > 0xFFFFFF ? ((CGFloat)((hex >> 24) & 0xFF)) / ((CGFloat)0xFF) : 1;
    
    return [UIColor colorWithRed: red green:green blue:blue alpha:alpha];
}

+ (UIColor *)la_colorWithColor:(UIColor *)color
                      alpha:(CGFloat)alpha
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat al = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&al];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


#pragma mark - Private
+ (CGFloat)la_colorComponentFrom:(NSString *)string
                        start:(NSUInteger)start
                       length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end





@implementation UIImage (LACoreLib)

+ (UIImage *)la_lanchImage
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if (orientation == UIDeviceOrientationUnknown)
    {
        orientation = UIDeviceOrientationPortrait;
    }
    
    return [self la_launchImageFromSize:screenSize
                            orientation:orientation];
}

+ (UIImage *)la_launchImageFromSize:(CGSize)screenSize
                        orientation:(UIDeviceOrientation)orientation
{
    __block NSString *imageName = nil;
    
    NSString *portraitOrLandscape = (UIDeviceOrientationIsPortrait(orientation)
                                     ? @"Portrait"
                                     : @"Landscape");
    
    NSArray<NSDictionary *> *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    [imagesDict enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict,
                                             NSUInteger idx,
                                             BOOL * _Nonnull stop) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        NSString *orientationString = dict[@"UILaunchImageOrientation"];
        if (CGSizeEqualToSize(screenSize, imageSize)
            && [portraitOrLandscape isEqualToString:orientationString]) {
            imageName = dict[@"UILaunchImageName"];
        }
    }];
    
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)la_imageWithColor:(UIColor *)color
{
    return [UIImage la_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)la_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0,0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIImage *)la_resizeImageToSize:(CGSize)imageSize
{
    if (self.size.width == 0 || self.size.height == 0) return nil;
    
    CGFloat widthRatio = imageSize.width / self.size.width;
    CGFloat heightRatio = imageSize.height / self.size.height;
    CGFloat ratio = MAX(widthRatio, heightRatio);
    
    CGRect frame = CGRectMake(0,
                              0,
                              self.size.width * ratio,
                              self.size.height * ratio);
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, self.scale);
    [self drawInRect:frame];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (NSData *)la_convertToData
{
    NSData *dataImage = nil;
    if(UIImagePNGRepresentation(self)==nil)
    {
        dataImage = UIImageJPEGRepresentation(self, 1);
    }
    else
    {
        dataImage = UIImagePNGRepresentation(self);
    }
    
    return dataImage;
}

@end




@implementation UIScrollView (LACoreLib)

- (void)la_disableContentInsetAdjust
{
    if (@available(iOS 11.0, *))
    {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

@end


@implementation UITableView (LACoreLib_EstimatedHeight)

- (void)la_disableEstimatedHeight
{
    if (@available(iOS 11.0, *))
    {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}

@end




@implementation UITextField (QHCoreLib)

- (void)setPlaceholder:(NSString *)placeholder
                 color:(UIColor *)color
                  font:(UIFont *)font
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    if (color) [attrs setObject:color forKey:NSForegroundColorAttributeName];
    if (font) [attrs setObject:font forKey:NSFontAttributeName];
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder ?: @""
                                                                 attributes:attrs];
}

@end









