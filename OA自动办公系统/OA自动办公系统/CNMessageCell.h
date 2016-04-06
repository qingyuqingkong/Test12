//
//  CNMessageCell.h
//  QQ聊天
//
//  Created by AIogle on 15/11/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNMessageFrame;
@interface CNMessageCell : UITableViewCell

//为自定义单元格增加一个frame
@property (nonatomic, strong) CNMessageFrame *messageFrame;

+ (instancetype)messageCellWithTableView:(UITableView *)tableView;
@end
