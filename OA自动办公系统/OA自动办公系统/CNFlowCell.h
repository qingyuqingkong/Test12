//
//  CNFlowCell.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/17.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNFlowInfo;
@interface CNFlowCell : UITableViewCell

//创建cell
+ (instancetype)loadCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) CNFlowInfo *moedl;
@end
