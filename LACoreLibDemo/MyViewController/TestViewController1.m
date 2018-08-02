//
//  TestViewController1.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "TestViewController1.h"
#import "LABaseViewController+LAHelper.h"
#import "LABannerView.h"
#import "LAPickerView.h"


@interface TestViewController1 ()

@property (nonatomic, assign) BOOL statusBarStyleFlag;

@property (nonatomic, strong) LABannerView *banner;
@property (nonatomic, strong) LAPickerView *pickView;

@property (nonatomic, strong) NSDate *today;

@end

@implementation TestViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"test1";
    
    self.statusBarStyleFlag = NO;
    
    
    
//    _banner = [[LABannerView alloc] initWithFrame:CGRectMake(0, 80, LA_SCREEN_WIDTH, 200)];
//    _banner.isAutoPlay = YES;
//    [self.view addSubview:_banner];
//    _banner.blockTap = ^(NSUInteger index) {
//
//        NSLog(@"index=%lu", (unsigned long)index);
//
//    };
//
//    _banner.dataArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1533112919&di=6c08aebfbc62786e675ca9f91a0ce315&imgtype=jpg&er=1&src=http%3A%2F%2Fpic5.photophoto.cn%2F20071228%2F0034034901778224_b.jpg",
//                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1532518200125&di=1d3f6a62134af389e20fd23a1b2fdbb6&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F13%2F71%2F35%2F24k58PICSiB_1024.jpg",
//                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1532518200125&di=931e844d8ab7be6e6f729a045493f6e4&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F63%2Fd%2F121.jpg"];
    
    
    
    
}

- (UIStatusBarStyle)configStatusBarStyle
{
    return (!self.statusBarStyleFlag
            ? UIStatusBarStyleDefault
            : UIStatusBarStyleLightContent);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.statusBarStyleFlag = !self.statusBarStyleFlag;
//    [self setNeedsStatusBarAppearanceUpdate];
    
//    if(self.statusBarStyleFlag)
//    {
//        [self la_showLoadingView];
//    }
//    else
//    {
//        [self la_hideLoadingView];
//    }
    
    //[self la_showNetworkErrorView:nil];
    
    //[self la_showNoDataErrorView];
    
    
    
    
    LAPickerView *pickView = [[LAPickerView alloc] initWithType:LAPickerViewTypeRegion];
    //_pickView.textColor = [UIColor la_colorWithCSS:@"#328BEF"];
    //_pickView.textFont = [UIFont systemFontOfSize:30];
    
    //    NSArray *arr1 = @[@"阿斯顿", @"请问", @"萨芬", @"饿", @"求我"];
    //    NSArray *arr2 = @[@"让他", @"会发光", @"沃尔特", @"大哥", @"儿童"];
    //    NSArray *arr3 = @[@"覆盖", @"而为", @"分", @"范围", @"饭"];
    //    pickView.dataArrayNormal = @[arr1, arr2, arr3];
    //    pickView.selectNormalIndex = @[@2, @1, @3];
    
//    pickView.minDate = [NSDate la_dateWithYear:2000 month:3 day:5];
//    pickView.maxDate = [NSDate la_dateWithYear:2020 month:6 day:18];
    //pickView.selectDate = [NSDate la_dateWithYear:2022 month:1 day:1];
    //    pickView.selectHour = 10;
    //    pickView.selectMinute = 30;
    
    //NSDate *testDate = [NSDate la_dateWithYear:2018 month:2 day:35];
    
    [pickView showInWindow];
}

- (void)onNetworkErrorViewReload
{
    [self la_hideNetworkErrorView];
    
    [self la_showNoDataErrorView];
}

- (void)onNoDataErrorViewReload
{
    [self la_hideNoDataErrorView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_banner releaseTimer];
}

@end
