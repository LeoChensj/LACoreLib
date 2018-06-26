//
//  LALoadingView.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 子类可重写init方法自定义加载视图
 */

@interface LALoadingView : UIView

/*
 开始加载动画
 */
- (void)start;

/*
 停止加载动画
 */
- (void)stop;

@end
