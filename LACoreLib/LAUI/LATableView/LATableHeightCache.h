//
//  LATableHeightCache.h
//  
//
//  Created by Leo.Chen on 2018/5/14.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LATableHeightCache : NSObject

/*
 根据indexPath返回缓存cell的key
 cell_indexPath.section_indexPath.row
 such as: cell_0_1
 */
- (NSString *)cellKeyForIndexPath:(NSIndexPath *)indexPath;

/*
 获取cell缓存高度
 -1表示缓存不存在
 */
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexParh;

/*
 添加cell缓存
 */
- (void)addCellCacheHeight:(CGFloat)height indexPath:(NSIndexPath *)indexPath;

/*
 删除cell缓存
 */
- (void)removeCellCacheForIndexPath:(NSIndexPath *)indexPath;

/*
 清空缓存
 */
- (void)clearCache;

/*
 删除sections缓存
 */
//- (void)

@end
