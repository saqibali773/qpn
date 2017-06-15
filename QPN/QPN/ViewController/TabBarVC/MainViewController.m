//
//  MainViewController.m
//  ModahNew
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "MainViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    UIImage*buttonImage = [UIImage imageNamed:@"main_menu_timeline_icon"];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 60, 63);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImage forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchDown];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    

}

-(void)centerButtonClick
{
    [self setSelectedIndex:2];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
   // [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark SideMenuHelper

@end
