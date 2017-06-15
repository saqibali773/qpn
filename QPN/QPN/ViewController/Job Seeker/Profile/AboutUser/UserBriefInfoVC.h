//
//  UserBriefInfoVC.h
//  QPN
//
//  Created by Muhammad Usman on 12/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserBriefInfoVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *navTitle;

@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) NSString *gender;
@property (weak, nonatomic) IBOutlet UILabel *phonrNum;
@property (weak, nonatomic) IBOutlet UILabel *nationality;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UIImageView *dpimage;

@property (weak, nonatomic) IBOutlet UITextView *carrerObjective;

@property (strong, nonatomic) IBOutlet UIView *datePicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePick;
@property (strong, nonatomic) IBOutlet UILabel *industry;
@property (strong, nonatomic) IBOutlet UILabel *insitituteIndustryLabel;


@property (weak, nonatomic) IBOutlet UITableView *briefInfoTableView;




@end
