//
//  AddAchievementVC.m
//  QPN
//
//  Created by Muhammad Usman on 21/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "AddAchievementVC.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"

@interface AddAchievementVC ()
@property(nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation AddAchievementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.transparentLayer.hidden = YES;
    self.datePickerView.hidden = YES;
    
//    self.saveBtn.layer.borderWidth = 2.0;
//    
//    self.saveBtn.layer.borderColor = [UIColor colorWithRed:157.0/255.0 green:69.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    self.saveBtn.layer.cornerRadius = 8.0;
    self.saveBtn.clipsToBounds = YES;
    
    if (self.isEditingMode && _achObj)
    {
        self.titleTF.text = _achObj.title;
        self.descp.text = _achObj.descp;
        self.startDate.text = _achObj.start_date;
    }
    
}
- (IBAction)bakBtnPressed:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)datePickeBtnPressed:(UIButton *)sender {
    
    if (sender.tag == 0) {
        self.isStartDate = true;
    }
    else if (sender.tag == 1) {
        self.isStartDate = false;
    }
    self.transparentLayer.hidden =  NO;
    self.datePickerView.hidden = NO;
}
- (IBAction)cancelDatePicker:(UIButton *)sender {
    self.transparentLayer.hidden =  YES;
    self.datePickerView.hidden = YES;
}
- (IBAction)doneDatePicker:(UIButton *)sender {
    
    [self.view endEditing:YES];
    self.transparentLayer.hidden =  YES;
    self.datePickerView.hidden = YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * selectedDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: self.datePicker.date]];
    
    self.startDate.text = selectedDate;
    
}
- (IBAction)addEduPressed:(UIButton *)sender {
    
    if (self.titleTF.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Title Missig"];
    }
    else if (self.descp.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Description Missig"];
    }
    else if (self.startDate.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Start Date Missig"];
    }
       else {
        NSDictionary *parameters = @{ @"achievement": @{@"title":self.titleTF.text, @"description":self.descp.text, @"start_date":self.startDate.text, @"images": @""} };
           if (self.isEditingMode)
           {
               [SHARED_MANAGER showWorkingSpinner:self.view text:@"updating..."];
               [AUTH_MAN updateAchievemnts:parameters catagoryId: _achObj.achievementId parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
                   [SHARED_MANAGER hideWorkingSpinner:self.view];
                   if(response) {
                       AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                       [appdelegate.window makeToast:@"Successfully updated"];
                       self.navigationController.navigationBarHidden = YES;
                       [self.navigationController popViewControllerAnimated:YES];
                       
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
           else
           {
                [SHARED_MANAGER showWorkingSpinner:self.view text:@"adding..."];
                [AUTH_MAN addAchievemnts:parameters parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
                    [SHARED_MANAGER hideWorkingSpinner:self.view];
                    if(response) {
    
                        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                        [appdelegate.window makeToast:@"Successfully Saved"];
                        self.navigationController.navigationBarHidden = YES;
                        [self.navigationController popViewControllerAnimated:YES];
                        
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
}

@end
