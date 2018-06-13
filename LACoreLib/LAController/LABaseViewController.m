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

@property(nonatomic, strong) LANavigationBarButton *btnBack;
@property(nonatomic, strong) LANavigationBarButton *btnAction;

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
    
    [self configLayout];
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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [self configColorForTitle], NSFontAttributeName: [self configFontForTitle]}];
    
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
    return [UIColor blackColor];
}

- (UIFont *)configFontForTitle
{
    return [UIFont systemFontOfSize:16];
}

- (void)configBackButton
{
    _btnBack = [LANavigationBarButton buttonWithBarType:LANavigationBarButtonTypeImage];
    [_btnBack addTarget:self action:@selector(la_onBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnBack];
}

- (void)configActionButton
{
    _btnAction = [LANavigationBarButton buttonWithBarType:LANavigationBarButtonTypeImage];
    [_btnAction addTarget:self action:@selector(onAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnAction];
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






#pragma mark - Layout
- (void)configLayout
{
    if (@available(iOS 11.0, *))
    {
        self.contentInsets = self.view.safeAreaInsets;
    }
    else
    {
        self.contentInsets = UIEdgeInsetsMake(self.contentTopInset,
                                              self.contentLeftInset,
                                              self.contentBottomInset,
                                              self.contentRightInset);
    }
    [self.view setNeedsLayout];
}

- (CGFloat)contentTopInset
{
    if(self.navigationController)
    {
        return LA_TopBarHeight;
    }
    
    return LA_StatusBarHeight;
}

- (CGFloat)contentBottomInset
{
    if(self.tabBarController &&
       self.tabBarController.tabBar.hidden == NO)
    {
        return LA_TabBarHeight;
    }
    
    return 0;
}

- (CGFloat)contentLeftInset
{
    return 0;
}

- (CGFloat)contentRightInset
{
    return 0;
}

-(void)viewSafeAreaInsetsDidChange
{
    if (@available(iOS 11.0, *))
    {
        [super viewSafeAreaInsetsDidChange];
        
        self.contentInsets = self.view.safeAreaInsets;
        
        [self.view setNeedsLayout];
    }
}

- (CGRect)contentRect
{
    return CGRectMake(self.contentInsets.left,
                      self.contentInsets.top,
                      self.view.la_width - self.contentInsets.left - self.contentInsets.right,
                      self.view.la_height - self.contentInsets.top - self.contentInsets.bottom);
}





#pragma mark - 加载动画
- (Class)configLoadingView;
{
    return [LALoadingView class];
}





#pragma mark - ErrorView
- (Class)configErrorView
{
    return [LAErrorView class];
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



@end
