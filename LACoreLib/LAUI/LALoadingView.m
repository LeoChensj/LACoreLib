//
//  LALoadingView.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LALoadingView.h"
#import "LAUI.h"


@interface LALoadingView ()

@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIActivityIndicatorView *activityView;

@end


@implementation LALoadingView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _contentView.backgroundColor = [UIColor la_colorWithColor:[UIColor blackColor] alpha:0.7];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 3;
        _contentView.la_centerX = LA_SCREEN_WIDTH * 0.5;
        _contentView.la_centerY = LA_SCREEN_HEIGHT * 0.5 - LA_TopBarHeight;
        [self addSubview:_contentView];
        
    }
    
    return self;
}

- (void)start
{
    
}

- (void)stop
{
    
}

@end
