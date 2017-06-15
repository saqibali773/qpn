//
//  AddEducationVC.m
//  QPN
//
//  Created by Muhammad Usman on 21/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "AddEducationVC.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"



@interface AddEducationVC ()
@property(nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation AddEducationVC

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
    
    
    if (self.isEditMode && _eduObj)
    {
    
         self.institute.text = _eduObj.institute;
        self.degreeTitle.text = _eduObj.degree_title;
        self.startDate.text = _eduObj.start_date;
        if (_eduObj.end_date ==(id)[NSNull null] || _eduObj.end_date.length == 0 ) {
            self.checkBtn.selected = YES;
        }
        else
        {
            self.endDate.text = _eduObj.end_date;
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
- (IBAction)currentlyStudying:(UIButton *)sender {
    
    if (self.checkBtn.isSelected)
    {
        self.checkBtn.selected = NO;

    }
    else
    {
        self.checkBtn.selected = YES;
        if (self.checkBtn.selected)
        {
            self.endDate.text = @"";
        }
    }
}
- (IBAction)addEduPressed:(UIButton *)sender {
    
    if (self.institute.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Institute Missig"];
    }
    else if (self.degreeTitle.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"degree Title Missig"];
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
        NSDictionary *parameters = @{ @"education": @{@"institute":self.institute.text, @"degree_title":self.degreeTitle.text, @"start_date":self.startDate.text, @"end_date":self.endDate.text, @"images": @""} };

   
        if (self.isEditMode)
        {
             [SHARED_MANAGER showWorkingSpinner:self.view text:@"updating..."];
            [AUTH_MAN updateEducations:parameters catagoryId:_eduObj.educationId parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
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
        else{
             [SHARED_MANAGER showWorkingSpinner:self.view text:@"adding..."];
            [AUTH_MAN addEducations:parameters parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
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
