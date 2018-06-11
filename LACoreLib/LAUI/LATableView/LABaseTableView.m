//
//  LABaseTableViewCell.m
//  
//
//  Created by Leo.Chen on 2018/4/24.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABaseTableView.h"


@interface LABaseTableView ()

@property (nonatomic, strong)LATableHeightCache *cache;

@end


@implementation LABaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self = [super initWithFrame:frame style:style])
    {
        self.contentInset = UIEdgeInsetsZero;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        
        if (@available(iOS 11.0, *))
        {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
//        self.canRefresh = YES;
//        self.canLoadmore = YES;
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self initWithFrame:CGRectZero style:style];
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (void)reloadData
{
    [self.cache clearCache];
    
    [super reloadData];
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.cache clearCache];
    
    [super reloadSections:sections withRowAnimation:animation];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self.cache clearCache];
    
    [super reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}










#pragma mark - UITableView DataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.blockSectionNumberConfig)
    {
        return self.blockSectionNumberConfig();
    }
    else
    {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.blockRowNumberInSectionConfig)
    {
        return self.blockRowNumberInSectionConfig(section);
    }
    else
    {
        ConfigWarning(@"blockRowNumberInSectionConfig");
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.blockCellClassConfig)
    {
        if(self.blockCellModelConfig)
        {
            CGFloat heightCache = [self.cache cellHeightForIndexPath:indexPath];
            if(heightCache>0)//有缓存
            {
                return heightCache;
            }
            else//第一次加载没有缓存 计算并添加缓存
            {
                CGFloat height = [self.blockCellClassConfig(indexPath) cellHeightWithModel:self.blockCellModelConfig(indexPath) indexPath:indexPath];
                
                [self.cache addCellCacheHeight:height indexPath:indexPath];
                
                return height;
            }
        }
        else
        {
            return 23;
        }
    }
    else
    {
        ConfigWarning(@"blockCellClassConfig");
        
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    if(self.blockCellClassConfig)
    {
        identifier = NSStringFromClass(self.blockCellClassConfig(indexPath));
    }
    else
    {
        ConfigWarning(@"blockCellClassConfig");
        return nil;
    }
    
    
    //创建or复用cell
    LABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[self.blockCellClassConfig(indexPath) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    //cell自定义事件
    __weak typeof(self) weakSelf = self;
    [cell setValue:^(NSInteger type, id model) {
        
        if(weakSelf.blockCellCustomEvent)
        {
            weakSelf.blockCellCustomEvent(type, model, indexPath);
        }
        
    } forKey:@"blockCustomEvent"];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(LABaseTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.blockCellModelConfig)
    {
        [cell setValue:self.blockCellModelConfig(indexPath) forKey:@"model"];
        
        
        BOOL isFirst = (indexPath.row==0);
        BOOL isLast = (indexPath.row==(self.blockRowNumberInSectionConfig(indexPath.section)-1));
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@(isFirst) forKey:@"isFirst"];
        [dict setObject:@(isLast) forKey:@"isLast"];
        [cell setValue:dict forKey:@"context"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.blockHeaderClassConfig && self.blockHeaderModelConfig)
    {
        return [self.blockHeaderClassConfig(section) headerFooterHeightWithModel:self.blockHeaderModelConfig(section) section:section];
    }
    else
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headIdentifier = nil;
    if(self.blockHeaderClassConfig)
    {
        headIdentifier = NSStringFromClass(self.blockHeaderClassConfig(section));
    }
    else
    {
        return nil;
    }
    
    
    //创建or复用header
    LABaseTableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    if(header == nil)
    {
        header = [[self.blockHeaderClassConfig(section) alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    
    //自定义header事件
    __weak typeof(self) weakSelf = self;
    [header setValue:^(NSInteger type, id model) {
        
        if(weakSelf.blockHeaderCustomEvent)
        {
            weakSelf.blockHeaderCustomEvent(type, model, section);
        }
        
    } forKey:@"blockCustomEvent"];
    
    
    return header;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(LABaseTableViewHeaderFooterView *)view forSection:(NSInteger)section
{
    if(self.blockHeaderClassConfig)
    {
        [view.contentView setBackgroundColor:[view configBackgroundColor]];
    }
    
    if(self.blockHeaderModelConfig)
    {
        [view setValue:self.blockHeaderModelConfig(section) forKey:@"model"];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(self.blockFooterClassConfig && self.blockFooterModelConfig)
    {
        return [self.blockFooterClassConfig(section) headerFooterHeightWithModel:self.blockFooterModelConfig(section) section:section];
    }
    else
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString *footIdentifier = nil;
    if(self.blockFooterClassConfig)
    {
        footIdentifier = NSStringFromClass(self.blockFooterClassConfig(section));
    }
    else
    {
        return nil;
    }
    
    
    //创建or复用footer
    LABaseTableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footIdentifier];
    if(footer == nil)
    {
        footer = [[self.blockFooterClassConfig(section) alloc] initWithReuseIdentifier:footIdentifier];
    }
    
    
    //自定义footer事件
    __weak typeof(self) weakSelf = self;
    [footer setValue:^(NSInteger type, id model) {
        
        if(weakSelf.blockFooterCustomEvent)
        {
            weakSelf.blockFooterCustomEvent(type, model, section);
        }
        
    } forKey:@"blockCustomEvent"];
    
    
    return footer;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(LABaseTableViewHeaderFooterView *)view forSection:(NSInteger)section
{
    if(self.blockFooterClassConfig)
    {
        [view.contentView setBackgroundColor:[view configBackgroundColor]];
    }
    
    if(self.blockFooterModelConfig)
    {
        [view setValue:self.blockFooterModelConfig(section) forKey:@"model"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
    
    if(self.blockSelectItem)
    {
        if(self.blockCellModelConfig)
        {
            self.blockSelectItem(self.blockCellModelConfig(indexPath), indexPath);
        }
        else
        {
            self.blockSelectItem(nil, indexPath);
        }
    }
}





#pragma mark - Reader
- (LATableHeightCache *)cache
{
    if(!_cache)
    {
        _cache = [[LATableHeightCache alloc] init];
    }
    
    return _cache;
}


#pragma mark - Setter
/*
- (void)setCanRefresh:(BOOL)canRefresh
{
    _canRefresh = canRefresh;
    
    if (canRefresh)
    {
        __weak typeof(self) weakSelf = self;
        self.mj_header = [YNRefreshHeader headerWithRefreshingBlock:^{
            
            (weakSelf.canRefresh && weakSelf.blockRefresh) ? weakSelf.blockRefresh(weakSelf.mj_header) : nil;
            
        }];
    }
    else
    {
        self.mj_header = nil;
    }
}

- (void)setCanLoadmore:(BOOL)canLoadmore
{
    _canLoadmore = canLoadmore;
    
    if(canLoadmore)
    {
        __weak typeof(self) weakSelf = self;
        self.mj_footer = ({
            
            MJRefreshFooter *footer = [YNRefreshFooter ynRefreshFooter:^{
                
                (weakSelf.canLoadmore && weakSelf.blockLoadmore) ? weakSelf.blockLoadmore(weakSelf.mj_footer) : nil;
                
            }];
            if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
            {
                footer.height += 14;
            }
            [YNSharedUtil setStateTitlesForMJRefreshFooter:footer];
            footer;
        });
    }
    else
    {
        self.mj_footer = nil;
    }
}
*/




@end
