//
//  LATabBar.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LATabBar.h"
#import "LABase.h"
#import "LAUI.h"

@interface LATabBar ()

@property (nonatomic, strong)NSArray <LATabBarItem *>*la_items;

@end



@implementation LATabBar

- (instancetype)initWithItems:(NSArray <LATabBarItem *>*)items
              backgroungColor:(UIColor *)backgroungColor
                 isEffectView:(BOOL)isEffectView
                     haveLine:(BOOL)haveLine
{
    if(self = [super init])
    {
        if(items.count < 2 || items.count > 5)
        {
            LACoreLibWarn(@"LATabBar items.count out of range");
            
            return nil;
        }
        else
        {
            self.backgroundColor = backgroungColor;
            
            
            if(isEffectView)
            {
                UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, 0, LA_SCREEN_WIDTH, LA_TabBarHeight)];
                effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
                [self addSubview:effectView];
            }
            
            if(haveLine)
            {
                UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LA_SCREEN_WIDTH, LA_LineMinHeight)];
                topLine.backgroundColor = [UIColor la_colorWithCSS:@"#CCCCCC"];
                [self addSubview:topLine];
            }
            
            
            
            self.la_items = items;
            CGFloat itemWidth = LA_SCREEN_WIDTH/items.count;
            for (NSUInteger i = 0; i < items.count; i++)
            {
                LATabBarItem *item = items[i];
                item.frame = CGRectMake(i*itemWidth, 0, itemWidth, 49);
                
                if(i == 0)
                {
                    item.isSelect = YES;
                }
                
                [self addSubview:item];
                
                item.tag = i;
                [item addTarget:self action:@selector(onSelected:) forControlEvents:UIControlEventTouchUpInside];
                [item addTarget:self action:@selector(onSelectedRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
            }
        }
    }
    
    return self;
}

- (void)setSelectIndex:(NSUInteger)selectIndex
{
    if(_selectIndex != selectIndex)
    {
        _selectIndex = selectIndex;
        
        if(selectIndex >= self.la_items.count)
        {
            LACoreLibWarn(@"(LATabBar)selectIndex out of items.count");
            
            return;
        }
        
        for (NSUInteger i = 0; i < self.la_items.count; i++)
        {
            if(selectIndex == i)
            {
                self.la_items[i].isSelect = YES;
            }
            else
            {
                self.la_items[i].isSelect = NO;
            }
        }
    }
    
    if(self.blockSelect)
    {
        self.blockSelect(selectIndex);
    }
}

- (void)layoutSubviews
{
    /*
    [self.la_items la_mapArrayWithBlock:^id(NSUInteger idx, LATabBarItem *obj) {
        
        [self bringSubviewToFront:obj];
        
        return obj;
        
    }];
    
    [self bringSubviewToFront:self.topLine];
     */
}


#pragma mark - Event
- (void)onSelected:(LATabBarItem *)item
{
    NSUInteger index = item.tag;
    
    self.selectIndex = index;
}

- (void)onSelectedRepeat:(LATabBarItem *)item
{
    NSUInteger index = item.tag;
    
    self.selectIndex = index;
    
    if(self.blockSelectRepeat)
    {
        self.blockSelectRepeat(index);
    }
}

@end
