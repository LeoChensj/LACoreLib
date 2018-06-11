//
//  UITableViewCell+LACoreLib.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "UITableViewCell+LACoreLib.h"
#import <objc/runtime.h>


@implementation UITableViewCell (LACoreLib)

+ (CGFloat)la_heightForItem:(LATableViewCellItem *)item
                    context:(LATableViewCellContext *)context
{
    return 44.0f;
}

static void *kLATableViewCellItemASOKey = &kLATableViewCellItemASOKey;

- (LATableViewCellItem *)la_cellItem
{
    return objc_getAssociatedObject(self, kLATableViewCellItemASOKey);
}

- (void)setLa_cellItem:(LATableViewCellItem * _Nullable)la_cellItem
{
    [self willChangeValueForKey:NSStringFromSelector(@selector(la_cellItem))];
    
    objc_setAssociatedObject(self,
                             kLATableViewCellItemASOKey,
                             la_cellItem,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self didChangeValueForKey:NSStringFromSelector(@selector(la_cellItem))];
}

- (void)la_configure:(LATableViewCellItem * _Nullable)item
             context:(LATableViewCellItem * _Nullable)context
{
    [self setLa_cellItem:item];
}


@end
