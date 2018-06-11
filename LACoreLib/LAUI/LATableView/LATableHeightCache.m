//
//  LATableHeightCache.m
//  
//
//  Created by Leo.Chen on 2018/5/14.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "LATableHeightCache.h"


@interface LATableHeightCache ()

@property (nonatomic, strong)NSMutableDictionary *dictHeight;

@end


@implementation LATableHeightCache

- (NSString *)cellKeyForIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath)
    {
        return [NSString stringWithFormat:@"cell_%li_%li", indexPath.section, indexPath.row];
    }
    
    return nil;
}

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexParh
{
    NSString *key = [self cellKeyForIndexPath:indexParh];
    
    if(key)
    {
        NSNumber *height = [self.dictHeight objectForKey:key];
        
        return (height ? height.floatValue : -1);
    }
    
    return -1;
}

- (void)addCellCacheHeight:(CGFloat)height indexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self cellKeyForIndexPath:indexPath];
    
    if(key)
    {
        [self.dictHeight setObject:@(height) forKey:key];
    }
}

- (void)removeCellCacheForIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self cellKeyForIndexPath:indexPath];
    
    if(key)
    {
        [self.dictHeight removeObjectForKey:key];
    }
}







- (void)clearCache
{
    [self.dictHeight removeAllObjects];
}






#pragma mark - 懒加载
- (NSMutableDictionary *)dictHeight
{
    if(!_dictHeight)
    {
        _dictHeight = [[NSMutableDictionary alloc] init];
    }
    
    return _dictHeight;
}



@end
