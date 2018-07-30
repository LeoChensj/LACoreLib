//
//  LAPickerView.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/7/27.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LAPickerViewType) {
    LAPickerViewTypeNormal      = 0,
    LAPickerViewTypeDate        = 1,
    LAPickerViewTypeTime        = 2,
    LAPickerViewTypeRegion      = 3,
};


@interface LAPickerView : UIView

#pragma mark - Config property
/*
 类型
 普通选择器: 可以为单列或多列选择，根据数据源区分
 日期选择器: 年、月、日选择
 时间选择器: 小时、分钟选择
 地区选择器: 省、市、区选择
 */
@property (nonatomic, assign) LAPickerViewType type;

/*
 文本颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/*
 文本字体
 */
@property (nonatomic, strong) UIFont *textFont;

/*
 选择器高度
 默认: 260
 */
@property (nonatomic, assign) CGFloat contentHeight;

/*
 确定按钮
 在这配置按钮的展示
 */
@property (nonatomic, strong, readonly) UIButton *btnConfirm;





#pragma mark - DataSource
/*
 普通选择器
 */

/*
 普通选择器的数据源
 二维数组
 */
@property (nonatomic, strong) NSArray <NSArray <NSString *>*>*dataArrayNormal;


/*
 日期选择器
 */

/*
 可选择的最小日期
 默认: 0年1月1日
 */
@property (nonatomic, strong) NSDate *minDate;

/*
 可选择的最大日期
 默认: 2100年12月31日
 */
@property (nonatomic, strong) NSDate *maxDate;





#pragma mark - Method
/*
 初始化方法
 */
- (instancetype)initWithType:(LAPickerViewType)type;

/*
 显示
 */
- (void)showInWindow;

/*
 隐藏
 */
- (void)hiddenInWindow;

@end
