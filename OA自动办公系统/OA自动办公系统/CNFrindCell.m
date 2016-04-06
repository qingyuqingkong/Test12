//
//  CNFrindCell.m
//  qq好友列表
//
//  Created by AIogle on 15/11/12.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNFrindCell.h"
#import "CNFriend.h"
@implementation CNFrindCell

+ (instancetype)friendCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"friend_cell";
    CNFrindCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CNFrindCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
    
}
//重新set方法
- (void)setFriendModel:(CNFriend *)friendModel{
    _friendModel = friendModel;
    
    //把模型中的数据设置给单元格的子控件
    self.imageView.image = [UIImage imageNamed:friendModel.icon];
    self.textLabel.text = friendModel.name;
    self.detailTextLabel.text = friendModel.intro;
    
    //根据当前的好友是不是vip来决定是否将昵称是否显示为蓝色
    self.textLabel.textColor = friendModel.isOnline ? [UIColor blueColor] : [UIColor blackColor];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
