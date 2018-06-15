//
//  LABaseViewController.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LABase.h"
#import "LAUI.h"


LA_EXTERN NSString * const LABaseViewControllerInfoKeyTitle;
LA_EXTERN NSString * const LABaseViewControllerInfoKeyPreviousController;
LA_EXTERN NSString * const LABaseViewControllerInfoKeyOnSusseccPopToController;



@interface LABaseViewController : UIViewController <UINavigationControllerDelegate, UIGestureRecognizerDelegate>


#pragma mark - View
@property(nonatomic, strong, readonly) LANavigationBarButton *btnBack;
@property(nonatomic, strong, readonly) LANavigationBarButton *btnAction;

@property (nonatomic, strong) LALoadingView *loadingView;
@property (nonatomic, strong) LAErrorView *networkErrorView;
@property (nonatomic, strong) LAErrorView *noDataErrorView;





#pragma mark - Parameter Info
/*
 Push传递过来的所有参数
 */
@property (nonatomic, strong, readonly) NSDictionary *info;

/*
 默认传递的参数
 表示Push过来的那个控制器，即上一个控制器
 */
@property (nonatomic, strong, readonly) UIViewController *previousController;

/*
 上一个控制器传过来的参数，非必传
 表示此控制提交成功后返回到哪一个控制器
 即调用onSuccessBack返回的控制器
 */
@property (nonatomic, strong, readonly) UIViewController *onSusseccPopToController;




#pragma mark - Navigation
/*
 配置导航栏title颜色
 */
- (UIColor *)configColorForTitle;

/*
 配置导航栏title字体
 */
- (UIFont *)configFontForTitle;

/*
 右侧action按钮回调，根据需要重写
 */
- (void)onAction;

/*
 配置导航栏按钮，根据需要重写
 */
- (void)configNavigationBarButtons;

/*
 是否允许左滑pop控制器
 子类重写控制
 */
- (BOOL)configEnablePopGestureRecognizer;




#pragma mark - StatusBarStyle
/*
 配置状态栏颜色
 */
- (UIStatusBarStyle)configStatusBarStyle;







#pragma mark - Layout
- (CGFloat)contentTopInset;
- (CGFloat)contentBottomInset;
- (CGFloat)contentLeftInset;
- (CGFloat)contentRightInset;

@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, assign, readonly) CGRect contentRect;





#pragma mark - 加载动画视图
/*
 子类重写该方法，返回LALoadingView子类，在LALoadingView子类中自定义加载动画
 */
- (LALoadingView *)configLoadingView;




#pragma mark - ErrorView
/*
 子类重写该方法，返回LAErrorView子类，在LAErrorView子类中自定义
 */
- (LAErrorView *)configErrorView;

/*
 网络错误视图显示后，触发重新加载的回调
 */
- (void)onNetworkErrorViewReload;

/*
 没有数据的缺省视图的显示文本
 */
- (NSString *)configNoDataText;

/*
 没有数据视图显示后，触发重新加载的回调
 */
- (void)onNoDataErrorViewReload;





@end
