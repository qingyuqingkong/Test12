//
//  CNLoginView.h
//  OA自动办公系统
//
//  Created by AIogle on 15/12/19.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNUserInfo;
@protocol CNLoginViewDeleget <NSObject>

- (void)userNameAndPasswordDidSuccess:(CNUserInfo *)userInfo;

@end

typedef NS_ENUM(NSInteger, LogingAnimationType) {
    LogingAnimationType_NONE,
    LogingAnimationType_USER,
    LogingAnimationType_PWD
};

@interface CNLoginView : UIView

@property (weak, nonatomic) IBOutlet UITextField *UserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;

@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UIImageView *left_hidden;
@property (weak, nonatomic) IBOutlet UIImageView *right_hidden;

@property (weak, nonatomic) IBOutlet UIImageView *left_look;
@property (weak, nonatomic) IBOutlet UIImageView *right_look;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@property (nonatomic, assign) id<CNLoginViewDeleget> deleget;

@end
