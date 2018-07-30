//
//  ViewController1.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/14.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "ViewController1.h"

#import "LANavigator.h"

#import "LANetwork.h"

#import "LABannerView.h"

#import "LAPickerView.h"



@interface ViewController1 ()

@end


@implementation ViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Leo";
    
    //self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    
//    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, LA_SCREEN_WIDTH, 400)];
//    picker.backgroundColor = [UIColor whiteColor];
//    [picker setValue:[UIColor redColor] forKey:@"textColor"];
//    picker.datePickerMode = UIDatePickerModeDate;
//    [self.view addSubview:picker];
    
    
    
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [LANavigator navigationToUrl:@"tvc1" vcInfo:nil animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
