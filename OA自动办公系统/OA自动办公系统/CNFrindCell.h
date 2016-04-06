//
//  CNFrindCell.h
//  qq好友列表
//
//  Created by AIogle on 15/11/12.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CNFriend;
@interface CNFrindCell : UITableViewCell

@property (nonatomic, strong) CNFriend *friendModel;

+ (instancetype)friendCellWithTableView:(UITableView *)tableView;

@end
