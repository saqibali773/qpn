//
//  UserBioDataVC.m
//  Myfilix
//
//  Created by Muhammad Usman on 22/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "UserBioDataVC.h"
#import "UserBioDataCell.h"
#import "QPNSharedData.h"

@interface UserBioDataVC ()

@end

@implementation UserBioDataVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (SHARED_MANAGER.qpnUser)
    {
        self.username.text = [NSString stringWithFormat:@"%@ %@ %@", SHARED_MANAGER.qpnUser.first_name, SHARED_MANAGER.qpnUser.middle_name, SHARED_MANAGER.qpnUser.last_name];
        self.age.text = [NSString stringWithFormat:@"DOB:%@",SHARED_MANAGER.qpnUser.dob];
        self.address.text = SHARED_MANAGER.qpnUser.city;
        self.email.text = SHARED_MANAGER.qpnUser.email;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnClicked:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * resuseID = @"BioDataCell";
    UserBioDataCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserBioDataCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    switch (indexPath.row)
    {
        case 0:
            cell.title.text = @"PROFESSIONAL SUMMARY";
            cell.descp.text = @"I think it's important to always keep professional and surround yourself with good people";
            break;
        case 1:
            cell.title.text = @"EDUCATION";
            cell.descp.text = @"The goal of education is not to increase the amount of knowledge but to create the possibilities.";
            
            break;
        
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
