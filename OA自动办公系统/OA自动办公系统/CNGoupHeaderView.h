//
//  CNGoupHeaderView.h
//  qq好友列表
//
//  Created by AIogle on 15/11/12.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNGoupHeaderView;
@protocol CNGoupHeaderViewDelegate <NSObject>

- (void)groupHeaderViewDidClickGroupTitleButton:(CNGoupHeaderView *)groupHeaderView;

@end
@class CNGroup;
@interface CNGoupHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) CNGroup *group;

//增加一个代理属性
@property (nonatomic, weak) id<CNGoupHeaderViewDelegate> delegate;

+ (instancetype)groupHeaderViewWithTableView:(UITableView *)table;
@end
