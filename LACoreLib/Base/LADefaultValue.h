//
//  LADefaultValue.h
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/7.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LADefines.h"


LA_EXTERN BOOL LABool(id value, BOOL defaultValue);

LA_EXTERN NSInteger LAInteger(id value, NSInteger defaultValue);

LA_EXTERN double LADouble(id value, double defaultValue);

LA_EXTERN NSString * LAString(id value, NSString * _Nullable defaultValue);

LA_EXTERN NSArray * LAArray(id value, NSArray * _Nullable defaultValue);

LA_EXTERN NSDictionary * LADictionary(id value, NSDictionary * _Nullable defaultValue);
