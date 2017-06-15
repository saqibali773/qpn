//
//  UserBriefInfoVC.m
//  QPN
//
//  Created by Muhammad Usman on 12/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "UserBriefInfoVC.h"
#import "QPNSharedData.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ObjectiveInfoVC.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"
#import "UserBriefInfoCell.h"
#import "UserBriefInfoDpCell.h"

@interface UserBriefInfoVC ()<UITableViewDelegate,UITableViewDataSource,UserBriefInfoCellDelegate>

@end

@implementation UserBriefInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (SHARED_MANAGER.qpnUser)
    {
        self.navTitle.text = SHARED_MANAGER.qpnUser.first_name;
    }
}
- (void)viewDidAppear:(BOOL)animated {
    if (SHARED_MANAGER.qpnUser)
    {
        self.carrerObjective.text = SHARED_MANAGER.qpnUser.careerObjective;
    }
    [self.briefInfoTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Custom Methods
- (IBAction)backBtnPressed:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) dobBtnPressed
{
     self.datePicker.hidden = NO;
}
-(void) genderBtnPressed
{
    {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Change Gender" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Male" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.gender = @"Male";
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(UpdateGender) userInfo: nil repeats: NO];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Female" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.gender = @"Female";
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(UpdateGender) userInfo: nil repeats: NO];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        [self presentViewController:actionSheet animated:YES completion:nil];
        
        
    }
}
-(void) carrerObjBtnPressed;
{
    ObjectiveInfoVC *vc = [[ObjectiveInfoVC alloc] initWithNibName:@"ObjectiveInfoVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)UpdateGender {
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Loading.."];
    NSDictionary *parameters = [NSDictionary dictionary];
    NSString *gender = @"0";
    if([self.gender isEqualToString:@"Male"]) {
        gender = @"1";
    }
    
    parameters = @{ @"user": @{ @"gender":gender}};
    [AUTH_MAN updateUser:parameters parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"User has been update"];
            SHARED_MANAGER.qpnUser = [[QPNUser alloc]initWithDictionary:response isShortInfo:false];
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"reloadUserInfo" object:self userInfo:nil];
            [self.briefInfoTableView reloadData];
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

#pragma mark- Date Picker
- (IBAction)nextBtnDatePicker:(UIButton *)sender
{
    self.datePicker.hidden = YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * selectedDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: self.datePick.date]];
    self.dob.text = selectedDate;
    
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Loading.."];
    NSDictionary *parameters = [NSDictionary dictionary];
    parameters = @{ @"user": @{ @"dob":selectedDate}};
    [AUTH_MAN updateUser:parameters parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"User has been update"];
            SHARED_MANAGER.qpnUser = [[QPNUser alloc]initWithDictionary:response isShortInfo:false];
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"reloadUserInfo" object:self userInfo:nil];
            [self.briefInfoTableView reloadData];
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
- (IBAction)cancleDatePicker:(UIButton *)sender {
    self.datePicker.hidden = YES;
}


#pragma TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 155;
            break;
        case 1:
            return 448;
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            NSString * resuseID = @"UserBriefInfoDpCell";
            UserBriefInfoDpCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserBriefInfoDpCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            if (SHARED_MANAGER.qpnUser){
            [cell.dpimage sd_setImageWithURL:[NSURL URLWithString:SHARED_MANAGER.qpnUser.avatar_file_name]
                            placeholderImage:[UIImage imageNamed:@"boy"]
                                   completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       
                                       if(image){
                                           
                                       }else{
                                       }
                                   }];
            }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
        case 1:
        {
            NSString * resuseID = @"UserBriefInfoCell";
            UserBriefInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserBriefInfoCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            if (SHARED_MANAGER.qpnUser)
            {
                cell.email.text = SHARED_MANAGER.qpnUser.email;
                cell.dob.text = SHARED_MANAGER.qpnUser.dob;
                if ([SHARED_MANAGER.qpnUser.gender isEqualToString:@"1"]){
                    cell.gender.text = @"Male";
                }else {
                    cell.gender.text = @"Female";
                }
                cell.phonrNum.text = SHARED_MANAGER.qpnUser.telephone;
                cell.nationality.text = SHARED_MANAGER.qpnUser.nationality_name;
                cell.location.text = [NSString stringWithFormat:@"%@,%@",SHARED_MANAGER.qpnUser.city,SHARED_MANAGER.qpnUser.country_name];
                if([SHARED_MANAGER.qpnUser.role isEqualToString:@"student"]) {
                    cell.industry.text = SHARED_MANAGER.qpnUser.institute_name;
                    cell.insitituteIndustryLabel.text = @"Institute";
                } else {
                    cell.industry.text = SHARED_MANAGER.qpnUser.industry_name;
                    cell.insitituteIndustryLabel.text = @"Industry";
                }
                if (SHARED_MANAGER.qpnUser.careerObjective.length == 0)
                {
                    cell.carrerObjective.text = @"Please Enter Carrer Objective";
                }
                else{
                    cell.carrerObjective.text = SHARED_MANAGER.qpnUser.careerObjective;
                }
            }
            cell.delegate = self;
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
