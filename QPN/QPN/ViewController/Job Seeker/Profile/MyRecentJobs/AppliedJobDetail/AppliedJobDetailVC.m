//
//  AppliedJobDetailVC.m
//  QPN
//
//  Created by Muhammad Usman on 12/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "AppliedJobDetailVC.h"
#import "QPNSharedData.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ObjectiveInfoVC.h"
#import "QPNAuthorizationManager+Jobs.h"

@interface AppliedJobDetailVC ()
@property (strong, nonatomic) IBOutlet UILabel *jobTitleNav;
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *Description;
@property (strong, nonatomic) IBOutlet UILabel *inDustry;
@property (strong, nonatomic) IBOutlet UILabel *skill;
@property (strong, nonatomic) IBOutlet UILabel *yearRequired;
@property (strong, nonatomic) IBOutlet UILabel *jobType;
@property (strong, nonatomic) IBOutlet UILabel *prefrence;
@property (strong, nonatomic) IBOutlet UILabel *lastDate;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UIButton *declineButton;

@end

@implementation AppliedJobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setJobInfos];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark Private Methods
- (void)setJobInfos {

    self.jobTitleNav.text = self.currentJob.title;
    self.jobTitle.text = self.currentJob.title;
    self.companyName.text = self.currentJob.company_name;
    self.Description.text = self.currentJob.jobDescription;
    self.inDustry.text = self.currentJob.industry;
    self.skill.text = self.currentJob.skills;
    self.yearRequired.text = [NSString stringWithFormat:@"%@ Years",self.currentJob.required_experience];
    self.jobType.text = self.currentJob.contract_type;
    self.prefrence.text = self.currentJob.region;
    self.lastDate.text = self.currentJob.lastDate;
    self.status.text = self.currentJob.status;

}


#pragma mark Custom Methods
- (IBAction)backBtnPressed:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onDeclineButton:(id)sender {
   
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Are you sure you want to decline this job?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [AUTH_MAN onDeclineJob: [self.currentJob.applicationJobId stringValue] parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AppliedJobs" object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendedJobs" object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wishJobs" object:self];

            [self.navigationController popViewControllerAnimated:YES];
        }];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}


@end
