//
//  SearchUserCell.h
//  QPN
//
//  Created by Muhammad Usman on 17/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QPNUser.h"

@interface SearchUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userDp;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *srats;
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;

@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (strong,nonatomic) QPNUser * userObj;


- (void) populateData;


@end
