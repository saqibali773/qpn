//
//  ObjectiveInfoVC.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "SharedPickerView.h"
#import "UIView+Toast.h"
#import "ObjectiveInfoVC.h"
#import "AppDelegate.h"
#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "QPNAWSS3Manager.h"
#import "QPNPost.h"
#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]


@interface ObjectiveInfoVC ()<UITextViewDelegate>
{
}

@end

@implementation ObjectiveInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self registerForKeyboardNotifications];
    self.postText.text = SHARED_MANAGER.qpnUser.careerObjective;
    [self.postText becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
   // [[IQKeyboardManager sharedManager] setEnable:YES];
}
#pragma mark -keyBoardDelegate
- (void)registerForKeyboardNotifications
{
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPostComment) name:@"MessageRecieved" object:nil
    //     ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
//    self.tableview.frame = CGRectMake(0.0, self.tableview.frame.origin.y,self.tableview.frame.size.width,TABLEVIEWHEIGHT);
}

#pragma mark textfieldDelegate
- (void)textViewDidChange:(UITextView *)textView
{
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        textView.text = [textView.text stringByAppendingString:@" "];
    }
    return YES;
}

#pragma -mark Custom Action
- (IBAction)onSaveClick:(id)sender {
    
    if(self.postText.text.length > 0) {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"Loading.."];
        NSDictionary *parameters = [NSDictionary dictionary];
        parameters = @{ @"user": @{ @"career_objective":self.postText.text,@"avatar":@"",@"cover_avatar":@""} };
        [AUTH_MAN updateUser:parameters parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            if(response) {
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:@"Your Objective has been update"];
                SHARED_MANAGER.qpnUser = [[QPNUser alloc]initWithDictionary:response isShortInfo:false];
                NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:@"reloadUserInfo" object:self userInfo:nil];
                double delayInSeconds = 1.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                if(error) {
                    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:errorDic[@"errors"]];
                }
            }
        }];
    }
}
- (IBAction)backBtnClicked:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

@end


