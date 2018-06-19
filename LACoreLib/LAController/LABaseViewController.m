//
//  LABaseViewController.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABaseViewController.h"
#import "LABaseViewController+LAHelper.h"


NSString * const LABaseViewControllerInfoKeyTitle = @"LABaseViewControllerInfoKeyTitle";
NSString * const LABaseViewControllerInfoKeyPreviousController = @"LABaseViewControllerInfoKeyPreviousController";
NSString * const LABaseViewControllerInfoKeyOnSusseccPopToController = @"LABaseViewControllerInfoKeyOnSusseccPopToController";




@interface LABaseViewController ()



@end


@implementation LABaseViewController

- (instancetype)init
{
    if(self = [super init])
    {
        self.hidesBottomBarWhenPushed = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigationBar];
    
    [self configPopGestureRecognizer];
}






#pragma mark - Parameter Info
- (UIViewController *)previousController
{
    id obj = [self.info objectForKey:LABaseViewControllerInfoKeyPreviousController];
    
    LA_AS(obj, UIViewController, controller);
    if (controller) return controller;
    
    return nil;
}

- (UIViewController *)onSusseccPopToController
{
    id obj = [self.info objectForKey:LABaseViewControllerInfoKeyOnSusseccPopToController];
    
    LA_AS(obj, UIViewController, controller);
    if (controller) return controller;
    
    return nil;
}



#pragma mark - NavigationBar
- (void)configNavigationBar
{
    if([self configColorForTitle])
    {
        NSMutableDictionary *attrs =  [NSMutableDictionary dictionaryWithDictionary:self.navigationController.navigationBar.titleTextAttributes];
        [attrs setObject:[self configColorForTitle] forKey:NSForegroundColorAttributeName];
        
        [self.navigationController.navigationBar setTitleTextAttributes:attrs];
    }
    
    if([self configFontForTitle])
    {
        NSMutableDictionary *attrs =  [NSMutableDictionary dictionaryWithDictionary:self.navigationController.navigationBar.titleTextAttributes];
        [attrs setObject:[self configFontForTitle] forKey:NSFontAttributeName];
        
        [self.navigationController.navigationBar setTitleTextAttributes:attrs];
    }
    
    
    NSString *title = [self.info objectForKey:LABaseViewControllerInfoKeyTitle];
    if(LA_IS_STRING(title))
    {
        self.navigationItem.title = title;
    }
    
    [self configBackButton];
    [self configActionButton];
    [self configNavigationBarButtons];
}

- (UIColor *)configColorForTitle
{
    return nil;
}

- (UIFont *)configFontForTitle
{
    return nil;
}

- (void)configBackButton
{
    _btnBack = [LANavigationBarButton buttonWithBarType:LANavigationBarButtonTypeImage];
    [_btnBack addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnBack];
}

- (void)configActionButton
{
    _btnAction = [LANavigationBarButton buttonWithBarType:LANavigationBarButtonTypeImage];
    [_btnAction addTarget:self action:@selector(onAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnAction];
}

- (void)onBack
{
    [self la_onBack];
}

- (void)onAction
{
    //子类重写
}

- (void)configNavigationBarButtons
{
    _btnBack.hidden = ({
        BOOL flag = NO;
        
        if(!self.navigationController ||
           self.navigationController.viewControllers.count == 0)
        {
            flag = YES;
        }
        else
        {
            flag = [self.navigationController.viewControllers.firstObject isEqual:self];
        }
        
        flag;
    });
    
    _btnAction.hidden = YES;
}


#pragma mark - PopGestureRecognizer
- (void)configPopGestureRecognizer
{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

/*
 子类重写此方法可控制是否可以左滑pop
 */
- (BOOL)configEnablePopGestureRecognizer
{
    return ([self.navigationController.viewControllers firstObject] != self);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer)
    {
        return [self configEnablePopGestureRecognizer];
    }
    
    return YES;
}


#pragma mark - StatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self configStatusBarStyle];
}

- (UIStatusBarStyle)configStatusBarStyle;
{
    return UIStatusBarStyleDefault;
}








#pragma mark - 加载动画
- (LALoadingView *)configLoadingView
{
    return [[LALoadingView alloc] init];
}





#pragma mark - ErrorView
- (LAErrorView *)configErrorView;
{
    return nil;
}

- (void)onNetworkErrorViewReload
{
    //子类重写
}

- (NSString *)configNoDataText
{
    return @"have no data";
}

- (void)onNoDataErrorViewReload
{
    //子类重写
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    LALog(@"dealloc-%@", NSStringFromClass([self class]));
}


@end
