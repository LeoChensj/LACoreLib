//
//  LAErrorView.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LAErrorView.h"

@implementation LAErrorView

@synthesize imageView = _imageView;
@synthesize lbText = _lbText;
@synthesize btnReload = _btnReload;



- (void)configNetworkErrorViewWithError:(NSError *)error
{
    
}


- (void)configNoDataView
{
    
}


- (void)setupImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)setupText:(NSString *)text
{
    _lbText.text = text;
}

@end
