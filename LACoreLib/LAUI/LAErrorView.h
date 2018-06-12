//
//  LAErrorView.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/12.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LAErrorView : UIControl

@property (nonatomic, strong, readonly)UIButton *btnAction;

- (void)updateViewWithError:(NSError *)error;
- (void)updateViewWithText:(NSString *)text;

@end
