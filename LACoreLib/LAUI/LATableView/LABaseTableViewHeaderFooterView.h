//
//  LABaseTableViewHeaderFooterView.h
//  
//
//  Created by Leo.Chen on 2018/4/24.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LABaseTableViewHeaderFooterViewCustomEvent)(NSInteger type, id model);

@interface LABaseTableViewHeaderFooterView : UITableViewHeaderFooterView

/*
 数据模型
 */
@property (nonatomic, strong, readonly)id model;

/*
 header自定义方法
 在header的自定义方法事件中调用此block
 */
@property (nonatomic, strong, readonly)LABaseTableViewHeaderFooterViewCustomEvent blockCustomEvent;



/*
 配置header或footer的高度
 */
+ (CGFloat)headerFooterHeightWithModel:(id)model section:(NSInteger)section;

/*
 配置header或footer背景颜色
 */
- (UIColor *)configBackgroundColor;

/*
 创建子视图UI
 */
- (void)createUI;

/*
 配置子视图UI的展示
 */
- (void)configUI:(id)model;

@end
