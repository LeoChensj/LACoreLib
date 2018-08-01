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




typedef void(^LAPickerViewNormalConfirmBlock)(NSArray <NSNumber *>*selectNormalIndex);
typedef void(^LAPickerViewDateConfirmBlock)(NSDate *selectDate);
typedef void(^LAPickerViewTimeConfirmBlock)(NSUInteger selectHour, NSUInteger selectMinute);
typedef void(^LAPickerViewRegionConfirmBlock)(NSString *selectProvince, NSString *selectCity, NSString *selectArea);


@interface LAPickerView : UIView

#pragma mark - Config property
/*
 类型
 普通选择器: 可以为单列或多列选择，根据数据源区分(dataArrayNormal)
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
 默认: 280
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
 普通选择的下标
 默认: [0, 0, ...]
 */
@property (nonatomic, strong) NSArray <NSNumber *>*selectNormalIndex;

/*
 普通选择器确定按钮回调
 */
@property (nonatomic, strong) LAPickerViewNormalConfirmBlock blockNormalConfirm;


/*
 日期选择器
 */

/*
 可选择的最小日期
 默认: 1年1月1日
 */
@property (nonatomic, strong) NSDate *minDate;

/*
 可选择的最大日期
 默认: 3000年1月1日
 */
@property (nonatomic, strong) NSDate *maxDate;

/*
 选择的日期
 默认: 今天
 */
@property (nonatomic, strong) NSDate *selectDate;

/*
 日期选择器确定按钮回调
 */
@property (nonatomic, strong) LAPickerViewDateConfirmBlock blockDateConfirm;



/*
 时间选择器
 */

/*
 选择的小时
 默认: 0
 */
@property (nonatomic, assign) NSUInteger selectHour;

/*
 选择的分钟
 默认: 0
 */
@property (nonatomic, assign) NSUInteger selectMinute;

/*
 时间选择器确定按钮回调
 */
@property (nonatomic, strong) LAPickerViewTimeConfirmBlock blockTimeConfirm;



/*
 地区选择器
 */

/*
 选择的省份
 默认: 北京
 */
@property (nonatomic, strong) NSString *selectProvince;

/*
 选择的城市
 默认: 北京
 */
@property (nonatomic, strong) NSString *selectCity;

/*
 选择的区
 默认: 东城区
 */
@property (nonatomic, strong) NSString *selectArea;

/*
 地区选择器确定按钮回调
 */
@property (nonatomic, strong) LAPickerViewRegionConfirmBlock blockRegionConfirm;





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
