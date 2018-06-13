//
//  LATabBarItem.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/13.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LATabBarItem.h"
#import "UIKit+LACoreLib.h"


@interface LATabBarItem ()

@property (nonatomic, strong)UIImageView *imgvIcon;
@property (nonatomic, strong)UILabel *lbTitle;
@property (nonatomic, strong)UIView *vBadge;
@property (nonatomic, strong)UILabel *lbBadge;


@property (nonatomic, strong)UIImage *normalImage;
@property (nonatomic, strong)UIImage *selectImage;

@property (nonatomic, strong)UIColor *normalColor;
@property (nonatomic, strong)UIColor *selectColor;

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)UIFont *titleFont;

@end



@implementation LATabBarItem

- (instancetype)initWithNormalImage:(UIImage *)normalImage
                        selectImage:(UIImage *)selectImage
                        normalColor:(UIColor *)normalColor
                        selectColor:(UIColor *)selectColor
                              title:(NSString *)title
                          titleFont:(UIFont *)titleFont
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.normalImage = normalImage;
        self.selectImage = selectImage;
        self.normalColor = normalColor;
        self.selectColor = selectColor;
        self.title = title;
        self.titleFont = titleFont;
        
        
        
        _imgvIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, normalImage.size.width, normalImage.size.height)];
        [self addSubview:_imgvIcon];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = normalColor;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.text = title;
        _lbTitle.font = titleFont;
        [self addSubview:_lbTitle];
        
        
        _vBadge = [[UIView alloc] init];
        _vBadge.layer.masksToBounds = YES;
        _vBadge.layer.cornerRadius = 4;
        _vBadge.backgroundColor = [UIColor colorWithCSS:@"#"];
        [self addSubview:_vBadge];
        
        
        
    }
    
    return self;
}




- (void)layoutSubviews
{
    
}

@end
