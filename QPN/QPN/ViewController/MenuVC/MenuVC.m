//
//  MenuVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "MenuVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "PostCell.h"
#import "ProfileVC.h"
#import "SettingsVC.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager.h"
#import "MenuVCCell.h"
#import "UIView+Toast.h"
#import "OtherProfileVC.h"
@interface MenuVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSMutableArray*optionList;

@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.optionList = [NSMutableArray arrayWithObjects:@"Name",@"Settings",@"Logout", nil];
  
}

- (void)viewDidAppear:(BOOL)animated {
    if ([self.tabBarController.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.tabBarController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.optionList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * resuseID = @"MenuVCCell";
    MenuVCCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuVCCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    switch (indexPath.row) {
        case 0:{
             cell.title.text = SHARED_MANAGER.qpnUser.first_name;
            [cell.image sd_setImageWithURL:[NSURL URLWithString:SHARED_MANAGER.qpnUser.avatar_file_name] placeholderImage:nil completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
            break;
        }
        case 1:{
            cell.title.text = [self.optionList objectAtIndex:indexPath.row];
            cell.image.image = [UIImage imageNamed:[self.optionList objectAtIndex:indexPath.row]];
            break;
        }
        case 2:{
            cell.title.text = [self.optionList objectAtIndex:indexPath.row];
            cell.image.image = [UIImage imageNamed:[self.optionList objectAtIndex:indexPath.row]];
            break;
        }
            
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.row == 0) {
       ProfileVC * vc = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:[NSBundle mainBundle]];
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }

        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        
        SettingsVC * vc = [[SettingsVC alloc] initWithNibName:@"SettingsVC" bundle:[NSBundle mainBundle]];
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
        NSDictionary *parameters = @{ @"login": @{ @"email": SHARED_MANAGER.qpnUser.email, @"password": SHARED_MANAGER.qpnUser.password }};
        [AUTH_MAN logoutUser:parameters parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            if(!response) {
                
                NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
                NSDictionary * dict = [defs dictionaryRepresentation];
                for (id key in dict) {
                    [defs removeObjectForKey:key];
                }
                [defs synchronize];
                SHARED_MANAGER.QPNPostArray = nil;
                [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
            } else {
                if(error) {
                    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    if (data) {
                        NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                        [appdelegate.window makeToast:errorDic[@"errors"]];
                    }
                }
            }
        }];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMenuClick:(id)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootContainer toggleLeftSideMenuCompletion:nil];
}




@end
