//
//  SignInSignUpVC.m
//  Myfilix
//
//  Created by Muhammad Usman on 03/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "SignInSignUpVC.h"
#import "SignInVC.h"
#import "HomeVC.h"
#import "SignUpStepOne.h"
#import "QPNSharedData.h"
#import "UIView+Toast.h"

#import "AppDelegate.h"
#import "QPNAuthorizationManager.h"

#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]

@interface SignInSignUpVC ()

@end

@implementation SignInSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(showVarifCodePopUp:) name:@"showVarifCodePopUp" object:nil];
    
//    self.signInBtn.layer.borderWidth = 2.0;
    
//    self.signInBtn.layer.borderColor = [UIColor colorWithRed:157.0/255.0 green:69.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
//    self.signInBtn.layer.borderWidth = 2.0;
    
    self.signInBtn.layer.cornerRadius = 8.0;
    self.signInBtn.clipsToBounds = YES;
    
//    self.signUpBtn.layer.borderColor = [UIColor colorWithRed:157.0/255.0 green:69.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
//    self.signUpBtn.layer.borderWidth = 2.0;
    
    self.signUpBtn.layer.cornerRadius = 8.0;
    self.signUpBtn.clipsToBounds = YES;
    
//    self.guestBtn.layer.borderColor = [UIColor colorWithRed:136.0/255.0 green:134.0/255.0 blue:135.0/255.0 alpha:1.0].CGColor;
    
//    self.guestBtn.layer.borderWidth = 2.0;
    
    self.guestBtn.layer.cornerRadius = 8.0;
    self.guestBtn.clipsToBounds = YES;
    
    self.transparentLayer.hidden = YES;
    self.signUpOptionView.hidden = YES;
    self.varifCodePopup.hidden = YES;
    
    UITapGestureRecognizer *layerGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(removeLayer:)];
    [self.view addGestureRecognizer:layerGesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}



#pragma mark - Custom Action Methods
- (IBAction)signInBtnClicked:(UIButton *)sender {
   
    SignInVC * vc;
    vc = [[SignInVC alloc] initWithNibName:@"SignInVC" bundle:[NSBundle mainBundle]];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)signUpBtnClicked:(UIButton *)sender {
    
    [self signUpASMember:nil];
}
- (IBAction)signUpASMember:(UIButton *)sender {
    SignUpStepOne * vc;
    vc = [[SignUpStepOne alloc] initWithNibName:@"SignUpStepOne" bundle:[NSBundle mainBundle]];
    vc.asPartner = false;
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    self.transparentLayer.hidden = YES;
    self.signUpOptionView.hidden = YES;
}
// This method will be removed in future
- (IBAction)signUpAsPartner:(UIButton *)sender {
    SignUpStepOne * vc;
    vc = [[SignUpStepOne alloc] initWithNibName:@"SignUpStepOne" bundle:[NSBundle mainBundle]];
    vc.asPartner = true;
    SHARED_MANAGER.signUpPayload.user_role = @1;
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    self.transparentLayer.hidden = YES;
    self.signUpOptionView.hidden = YES;
}
- (IBAction)sendBtnPressed:(UIButton *)sender {
    if (!SHARED_MANAGER.hasInet)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Please check your internet connection"];
        return;
    }
    if (self.codeTextField.text.length> 0)
    {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"Sending Code.."];
        NSDictionary *parameters = @{ @"user": @{ @"code": self.codeTextField.text } };
        [AUTH_MAN smsCodeApproval:parameters parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            self.transparentLayer.hidden = YES;
            self.varifCodePopup.hidden = YES;
            if(response) {
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:@"Your account have been sms approved"];
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
    else
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Enter Code"];
    }
    
    
}
- (IBAction)GuestBtnClicked:(UIButton *)sender {
    
    [self.view endEditing:YES];
    [self showVarifCodePopUp:nil];
}
#pragma mark - Private Methods
- (void)removeLayer:(UITapGestureRecognizer *)recognizer {
    self.transparentLayer.hidden = YES;
    self.varifCodePopup.hidden = YES;
    self.signUpOptionView.hidden = YES;
}
- (void)showVarifCodePopUp:(NSNotification*)notification{
    
    //self.transparentLayer.hidden = NO;
    //self.varifCodePopup.hidden = NO;
}

#pragma mark - Public Methods


@end
