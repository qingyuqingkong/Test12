//
//  CNLoginView.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/19.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNLoginView.h"
#import "UIImage+UIImage_Scale.h"
#import "CNUserInfo.h"

@interface CNLoginView () <UITextFieldDelegate>{
    UIImageView* imgLeftHand;
    UIImageView* imgRightHand;
    
    UIImageView* imgLeftHandGone;
    UIImageView* imgRightHandGone;
    
    LogingAnimationType AnimationType;
}

@property (nonatomic, strong) NSArray *userInfo;

@end


@implementation CNLoginView

#pragma mark --- 懒加载数据
- (NSArray *)userInfo{
    if (!_userInfo) {
        _userInfo = [CNUserInfo userInfosList];
    }
    return _userInfo;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CNLoginView" owner:self options:nil] lastObject];
        
        [self UISetting];
    }
    return self;
}

//login点击方法
- (IBAction)loginClick:(id)sender {
    NSString *username = self.UserNameTextField.text;
    NSString *password = self.PasswordTextField.text;
    
    for (CNUserInfo *model in self.userInfo) {
        if ([username isEqualToString:model.username] && [password isEqualToString:model.password]) {
            if ([self.deleget respondsToSelector:@selector(userNameAndPasswordDidSuccess:)]) {
                [self.deleget userNameAndPasswordDidSuccess:model];
            }
        } else {
            
        }
    }
    
}


-(void)UISetting{
    
    AnimationType = LogingAnimationType_NONE;
    
    UIColor* boColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:100];
    
    _UserNameTextField.layer.borderColor = boColor.CGColor;
    _UserNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _UserNameTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    [_UserNameTextField.leftView addSubview:imgUser];
    
    _PasswordTextField.layer.borderColor = boColor.CGColor;
    _PasswordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _PasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
    [_PasswordTextField.leftView addSubview:imgPwd];
    
    _loginView.layer.borderColor = boColor.CGColor;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:_PasswordTextField]) {
        AnimationType = LogingAnimationType_PWD;
        [self AnimationUserToPassword];
        
    }else{
        
        if (AnimationType == LogingAnimationType_NONE) {
            AnimationType = LogingAnimationType_USER;
            return;
        }
        AnimationType = LogingAnimationType_USER;
        [self AnimationPasswordToUser];
        
    }
    
}

#pragma mark textField方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark 移开手动画
-(void)AnimationPasswordToUser{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.left_look.frame = CGRectMake(self.left_look.frame.origin.x - 80, self.left_look.frame.origin.y, 40, 40);
        self.right_look.frame = CGRectMake(self.right_look.frame.origin.x + 40, self.right_look.frame.origin.y, 40, 40);
        
        self.right_hidden.frame = CGRectMake(self.right_hidden.frame.origin.x+55, self.right_hidden.frame.origin.y+40, 40, 66);
        self.left_hidden.frame = CGRectMake(self.left_hidden.frame.origin.x-60, self.left_hidden.frame.origin.y+40, 40, 66);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark 捂眼
-(void)AnimationUserToPassword{
    [UIView animateWithDuration:0.5f animations:^{
        
        self.left_look.frame = CGRectMake(self.left_look.frame.origin.x + 80, self.left_look.frame.origin.y, 0, 0);
        self.right_look.frame = CGRectMake(self.right_look.frame.origin.x - 40, self.right_look.frame.origin.y, 0, 0);
        
        self.right_hidden.frame = CGRectMake(self.right_hidden.frame.origin.x-55, self.right_hidden.frame.origin.y-40, 40, 66);
        self.left_hidden.frame = CGRectMake(self.left_hidden.frame.origin.x+60, self.left_hidden.frame.origin.y-40, 40, 66);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)EndEDitTap:(id)sender {
    if (AnimationType == LogingAnimationType_PWD) {
        [self AnimationPasswordToUser];
    }
    AnimationType = LogingAnimationType_NONE;
    [self endEditing:YES];
}
@end
