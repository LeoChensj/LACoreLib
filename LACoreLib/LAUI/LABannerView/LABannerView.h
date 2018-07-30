//
//  LABannerView.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/7/25.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LABannerViewTapBlock)(NSUInteger index);

@interface LABannerView : UIView

#pragma mark - config property
/*
 是否显示pageControl
 默认: YES
 */
@property (nonatomic, assign) BOOL isShowPageControl;

/*
 pageControl普通颜色
 默认: lightGrayColor
 */
@property (nonatomic, strong) UIColor *pageControlNormalColor;

/*
 pageControl选中颜色
 默认: 白色
 */
@property (nonatomic, strong) UIColor *pageControlSelectColor;

/*
 是否自动轮播
 默认: YES
 注意: 如果自动轮播设置为YES，需要在控制器主动调用releaseTimer方法释放定时器
 */
@property (nonatomic, assign) BOOL isAutoPlay;

/*
 轮播间隔时间
 默认: 5s
 */
@property (nonatomic, assign) NSTimeInterval playInterval;

/*
 是否衔接动画（"无限"轮播）
 默认: YES
 */
@property (nonatomic, assign) BOOL isCircular;


/*
 当前显示位置
 默认: 0
 */
@property (nonatomic, assign, readonly) NSUInteger index;



#pragma DataSource Block
/*
 数据源
 元素是UIImage或NSString
 */
@property (nonatomic, strong) NSArray *dataArray;

/*
 点击Banner元素回调
 */
@property (nonatomic, strong) LABannerViewTapBlock blockTap;



#pragma mark - Method
- (void)releaseTimer;

@end
