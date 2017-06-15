//
//  SettingsVC.m
//  QPN
//
//  Created by Muhammad Usman on 11/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SettingsVC.h"
#import "QPNSharedData.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "QPNAuthorizationManager.h"
#import "QPNAuthorizationManager+UserInfo.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.saveBtnword.layer.cornerRadius = 8.0;
    self.saveBtnword.clipsToBounds = YES;
    
    if (SHARED_MANAGER.qpnUser)
    {
        self.navTitle.text = SHARED_MANAGER.qpnUser.first_name;
        [self.dpImage sd_setImageWithURL:[NSURL URLWithString:SHARED_MANAGER.qpnUser.avatar_file_name]
                        placeholderImage:[UIImage imageNamed:@"boy"]
                               completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   
                                   if(image){
                                       
                                   }else{
                                   }
                               }];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnPressed:(UIButton *)sender {
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)savePasswordBtnPressed:(UIButton *)sender {
    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self.view endEditing:YES];
    if (self.oldPassword.text.length == 0)
    {
        [appdelegate.window makeToast:@"old password Missig"];
        return;
    }
    else if (self.updatePassword.text.length == 0)
    {

        [appdelegate.window makeToast:@"new password Missig"];
        return;
    }
    else if (self.confirmPass.text.length == 0)
    {
        [appdelegate.window makeToast:@"confirm password Missig"];
        return;
    }
    else if (![self.confirmPass.text isEqualToString:self.updatePassword.text]){
            [appdelegate.window makeToast:@"Password is not same"];
            return;
    }
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:[NSString stringWithFormat:@"Are you sure you want to change password?"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [AUTH_MAN getResume:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            if(response[@"status"]) {
                [AUTH_MAN updatePassword:@{@"user":@{@"password":self.updatePassword.text,@"password_confirmation":self.confirmPass.text}} parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
                    
                    AUTH_MAN.authToken = response[@"auth_token"];
                    [AUTH_MAN saveAuthData];
                    SHARED_MANAGER.qpnUser = [[QPNUser alloc]initWithDictionary:response isShortInfo:false];
                    
                    [appdelegate.window makeToast:@"Password updated"];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
            
        }];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

    
}

@end
