//
//  ViewController.m
//  TestTextField
//
//  Created by AIogle on 16/1/17.
//  Copyright © 2016年 AIogle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 300, 40)];
    textField.backgroundColor = [UIColor redColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"获取" forState:UIControlStateNormal];
    button.frame = CGRectMake(300 - 40, 0, 40, 40);
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
   // [textField addSubview:button];
    
    textField.rightView = button;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    [self.view addSubview:textField];
}

- (void)buttonClick{
    NSLog(@"asdfas");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%@",string);
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
