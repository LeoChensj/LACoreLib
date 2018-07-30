//
//  LABannerViewCell.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/7/25.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABannerViewCell.h"
#import "UIImageView+WebCache.h"


@interface LABannerViewCell ()

@property (nonatomic, strong) UIImageView *imgv;

@end


@implementation LABannerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              frame.size.width,
                                                              frame.size.height)];
        _imgv.clipsToBounds = YES;
        _imgv.contentMode = UIViewContentModeScaleAspectFill;
        _imgv.userInteractionEnabled = NO;
        [self.contentView addSubview:_imgv];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _imgv.image = image;
}

- (void)setUrlImage:(NSString *)urlImage
{
    _urlImage = urlImage;
    
    [_imgv sd_setImageWithURL:[NSURL URLWithString:urlImage]
             placeholderImage:_placeholderImage];
}

@end
