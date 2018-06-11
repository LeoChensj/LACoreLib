//
//  LABaseTableViewHeaderFooterView.m
//  
//
//  Created by Leo.Chen on 2018/4/24.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABaseTableViewHeaderFooterView.h"

@implementation LABaseTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    
    return self;
}

- (void)setModel:(id)model
{
    _model = model;
    
    [self configUI:model];
}


#pragma mark - public Method
+ (CGFloat)headerFooterHeightWithModel:(id)model section:(NSInteger)section
{
    return 0;
}

- (UIColor *)configBackgroundColor
{
    return [UIColor clearColor];
}

- (void)createUI
{
    
}

- (void)configUI:(id)model
{
    
}

@end
