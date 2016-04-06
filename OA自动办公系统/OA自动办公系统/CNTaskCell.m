//
//  CNTaskCell.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/19.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNTaskCell.h"

@interface CNTaskCell ()
//发布人头像
@property (retain, nonatomic) IBOutlet UIImageView *icon;
//发布人名字
@property (retain, nonatomic) IBOutlet UILabel *name;

//发布任务时间
@property (retain, nonatomic) IBOutlet UILabel *time;

//备注
@property (retain, nonatomic) IBOutlet UILabel *remark;

//任务内容
@property (retain, nonatomic) IBOutlet UILabel *content;

//三个按钮 三个状态 未完成 完成 忽略
@property (retain, nonatomic) IBOutlet UIButton *unfinished;
@property (retain, nonatomic) IBOutlet UIButton *finished;
@property (retain, nonatomic) IBOutlet UIButton *ignore;

@end

@implementation CNTaskCell

//创建cell的方法
+ (instancetype)taskCell:(UITableView *)tableView{
    NSString *cellID = @"taskID";
    
    CNTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CNTaskCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    //设置视图的内容
    [self setViewContent];
}

- (void)setViewContent{
    //设置文字超出显示范围显示格式
    _content.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    //设置三个button
    UIImage *imageUnfinished = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"delete" ofType:@"ico"]]];
    UIImageView *imageViewUnfinished = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 18, 18)];
    imageViewUnfinished.image = imageUnfinished;
    
    UILabel *textUnfinished = [[UILabel alloc] initWithFrame:CGRectMake(21, 5, 30, 21)];
    textUnfinished.text = @"未完成";
    textUnfinished.font = [UIFont systemFontOfSize:10];
    textUnfinished.textColor =  [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
    [self.unfinished addSubview:textUnfinished];
    [self.unfinished addSubview:imageViewUnfinished];
    
    
    UIImage *imageFinished = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ok" ofType:@"png"]]];
    UIImageView *imageViewFinished = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 18, 18)];
    imageViewFinished.image = imageFinished;
    
    UILabel *textFinished = [[UILabel alloc] initWithFrame:CGRectMake(21, 5, 30, 21)];
    textFinished.text = @"完成";
    textFinished.font = [UIFont systemFontOfSize:10];
    textFinished.textColor =  [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
    [self.finished addSubview:textFinished];
    [self.finished addSubview:imageViewFinished];
    
    
    
    UIImage *imageIgnore = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cancel" ofType:@"png"]]];
    UIImageView *imageViewIgnore = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 16, 16)];
    imageViewIgnore.image = imageIgnore;
    
    UILabel *textIgnore = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 30, 21)];
    textIgnore.text = @"忽略";
    textIgnore.font = [UIFont systemFontOfSize:10];
    textIgnore.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
    [self.ignore addSubview:textIgnore];
    [self.ignore addSubview:imageViewIgnore];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_icon release];
    [_name release];
    [_time release];
    [_remark release];
    [_content release];
    [_unfinished release];
    [_finished release];
    [_ignore release];
    [super dealloc];
}
@end
