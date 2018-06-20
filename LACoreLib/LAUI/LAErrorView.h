//
//  LAErrorView.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//  子类自定义

#import <UIKit/UIKit.h>

@interface LAErrorView : UIControl

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *lbText;
@property (nonatomic, strong)UIButton *btnReload;


/*
 配置网络错误的展示
 根据当前网络状态区分是'网络错误'还是'接口错误'
 子类重写
 */
- (void)configNetworkErrorViewWithError:(NSError *)error;

/*
 配置没有数据的展示
 子类重写
 */
- (void)configNoDataView;



/*
 更新图片
 */
- (void)setupImage:(UIImage *)image;

/*
 更新文本
 */
- (void)setupText:(NSString *)text;


@end
