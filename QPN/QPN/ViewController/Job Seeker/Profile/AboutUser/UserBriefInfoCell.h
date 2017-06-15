//
//  UserBriefInfoCell.h
//  QPN
//
//  Created by Muhammad Usman on 25/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserBriefInfoCellDelegate <NSObject>
-(void) dobBtnPressed;
-(void) genderBtnPressed;
-(void) carrerObjBtnPressed;

@end

@interface UserBriefInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *phonrNum;
@property (weak, nonatomic) IBOutlet UILabel *nationality;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *industry;
@property (strong, nonatomic) IBOutlet UILabel *insitituteIndustryLabel;

@property (weak, nonatomic) IBOutlet UITextView *carrerObjective;

@property (nonatomic,assign) id <UserBriefInfoCellDelegate> delegate;

@end
