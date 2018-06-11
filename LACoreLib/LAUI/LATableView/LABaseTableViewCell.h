//
//  LABaseTableViewCell.h
//  
//
//  Created by Leo.Chen on 2018/4/24.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LABaseTableViewCellCustomEvent)(NSInteger type, id model);


@interface LABaseTableViewCell : UITableViewCell

/*
 数据模型
 */
@property (nonatomic, strong, readonly)id model;

@property (nonatomic, strong, readonly)NSDictionary *context;

/*
 cell自定义方法
 在cell的自定义方法事件中调用此block
 */
@property (nonatomic, strong, readonly)LABaseTableViewCellCustomEvent blockCustomEvent;



/*
 配置cell高度
 */
+ (CGFloat)cellHeightWithModel:(id)model indexPath:(NSIndexPath *)indexPath;

/*
 配置cell选中颜色
 */
- (UIColor *)configSelectColor;

/*
 创建子cell的视图UI
 */
- (void)createUI;

/*
 配置子视图UI的展示
 */
- (void)configUI:(id)model;

- (void)configContextIsFirst:(BOOL)isFirst isLast:(BOOL)isLast;

@end
