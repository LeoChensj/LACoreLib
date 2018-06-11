//
//  LABaseTableViewCell.m
//  
//
//  Created by Leo.Chen on 2018/4/24.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABaseTableViewCell.h"


@implementation LABaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.selectedBackgroundView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [self configSelectColor];
            view;
        });
        
        [self createUI];
    }
    
    return self;
}



- (void)setModel:(id)model
{
    _model = model;
    
    [self configUI:model];
}

- (void)setContext:(NSDictionary *)context
{
    _context = context;
    
    NSNumber *isFirst = context[@"isFirst"];
    NSNumber *isLast = context[@"isLast"];
    
    [self configContextIsFirst:isFirst.boolValue isLast:isLast.boolValue];
}









#pragma mark - public Method
+ (CGFloat)cellHeightWithModel:(id)model indexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UIColor *)configSelectColor
{
    return [UIColor clearColor];
}

- (void)createUI
{
    
}

- (void)configUI:(id)model
{
    
}

- (void)configContextIsFirst:(BOOL)isFirst isLast:(BOOL)isLast
{
    
}

@end
