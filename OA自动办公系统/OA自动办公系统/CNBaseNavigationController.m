//
//  CNBaseViewController.m
//  OA自动办公系统
//
//  Created by AIogle on 15/12/10.
//  Copyright © 2015年 AIogle. All rights reserved.
//

#import "CNBaseNavigationController.h"

@interface CNBaseNavigationController ()

@end

@implementation CNBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"statusNavigation"]]];
    UIImage *image = [UIImage imageNamed:@"statusNavigation"];
    CGSize size = CGSizeMake(375, 64);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationBar setBackgroundImage:scaledImage forBarMetrics:UIBarMetricsDefault];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
