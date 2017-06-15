//
//  SplashScreen.m
//  Monasbat
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//
//

#import "SplashScreen.h"
#import "AppDelegate.h"
#import "HomeVC.h"
#import "SignInSignUpVC.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "MyApplicationVC.h"
#import "LiveFeedVC.h"
#import "ProfileVC.h"
#import "MenuVC.h"
#import "CamerVC.h"
#import "NotificationVC.h"
#import "NotificationsOneVC.h"

#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]

@interface SplashScreen ()

@end

@implementation SplashScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;

}

- (void)viewDidAppear:(BOOL)animated {
    
    if (AUTH_MAN.authToken)
    {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"Waiting..."];
        [AUTH_MAN authenticateUser:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            if(response[@"succues"]) {
                [AUTH_MAN getUserInfo:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
                    [SHARED_MANAGER hideWorkingSpinner:self.view];
                    if([response[@"approved"] boolValue] && [response[@"sms_approved"] boolValue]) {
                        SHARED_MANAGER.qpnUser = [[QPNUser alloc]initWithDictionary:response isShortInfo:false];
                        [self pushMainViewController];
                    } else {
                        
                        [self theFirstVC];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"auth_token"];
                    }
                }];
            } else {
                
                [self theFirstVC];
            }
        }];
    }
    else
    {
        [self theFirstVC];
    }
    
}
- (void)viewDidDisappear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


- (void)isUserApproved {

    [AUTH_MAN isUserApproved:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        
    }];
}

- (void)authenticateUser {
    
}

- (void)apiCallCountry {
    
    [AUTH_MAN getCountry:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        NSLog(@"Response %@",response);
    }];
    
}

- (void)getUserInfo {
    
    [AUTH_MAN getUserInfo:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        NSLog(@"Response %@",response);
    }];
}

- (void)logoutUser {
    
    NSDictionary *parameters = @{ @"login": @{ @"email": @"saqibali774@gmail.com", @"password": @"123456abc" }};
    [AUTH_MAN getUserInfo:parameters parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        NSLog(@"Response %@",response);
    }];
}

- (void)theFirstVC {
    SignInSignUpVC * vc;
    vc = [[SignInSignUpVC alloc] initWithNibName:@"SignInSignUpVC" bundle:[NSBundle mainBundle]];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void) pushMainViewController {
    
    NotificationVC * vc1 = [[NotificationVC alloc] initWithNibName:@"NotificationVC" bundle:[NSBundle mainBundle]];
    vc1.selectedTopTagIndex = 1;
    
    CamerVC * vc2 = [[CamerVC alloc] initWithNibName:@"CamerVC" bundle:[NSBundle mainBundle]];
    vc2.selectedTopTagIndex = 2;
    
    LiveFeedVC * vc3 = [[LiveFeedVC alloc] initWithNibName:@"LiveFeedVC" bundle:[NSBundle mainBundle]];
    vc3.selectedTopTagIndex = 0;
    
    NotificationsOneVC * vc4 = [[NotificationsOneVC alloc] initWithNibName:@"NotificationsOneVC" bundle:[NSBundle mainBundle]];
    vc4.selectedTopTagIndex = 3;
    MenuVC *vc5 = [[MenuVC alloc] initWithNibName:@"MenuVC" bundle:[NSBundle mainBundle]];
    vc5.selectedTopTagIndex = 4;
    
    UINavigationController *tab1Nav = [[UINavigationController alloc] initWithRootViewController:vc1];
    tab1Nav.navigationBar.hidden = true;

    UINavigationController *tab2Nav = [[UINavigationController alloc] initWithRootViewController:vc2];
    tab2Nav.navigationBar.hidden = true;
    UINavigationController *tab3Nav = [[UINavigationController alloc] initWithRootViewController:vc3];
    tab3Nav.navigationBar.hidden = true;
    UINavigationController *tab4Nav = [[UINavigationController alloc] initWithRootViewController:vc4];
    tab4Nav.navigationBar.hidden = true;
    UINavigationController *tab5Nav = [[UINavigationController alloc] initWithRootViewController:vc5];
    tab5Nav.navigationBar.hidden = true;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateSelected];
    
    CGSize size = CGSizeMake(30, 30);
    CGPoint offset = CGPointMake(2, 2);
    
    UITabBarItem * item1 = [[UITabBarItem alloc] initWithTitle:@"Request" image:[[self imageWithImage:[UIImage imageNamed:@"friends"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[self imageWithImage:[UIImage imageNamed:@"friends"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.titlePositionAdjustment = UIOffsetMake(-1.0, 0.0);
    vc1.tabBarItem = item1;
    
    UITabBarItem * item2 = [[UITabBarItem alloc] initWithTitle:@"Camera" image:[[self imageWithImage:[UIImage imageNamed:@"photo-camera-1"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[self imageWithImage:[UIImage imageNamed:@"photo-camera-1"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.titlePositionAdjustment = UIOffsetMake(-1.0, 0.0);
    vc2.tabBarItem = item2;
    
    UITabBarItem * item3 = [[UITabBarItem alloc] initWithTitle:@"Live Feed" image:[[self imageWithImage:[UIImage imageNamed:@"main_menu_tables_icon_off"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[self imageWithImage:[UIImage imageNamed:@"main_menu_tables_icon_on"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.titlePositionAdjustment = UIOffsetMake(-1.0, 0.0);
    vc3.tabBarItem = item3;
    
    UITabBarItem * item4 = [[UITabBarItem alloc] initWithTitle:@"Notification" image:[[self imageWithImage:[UIImage imageNamed:@"globe"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[self imageWithImage:[UIImage imageNamed:@"globe"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.titlePositionAdjustment = UIOffsetMake(-1.0, 0.0);
    vc4.tabBarItem = item4;
  
    UITabBarItem * item5 = [[UITabBarItem alloc] initWithTitle:@"Menu" image:[[self imageWithImage:[UIImage imageNamed:@"menu"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[self imageWithImage:[UIImage imageNamed:@"menu"] scaledToSize:size andOffSet:offset] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.titlePositionAdjustment = UIOffsetMake(-1.0, 0.0);
    vc5.tabBarItem = item5;
    
    MainViewController* controller = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
    controller.tabBar.clipsToBounds = YES;
    //controller.tabBar.barTintColor = [UIColor colorWithRed:(43.0/255.0) green:(7.0/255.0) blue:(19.0/255.0) alpha:1.0];
    //controller.tabBar.barTintColor = [UIColor colorWithRed:(129.0/255.0) green:(5.0/255.0) blue:(65.0/255.0) alpha:1.0];
    controller.tabBar.barTintColor = [UIColor colorWithRed:(80.0/255.0) green:(0.0/255.0) blue:(44.0/255.0) alpha:1.0];
    [controller.tabBar setBackgroundColor:[UIColor blackColor]];
    controller.tabBar.translucent = YES;
    
   
    //tab1Nav,tab2Nav,tab4Nav
    [controller setViewControllers:@[tab3Nav,tab1Nav,tab4Nav,tab5Nav]];
    if(SHARED_MANAGER.qpnUser._notification_count_Request.integerValue > 0){
        [tab1Nav tabBarItem].badgeValue = [SHARED_MANAGER.qpnUser._notification_count_Request stringValue];
    }
    if(SHARED_MANAGER.qpnUser.notification_count_simple.integerValue > 0){
        [tab4Nav tabBarItem].badgeValue = [SHARED_MANAGER.qpnUser._notification_count_Request stringValue];
    }
    

    [self.navigationController pushViewController:controller animated:YES];
    [controller setSelectedIndex:0];
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize andOffSet:(CGPoint)offSet{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(offSet.x, offSet.y, newSize.width-offSet.x, newSize.height-offSet.y)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
