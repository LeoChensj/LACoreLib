//
//  UITableViewCell+LACoreLib.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LATableViewCellItem.h"
#import "LATableViewCellContext.h"


@interface UITableViewCell (LACoreLib)

+ (CGFloat)la_heightForItem:(LATableViewCellItem * _Nullable)item
                    context:(LATableViewCellContext * _Nullable)context;

@property (nonatomic, strong, readonly, nullable) LATableViewCellItem *la_cellItem;

- (void)la_configure:(LATableViewCellItem * _Nullable)item
             context:(LATableViewCellItem * _Nullable)context NS_REQUIRES_SUPER;

@end
