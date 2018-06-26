//
//  LATabBar.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LATabBarItem.h"

typedef void(^LATabBarSelectBlock)(NSUInteger selectIndex);

@interface LATabBar : UITabBar

@property (nonatomic, assign)NSUInteger selectIndex;

@property (nonatomic, strong)LATabBarSelectBlock blockSelect;
@property (nonatomic, strong)LATabBarSelectBlock blockSelectRepeat;


- (instancetype)initWithItems:(NSArray <LATabBarItem *>*)items
              backgroungColor:(UIColor *)backgroungColor
                 isEffectView:(BOOL)isEffectView
                      haveLine:(BOOL)haveLine;

@end
