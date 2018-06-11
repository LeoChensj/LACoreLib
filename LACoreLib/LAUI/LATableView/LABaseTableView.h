//
//  LABaseTableViewCell.h
//  
//
//  Created by Leo.Chen on 2018/4/24.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "LATableHeightCache.h"
#import "LABaseTableViewCell.h"
#import "LABaseTableViewHeaderFooterView.h"


#pragma mark - Block定义
typedef NSInteger(^LABaseTableViewSectionNumberConfigBlock)(void);
typedef NSInteger(^LABaseTableViewRowNumberInSectionConfigBlock)(NSInteger section);
typedef Class(^LABaseTableViewCellClassConfigBlock)(NSIndexPath *indexPath);
typedef id(^LABaseTableViewCellModelConfigBlock)(NSIndexPath *indexPath);
typedef Class(^LABaseTableViewHeaderClassConfigBlock)(NSInteger section);
typedef id(^LABaseTableViewHeaderModelConfigBlock)(NSInteger section);
typedef Class(^LABaseTableViewFooterClassConfigBlock)(NSInteger section);
typedef id(^LABaseTableViewFooterModelConfigBlock)(NSInteger section);

typedef void(^LABaseTableViewSelectItemBlock)(id model, NSIndexPath *indexPath);
typedef void(^LABaseTableViewCellCustomEventBlock)(NSInteger type, id model, NSIndexPath *indexPath);
typedef void(^LABaseTableViewHeaderCustomEventBlock)(NSInteger type, id model, NSInteger section);
typedef void(^LABaseTableViewFooterCustomEventBlock)(NSInteger type, id model, NSInteger section);

//typedef void(^LABaseTableViewRefreshBlock)(MJRefreshHeader *header);
//typedef void(^LABaseTableViewLoadmoreBlock)(MJRefreshFooter *footer);




@interface LABaseTableView : UITableView <UITableViewDataSource, UITableViewDelegate>


#pragma mark - 配置
/*
 返回值：section数量
 */
@property (nonatomic, strong)LABaseTableViewSectionNumberConfigBlock blockSectionNumberConfig;

/*
 必须配置
 返回值：row数量
 */
@property (nonatomic, strong)LABaseTableViewRowNumberInSectionConfigBlock blockRowNumberInSectionConfig;

/*
 必须配置
 cell所属类的配置
 indexPath与cell所属类的对应关系
 返回值：cell所属类
 */
@property (nonatomic, strong)LABaseTableViewCellClassConfigBlock blockCellClassConfig;

/*
 cell对应model配置
 indexPath与cell所对应model的对应关系
 返回值：cell对应model
 */
@property (nonatomic, strong)LABaseTableViewCellModelConfigBlock blockCellModelConfig;

/*
 header所属类的配置
 indexPath与header所属类的对应关系
 返回值：header所属类
 */
@property (nonatomic, strong)LABaseTableViewHeaderClassConfigBlock blockHeaderClassConfig;

/*
 header对应model配置
 indexPath与header所对应model的对应关系
 返回值：header对应model
 */
@property (nonatomic, strong)LABaseTableViewHeaderModelConfigBlock blockHeaderModelConfig;

/*
 footer所属类的配置
 indexPath与footer所属类的对应关系
 返回值：footer所属类
 */
@property (nonatomic, strong)LABaseTableViewFooterClassConfigBlock blockFooterClassConfig;

/*
 footer对应model配置
 indexPath与footer所对应model的对应关系
 返回值：footer对应model
 */
@property (nonatomic, strong)LABaseTableViewFooterModelConfigBlock blockFooterModelConfig;

///*
// 下拉刷新
// */
//@property (nonatomic, strong)LABaseTableViewRefreshBlock blockRefresh;
//
///*
// 上拉加载更多
// */
//@property (nonatomic, strong)LABaseTableViewLoadmoreBlock blockLoadmore;
//
///*
// 是否允许下拉刷新
// 默认YES
// */
//@property (nonatomic, assign)BOOL canRefresh;
//
///*
// 是否允许上拉加载更多
// 默认YES
// */
//@property (nonatomic, assign)BOOL canLoadmore;




#pragma mark - 事件
/*
 点击cell回调
 */
@property (nonatomic, strong)LABaseTableViewSelectItemBlock blockSelectItem;

/*
 cell上自定义事件的回调
 */
@property (nonatomic, strong)LABaseTableViewCellCustomEventBlock blockCellCustomEvent;

/*
 header上自定义事件的回调
 */
@property (nonatomic, strong)LABaseTableViewHeaderCustomEventBlock blockHeaderCustomEvent;

/*
 footer上自定义事件的回调
 */
@property (nonatomic, strong)LABaseTableViewFooterCustomEventBlock blockFooterCustomEvent;



#pragma mark - Method
- (instancetype)initWithStyle:(UITableViewStyle)style;


@end


#define ConfigWarning(_warning)     NSLog(@"请配置%@", _warning)


