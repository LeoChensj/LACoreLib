//
//  LATableViewCellItem.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LATableViewCellItem.h"

@interface LATableViewCellItem ()

@property (nonatomic, strong) Class cellClass;

@property (nonatomic, strong) id data;

@end


@implementation LATableViewCellItem

+ (instancetype)itemFromCellClass:(Class)cellClass
                             data:(id _Nullable)data
{
    LATableViewCellItem *item = [LATableViewCellItem new];
    
    item.cellClass = cellClass;
    item.data = data;
    
    return item;
}

- (BOOL)isEqual:(id)object
{
    if([object isKindOfClass:[self class]] == NO) return NO;
    
    typeof(self) other = (typeof(self))object;
    
    if(![self.cellClass isEqual:other.cellClass]) return NO;
    
    return  [self.data isEqual:other.data];
}

- (void)dealloc
{
    NSLog(@"dealloc-LATableViewCellItem");
}

@end
