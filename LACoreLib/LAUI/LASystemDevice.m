//
//  LASystemDevice.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LASystemDevice.h"

float LA_iOSSystemVersion()
{
    return [UIDevice currentDevice].systemVersion.floatValue;
}

BOOL LA_isIPhoneX()
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}

BOOL LA_isIPhonePlus()
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO);
}

LA_EXTERN BOOL LA_isIPhone6(void)
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO);
}

BOOL LA_isIPhone5_SE()
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
}








