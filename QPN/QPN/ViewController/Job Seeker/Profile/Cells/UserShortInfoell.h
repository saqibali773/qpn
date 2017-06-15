//
//  UserShortInfoell.h
//  QPN
//
//  Created by Muhammad Usman on 03/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserShortInfoell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *dob;
@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *nationality;
@property (strong, nonatomic) IBOutlet UILabel *living;

- (void)populateCellWithUserInfo;
@end
