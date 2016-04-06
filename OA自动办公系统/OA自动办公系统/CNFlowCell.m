//
//  CNFlowCell.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/17.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNFlowCell.h"
#import "CNFlowInfo.h"


@interface CNFlowCell ()
@property (retain, nonatomic) IBOutlet UILabel *flowTime;
@property (retain, nonatomic) IBOutlet UILabel *flowAddress;

@end

@implementation CNFlowCell

+ (instancetype)loadCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID";
    
    CNFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CNFlowCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

#pragma mark ------ 重写setting方法
- (void)setMoedl:(CNFlowInfo *)moedl{
    _moedl = moedl;
    
    //创建时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    self.flowTime.text = [NSString stringWithFormat:@"%@时间 : %@",moedl.daotui,moedl.time];
    self.flowAddress.text = moedl.address;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_flowTime release];
    [_flowAddress release];
    [super dealloc];
}
@end
