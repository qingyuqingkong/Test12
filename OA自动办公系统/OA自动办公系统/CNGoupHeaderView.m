//
//  CNGoupHeaderView.m
//  qq好友列表
//
//  Created by AIogle on 15/11/12.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNGoupHeaderView.h"
#import "CNGroup.h"
@interface CNGoupHeaderView ()

@property (nonatomic, weak) UIButton *btnGroupTitle;
@property (nonatomic, weak) UILabel *lblCount;
@end
@implementation CNGoupHeaderView

+ (instancetype)groupHeaderViewWithTableView:(UITableView *)tableView{
    static NSString *headerID = @"headerID";
    CNGoupHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!header) {
        header = [[CNGoupHeaderView alloc] initWithReuseIdentifier:headerID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //创建按钮
        UIButton *btnGroupTitle = [[UIButton alloc] init];
        //设置按钮图片
        [btnGroupTitle setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [btnGroupTitle setTitleColor:[UIColor colorWithRed:226/255 green:226/255 blue:226/255 alpha:1] forState:UIControlStateNormal];
        //设置按钮默认的背景图片和高亮时的背景图片
        [btnGroupTitle setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        //设置按钮高亮的背景图片和高亮时的背景图片
        [btnGroupTitle setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        
        //设置按钮中的内容整体左对齐
        btnGroupTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置按钮的内容的内边距
        btnGroupTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置按钮标题距离左边的边距
        btnGroupTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        
        //为按钮增加一个点击事件
        [btnGroupTitle addTarget:self action:@selector(btnGroupTitleClicked) forControlEvents:UIControlEventTouchUpInside];
        
        //设置按钮中图片的显示模式
        btnGroupTitle.imageView.contentMode = UIViewContentModeCenter;
        //设置图片超出的部分不要截掉
        btnGroupTitle.imageView.clipsToBounds = NO;
        
        
        [self.contentView addSubview:btnGroupTitle];
        self.btnGroupTitle = btnGroupTitle;
        
        
        //创建label
        UILabel *lblCount = [[UILabel alloc] init];
        //设置label的文字大小
        lblCount.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:lblCount];
        lblCount.textAlignment = NSTextAlignmentRight;
        self.lblCount = lblCount;
        
    }
    return self;
}

//组标题的点击事件
- (void)btnGroupTitleClicked{
    //1.设置组的状态
    self.group.visible = !self.group.isVisible;
    
    //2.刷新tableview  通过代理来实现
    if ([self.delegate respondsToSelector:@selector(groupHeaderViewDidClickGroupTitleButton:)]) {
        //调用代理方法
        [self.delegate groupHeaderViewDidClickGroupTitleButton:self];
    }
   
}

//当一个新的headerView已经添加到某个父控件的时候执行
- (void)didMoveToSuperview{
    if (self.group.isVisible) {
        //3.让按钮中的图片实现旋转
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        //3.让按钮中的图片实现旋转
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

//重新group的set方法
- (void)setGroup:(CNGroup *)group{
    _group = group;
    
    //将模型中的数据设置给控件
    //设置数据
    [self.btnGroupTitle setTitle:group.name forState:UIControlStateNormal];
    //设置label上的数据
    self.lblCount.text = [NSString stringWithFormat:@"%d / %ld",group.online,group.friends.count];
    
    //设置按钮中的图片旋转问题
    if (self.group.isVisible) {
        //3.让按钮中的图片实现旋转
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        //3.让按钮中的图片实现旋转
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    
    
    //设置frame不要写在这个方法里面，因为在这里获取的当前控件（self）的宽和高都是0
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置fram
    self.btnGroupTitle.frame = self.bounds;
    
    //设置label的frame
    CGFloat lblW = 50;
    CGFloat lblH = self.bounds.size.height;
    CGFloat lblX = self.bounds.size.width - 10 - 55;
    CGFloat lblY = 0;
    self.lblCount.frame = CGRectMake(lblX, lblY, lblW, lblH);
    
    //self.btnGroupTitle.backgroundColor = [UIColor blueColor];
}

@end
