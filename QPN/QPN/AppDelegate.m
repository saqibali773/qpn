//
//  AppDelegate.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "SideDrawerVC.h"
#import "SplashScreen.h"
#import "ServerEngine.h"
#import "GTAPIConstant.h"
#import "QPNAuthorizationManager.h"
#import "AWSCore.h"
#import "GTConstants.h"
#import "QPNSharedData.h"
#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]

@interface AppDelegate ()

@property (nonatomic,weak)Reachability*reachability;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self amazonSetting];
    [ServerEngine setServerBaseURL:BASE_URL];
    AUTH_MAN;
    SplashScreen * splashVC;
    splashVC = [[SplashScreen alloc] initWithNibName:@"SplashScreen" bundle:[NSBundle mainBundle]];
    
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:splashVC];
    
    self.navController.navigationBar.translucent = YES;
    self.navController.navigationBar.hidden = YES;
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];

    
        
    //SideDrawerVC * sideMenu = [[SideDrawerVC alloc] initWithNibName:@"SideDrawerVC" bundle:[NSBundle mainBundle]];
    //sideMenu.view.frame = [UIScreen mainScreen].bounds;
    
    //self.rootContainer = [MFSideMenuContainerViewController containerWithCenterViewController:self.navController leftMenuViewController:sideMenu rightMenuViewController:nil];
    //self.rootContainer.panMode = MFSideMenuPanModeNone;
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.window.rootViewController =  self.navController;
    [self.window makeKeyAndVisible];
    

    [self setUpRechability];
    
    
    return YES;
}

-(void)amazonSetting{
    //AWS
    AWSStaticCredentialsProvider *credentialsProvider = [[AWSStaticCredentialsProvider alloc] initWithAccessKey:AWSAcessKey secretKey:AWSSecretKey];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSWest2
                                                                         credentialsProvider:credentialsProvider];
    
    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = configuration;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)setUpRechability
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if          (remoteHostStatus == NotReachable)      {NSLog(@"no");      SHARED_MANAGER.hasInet-=NO;   }
    else if     (remoteHostStatus == ReachableViaWiFi)  {NSLog(@"wifi");    SHARED_MANAGER.hasInet-=YES;  }
    else if     (remoteHostStatus == ReachableViaWWAN)  {NSLog(@"cell");    SHARED_MANAGER.hasInet-=YES;  }
    
}

- (void) handleNetworkChange:(NSNotification *)notice
{
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if          (remoteHostStatus == NotReachable)      {NSLog(@"no");      SHARED_MANAGER.hasInet-=NO;   }
    else if     (remoteHostStatus == ReachableViaWiFi)  {NSLog(@"wifi");    SHARED_MANAGER.hasInet-=YES;  }
    else if     (remoteHostStatus == ReachableViaWWAN)  {NSLog(@"cell");    SHARED_MANAGER.hasInet-=YES;  }
    
}



@end
