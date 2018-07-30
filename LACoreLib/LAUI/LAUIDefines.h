//
//  LAUIDefines.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#ifndef LAUIDefines_h
#define LAUIDefines_h

#import "LASystemDevice.h"


#define LA_SCREEN_WIDTH             CGRectGetWidth([[UIScreen mainScreen] bounds])
#define LA_SCREEN_HEIGHT            CGRectGetHeight([[UIScreen mainScreen] bounds])

#define LA_SCREEN_SCALE             ([UIScreen mainScreen].scale)

#define LA_StatusBarHeight          (LA_isIPhoneX() ? 44.f : 20.f)

#define LA_NavigationBarHeight      44.f

#define LA_TopBarHeight             (LA_StatusBarHeight + LA_NavigationBarHeight)

#define LA_TabBarHeight             (LA_isIPhoneX() ? 83.f : 49.f)

#define LA_BottomWhiteBarHeight     (LA_isIPhoneX() ? 34.f : 0.f)

#define LA_LineMinHeight            1.f/LA_SCREEN_SCALE

#define LA_KeyWindow                [UIApplication sharedApplication].keyWindow




#endif /* LAUIDefines_h */
