//
//  LATableViewCellContext.h
//  LACoreLib
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LATableViewCellContext : NSObject

+ (instancetype)contextFrom:(UITableView *)tableView
                  indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) BOOL isLast;


//@property (nonatomic, strong) NSString * _Nullable reuseIdentifier;

@property (nonatomic, strong) UIViewController * _Nullable controller;

// any thing
@property (nonatomic, strong) id _Nullable opaque;

@end
