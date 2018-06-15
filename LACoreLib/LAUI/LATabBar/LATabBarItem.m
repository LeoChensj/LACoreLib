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
        _vBadge.backgroundColor = [UIColor colorWithCSS:@"#FF4C4C"];
        [self addSubview:_vBadge];
        
        
        _lbBadge = [[UILabel alloc] init];
        _lbBadge.backgroundColor = [UIColor colorWithCSS:@"#FF4C4C"];
        _lbBadge.layer.masksToBounds = YES;
        _lbBadge.layer.cornerRadius = 8;
        _lbBadge.textColor = [UIColor whiteColor];
        _lbBadge.textAlignment = NSTextAlignmentCenter;
        _lbBadge.font = [UIFont systemFontOfSize:10];
        [self addSubview:_lbBadge];
        
        
        
        self.isSelect = NO;
        self.isNotice = NO;
        self.badgeNumber = 0;
    }
    
    return self;
}

#pragma mark - Layout
- (void)layoutSubviews
{
    _imgvIcon.la_y = 8;
    _imgvIcon.la_centerX = self.la_width*0.5;
    
    _lbTitle.la_width = self.la_width;
    _lbTitle.la_height = self.titleFont.pointSize;
    _lbTitle.la_y = _imgvIcon.la_bottom + 8;
    _lbTitle.la_centerX = self.la_width*0.5;
    
    _vBadge.la_width = 8;
    _vBadge.la_height = 8;
    _vBadge.la_x = _imgvIcon.la_right;
    _vBadge.la_bottom = _imgvIcon.la_y + 6;
    
    _lbBadge.la_width = 16;
    _lbBadge.la_height = 16;
    _lbBadge.la_y = 3;
    _lbBadge.la_x = self.la_width*0.5 + 10;
}

#pragma mark - Setter
- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    
    if(isSelect)
    {
        _imgvIcon.image = _selectImage;
        _lbTitle.textColor = _selectColor;
    }
    else
    {
        _imgvIcon.image = _normalImage;
        _lbTitle.textColor = _normalColor;
    }
}

- (void)setIsNotice:(BOOL)isNotice
{
    _isNotice = isNotice;
    
    _vBadge.hidden = !isNotice;
    
    if(self.badgeNumber!=0)
    {
        _vBadge.hidden = YES;
    }
}

- (void)setBadgeNumber:(NSUInteger)badgeNumber
{
    _badgeNumber = badgeNumber;
    
    if(badgeNumber<=0)
    {
        _lbBadge.text = nil;
        _lbBadge.hidden = YES;
    }
    else if(badgeNumber<100)
    {
        _lbBadge.text = [NSString stringWithFormat:@"%zd", badgeNumber];
        _lbBadge.hidden = NO;
        _vBadge.hidden = YES;
    }
    else
    {
        _lbBadge.text = @"···";
        _lbBadge.hidden = NO;
        _vBadge.hidden = YES;
    }
}

@end
