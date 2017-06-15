//
//  HomeVC.m
//  Myfilix
//
//  Created by Muhammad Usman on 03/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "HomeVC.h"
#import "AppDelegate.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)menuBtnClicked:(UIButton *)sender {
    
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootContainer toggleLeftSideMenuCompletion:nil];
}

@end
