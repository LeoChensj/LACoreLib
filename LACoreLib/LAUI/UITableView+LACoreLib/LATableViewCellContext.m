//
//  LATableViewCellContext.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/6/11.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LATableViewCellContext.h"

@implementation LATableViewCellContext

+ (instancetype)contextFrom:(UITableView *)tableView
                  indexPath:(NSIndexPath *)indexPath
{
    LATableViewCellContext *context = [LATableViewCellContext  new];
    
    context.tableView = tableView;
    context.indexPath = indexPath;
    
    context.isFirst = (indexPath.row == 0);
    context.isLast = (indexPath.row == (([tableView.dataSource tableView:tableView
                                                   numberOfRowsInSection:indexPath.section]) - 1));
    
    return context;
}

- (void)dealloc
{
    NSLog(@"dealloc-LATableViewCellContext");
}

@end
