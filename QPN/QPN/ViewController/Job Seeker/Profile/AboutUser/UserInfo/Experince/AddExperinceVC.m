//
//  AddExperinceVC.m
//  QPN
//
//  Created by Muhammad Usman on 21/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "AddExperinceVC.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"

@interface AddExperinceVC ()
@property(nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation AddExperinceVC

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
    
    if (self.isEditingMode && _expObj)
    {
        self.CompanyName.text = _expObj.company_name;
        self.descp.text = _expObj.descp;
        self.jobTitle.text = _expObj.job_title;
        self.startDate.text = _expObj.start_date;
    
        if (_expObj.end_date ==(id)[NSNull null] || _expObj.end_date.length == 0 ) {
            self.checkBtn.selected = YES;
        }
        else
        {
            self.endDate.text = _expObj.end_date;
        }
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
        self.transparentLayer.hidden =  NO;
        self.datePickerView.hidden = NO;
    }
    else if (sender.tag == 1) {
        self.isStartDate = false;
        
        if (!self.checkBtn.isSelected) {
            self.transparentLayer.hidden =  NO;
            self.datePickerView.hidden = NO;
        }
    }
    
    
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
    
    if (self.isStartDate) {
        self.startDate.text = selectedDate;
    }
    else
    {
       self.endDate.text = selectedDate;
    }
    
    NSLog(@"%@",selectedDate);
    
}
- (IBAction)checkBtnPressed:(UIButton *)sender {
    
    if (self.checkBtn.isSelected == YES) {
        self.checkBtn.selected = NO;
    }
    else
    {
        self.checkBtn.selected = YES;
        self.endDate.text = @"";
    }
}


- (IBAction)addEduPressed:(UIButton *)sender {
    
    if (self.CompanyName.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Company Name Missig"];
    }
    else if (self.descp.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Description Missig"];
    }
    else if (self.jobTitle.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Job Title Missig"];
    }
    else if (self.startDate.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Start Date Missig"];
    }
    else if (self.endDate.text.length == 0 && !self.checkBtn.isSelected)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"End Date Missig"];
    }
    else {
        
        if (!self.checkBtn.isSelected)
        {
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            [f setDateFormat:@"yyyy-MM-dd"];
            NSDate *startDate = [f dateFromString:self.startDate.text];
            NSDate *endDate = [f dateFromString:self.endDate.text];
            if ([endDate compare:startDate] == NSOrderedAscending){
                
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:@"Start date should be less than to End date"];
                return;
            }
            
        }

        NSDictionary *parameters = @{ @"experience": @{@"company_name":self.CompanyName.text,@"description":self.descp.text, @"job_title":self.jobTitle.text, @"start_date":self.startDate.text, @"end_date":self.endDate.text, @"images": @""} };
        
        if (self.isEditingMode)
        {
            [SHARED_MANAGER showWorkingSpinner:self.view text:@"updating..."];
            [AUTH_MAN updateExperiences:parameters catagoryId:_expObj.experinceId parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
                [SHARED_MANAGER hideWorkingSpinner:self.view];
                
                if(response) {
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:@"Successfully Updated"];
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
            [AUTH_MAN addExperiences:parameters parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
                [SHARED_MANAGER hideWorkingSpinner:self.view];
                
                if(response) {
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:@"Successfully Updated"];
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
