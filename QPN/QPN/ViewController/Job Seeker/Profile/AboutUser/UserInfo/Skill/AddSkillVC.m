//
//  AddSkillVC.m
//  QPN
//
//  Created by Muhammad Usman on 21/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "AddSkillVC.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"


@interface AddSkillVC ()
@property(nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation AddSkillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
//    self.saveBtn.layer.borderWidth = 2.0;
//    
//    self.saveBtn.layer.borderColor = [UIColor colorWithRed:157.0/255.0 green:69.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    self.saveBtn.layer.cornerRadius = 8.0;
    self.saveBtn.clipsToBounds = YES;
    
    if (self.isEditingMode && _skillObj)
    {
        self.titleTF.text = _skillObj.title;
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
- (IBAction)addEduPressed:(UIButton *)sender {
    
    if (self.titleTF.text.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Title Missig"];
    }
    else {
        NSDictionary *parameters = @{ @"skill": @{@"title":self.titleTF.text} };

        if (self.isEditingMode)
        {
            [SHARED_MANAGER showWorkingSpinner:self.view text:@"updating..."];
            [AUTH_MAN updateSkills:parameters catagoryId:_skillObj.skillId parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
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
            [AUTH_MAN addSkills:parameters parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
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
