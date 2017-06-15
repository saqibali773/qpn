//
//  ViewController.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "ViewController.h"
#import "VKVideoPlayerViewController.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"

@interface ViewController ()<UISearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    if(![self checkNetwork]){
    
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:NSLocalizedString(@"Network error", @"Network error")
                                      message:NSLocalizedString(@"No internet connection found, this application requires an internet connection to gather the data required.", @"Network error")
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
  
}

#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 163;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * resuseID = @"JobSeekerCell";
    JobSeekerCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JobSeekerCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(bool)checkNetwork{


    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if(internetStatus == NotReachable) {
        return NO;
    }else{
        return YES;
    }

}
- (IBAction)onMenuClick:(id)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootContainer toggleLeftSideMenuCompletion:nil];

    
}




@end
