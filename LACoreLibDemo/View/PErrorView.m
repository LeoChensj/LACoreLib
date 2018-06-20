//
//  PErrorView.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/20.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "PErrorView.h"
#import <Masonry/Masonry.h>
#import "LAUI.h"
#import "LABase.h"


@implementation PErrorView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        
        LA_WS(ws);
        
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(225);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(LA_TopBarHeight + 20);
            
        }];
        
        
        self.lbText = [[UILabel alloc] init];
        self.lbText.textColor = [UIColor lightGrayColor];
        self.lbText.textAlignment = NSTextAlignmentCenter;
        self.lbText.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.lbText];
        [self.lbText mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(ws.imageView.mas_bottom).offset(20);
            
        }];
        
        
        self.btnReload = [[UIButton alloc] init];
        self.btnReload.layer.masksToBounds = YES;
        self.btnReload.layer.cornerRadius = 4;
        self.btnReload.backgroundColor = [UIColor la_colorWithCSS:@"#328BEF"];
        [self.btnReload setTitle:@"刷新重试" forState:UIControlStateNormal];
        [self.btnReload setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnReload.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.btnReload];
        [self.btnReload mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(48);
            make.bottom.mas_equalTo(-30);
            
        }];
    }
    
    return self;
}




- (void)configNetworkErrorViewWithError:(NSError *)error
{
    self.imageView.image = [UIImage imageNamed:@"no_network_def"];
    
    self.lbText.text = @"网络错误，请稍后重试～";
    
    self.btnReload.hidden = NO;
}

- (void)configNoDataView
{
    self.imageView.image = [UIImage imageNamed:@"no_data_def"];
    
    self.lbText.text = @"没有数据，请稍后重试～";
    
    self.btnReload.hidden = NO;
}







@end
