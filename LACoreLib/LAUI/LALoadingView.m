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
        _contentView.layer.cornerRadius = 4;
        _contentView.la_centerX = LA_SCREEN_WIDTH * 0.5;
        _contentView.la_centerY = LA_SCREEN_HEIGHT * 0.5 - LA_TopBarHeight;
        [self addSubview:_contentView];
        
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.hidesWhenStopped = YES;
        _activityView.la_centerX = _contentView.la_width * 0.5;
        _activityView.la_y = 20;
        [_contentView addSubview:_activityView];
        
        
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, _activityView.la_bottom + 20, _contentView.la_width, 12)];
        lbTitle.text = @"正在加载...";
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.textColor = [UIColor whiteColor];
        lbTitle.font = [UIFont systemFontOfSize:12];
        [_contentView addSubview:lbTitle];
    }
    
    return self;
}

- (void)start
{
    self.hidden = NO;
    [_activityView startAnimating];
}

- (void)stop
{
    [_activityView stopAnimating];
    self.hidden = YES;
}

@end
