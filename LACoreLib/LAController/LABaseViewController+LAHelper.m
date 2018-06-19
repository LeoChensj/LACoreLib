//
//  LABaseViewController+LAHelper.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABaseViewController+LAHelper.h"

@implementation LABaseViewController (LAHelper)

- (void)la_onBack
{
    [self la_onBackStep:1];
}

- (void)la_onBackStep:(NSUInteger)step
{
    if(self.navigationController && step != 0)
    {
        if(step == 1)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSArray *vcs = self.navigationController.viewControllers;
            
            UIViewController *vc = [vcs la_objectAtIndex:vcs.count - 1 - step];
            
            if(vc)
            {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }
}

- (void)la_onSuccessBack
{
    UIViewController *vc = self.onSusseccPopToController;
    if (vc &&
        [self.navigationController.viewControllers containsObject:vc])
    {
        [self.navigationController popToViewController:vc animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)la_showLoadingView
{
    if(!self.loadingView)
    {
        [self setValue:[self configLoadingView] forKey:@"loadingView"];
        [self.view addSubview:self.loadingView];
    }
    
    self.loadingView.frame = self.view.bounds;
    self.loadingView.hidden = NO;
    [self.view bringSubviewToFront:self.loadingView];
    
    [self.loadingView start];
}

- (void)la_hideLoadingView
{
    self.loadingView.hidden = YES;
}

- (void)la_showNetworkErrorView:(NSError *)error
{
    if (self.networkErrorView == nil)
    {
        [self setValue:[self configErrorView] forKey:@"networkErrorView"];
        [self.networkErrorView addTarget:self
                                  action:@selector(onNetworkErrorViewReload)
                        forControlEvents:UIControlEventTouchUpInside];
        
        if(self.networkErrorView.btnAction)
        {
            [self.networkErrorView.btnAction addTarget:self
                                                action:@selector(onNetworkErrorViewReload)
                                      forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.view addSubview:self.networkErrorView];
    }
    
    [self.networkErrorView updateViewWithError:error];
    self.networkErrorView.frame = self.view.bounds;
    [self.view bringSubviewToFront:self.networkErrorView];
    self.networkErrorView.hidden = NO;
}

- (void)la_hideNetworkErrorView
{
    self.networkErrorView.hidden = YES;
}

- (void)la_showNoDataErrorView
{
    if (self.noDataErrorView == nil)
    {
        [self setValue:[self configErrorView] forKey:@"noDataErrorView"];
        [self.noDataErrorView addTarget:self
                                 action:@selector(onNoDataErrorViewReload)
                       forControlEvents:UIControlEventTouchUpInside];
        
        if(self.noDataErrorView.btnAction)
        {
            [self.noDataErrorView.btnAction addTarget:self
                                               action:@selector(onNoDataErrorViewReload)
                                     forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.view addSubview:self.noDataErrorView];
    }
    
    [self.noDataErrorView updateViewWithText:[self configNoDataText]];
    self.noDataErrorView.frame = self.view.bounds;
    [self.view bringSubviewToFront:self.noDataErrorView];
    self.noDataErrorView.hidden = NO;
}

- (void)la_hideNoDataErrorView
{
    self.noDataErrorView.hidden = YES;
}

@end
