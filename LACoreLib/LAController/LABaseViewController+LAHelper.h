//
//  LABaseViewController+LAHelper.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABaseViewController.h"

@interface LABaseViewController (LAHelper)

/*
 pop到上一个控制器
 */
- (void)la_onBack;

/*
 pop到上几级控制器
 step=1等价于la_onBack
 */
- (void)la_onBackStep:(NSUInteger)step;

/*
 提交成功后返回可以调用此方法，pop到onSusseccPopToController
 */
- (void)la_onSuccessBack;


/*
 显示加载动画
 */
- (void)la_showLoadingView;

/*
 隐藏加载动画
 */
- (void)la_hideLoadingView;


/*
 显示网络错误缺省视图
 */
- (void)la_showNetworkErrorView:(NSError *)error;

/*
 隐藏网络错误缺省视图
 */
- (void)la_hideNetworkErrorView;


/*
 显示无数据缺省视图
 */
- (void)la_showNoDataErrorView;

/*
 隐藏无数据缺省视图
 */
- (void)la_hideNoDataErrorView;














@end

























