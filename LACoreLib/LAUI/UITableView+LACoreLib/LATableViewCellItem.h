//
//  LATableViewCellItem.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LATableViewCellItem : NSObject

+ (instancetype)itemFromCellClass:(Class)cellClass
                             data:(id _Nullable)data;

@property (nonatomic, strong, readonly) Class cellClass;

@property (nonatomic, strong, readonly) id data;

@end
