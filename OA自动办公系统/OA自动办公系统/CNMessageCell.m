//
//  CNMessageCell.m
//  QQ聊天
//
//  Created by AIogle on 15/11/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNMessageCell.h"
#import "CNMessage.h"
#import "CNMessageFrame.h"
@interface CNMessageCell ()

@property (nonatomic, weak) UILabel *lblTime;
@property (nonatomic, weak) UIImageView *imgViewIcon;
@property (nonatomic, weak) UIButton *btnText;
@end

@implementation CNMessageCell

#pragma mark - 重新initWithStyle方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建子控件
        
        //显示时间的label
        UILabel *lblTime = [[UILabel alloc] init];
        //设置文字大小
        lblTime.font = [UIFont systemFontOfSize:12];
        //设置文字居中
        lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        self.lblTime = lblTime;
    
        //显示头像的UIImageView
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
        //显示正文按钮
        UIButton *btnText = [[UIButton alloc] init];
        //设置正文的字体大小
        btnText.titleLabel.font = textFont;
        //设置按钮的文字颜色
        //[btnText setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //设置按钮中的Label可以换行
        btnText.titleLabel.numberOfLines = 0;
        
        //设置按钮的内边距
        btnText.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        [self.contentView addSubview:btnText];
        self.btnText = btnText;
        
    }
    //设置单元格的背景颜色
    self.backgroundColor = [UIColor clearColor];
    return self;
}
#pragma mark - 重新frame模型的set方法
- (void)setMessageFrame:(CNMessageFrame *)messageFrame{
    _messageFrame = messageFrame;
    
    //获取数据模型
    CNMessage *message = messageFrame.message;
    
    //分别设置每个子控件的数据和frame
    //设置“时间Label”的数据和frame
    self.lblTime.text = message.time;
    if (message.hideTime) {
        self.lblTime.hidden = YES;
    }else{
        self.lblTime.frame = messageFrame.timeFrame;
    }
    
    //设置 头像
    //根据消息类型，判断应该使用那张图片
    NSString *iconImg = message.type == CNMessageTypeMe ? @"me" : @"other";
    self.imgViewIcon.image = [UIImage imageNamed:iconImg];
    self.imgViewIcon.frame = messageFrame.iconFrame;
    
    //设置正文
    [self.btnText setTitle:message.text forState:UIControlStateNormal];

    NSString *bgNorBtnImg, *bgHightlightBtnImg;
    if (message.type == CNMessageTypeMe) {
        bgNorBtnImg = @"chat_send_nor";
        bgHightlightBtnImg = @"chat_send_press_pic";
        
        //设置消息的征文文字颜色为“白色"
        [self.btnText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        bgNorBtnImg = @"chat_recive_nor";
        bgHightlightBtnImg = @"chat_recive_press_pic";
        
        //设置消息的征文文字颜色为“黑色"
        [self.btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    //加载图片
    UIImage *imgNormal = [UIImage imageNamed:bgNorBtnImg];
    UIImage *imgHighlighted = [UIImage imageNamed:bgHightlightBtnImg];
    //用平铺的方式拉长图片
    imgNormal = [imgNormal stretchableImageWithLeftCapWidth:imgNormal.size.width * 0.5 topCapHeight:imgNormal.size.height * 0.5];
    imgHighlighted = [imgHighlighted stretchableImageWithLeftCapWidth:imgHighlighted.size.width * 0.5 topCapHeight:imgHighlighted.size.height * 0.5];
    //设置背景图
    [self.btnText setBackgroundImage:imgNormal forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:imgHighlighted forState:UIControlStateHighlighted];
    self.btnText.frame = messageFrame.textFrame;
}

#pragma mark - 创建类方法
+ (instancetype)messageCellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID = @"message_cell";
    CNMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CNMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
