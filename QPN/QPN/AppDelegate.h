//
//  AppDelegate.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) UINavigationController * navController;
@property (strong, nonatomic) MFSideMenuContainerViewController *rootContainer;

@end

