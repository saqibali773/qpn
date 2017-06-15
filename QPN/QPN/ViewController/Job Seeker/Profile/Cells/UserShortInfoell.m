//
//  UserShortInfoell.m
//  QPN
//
//  Created by Muhammad Usman on 03/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "UserShortInfoell.h"
#import "QPNSharedData.h"
@implementation UserShortInfoell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)populateCellWithUserInfo {

    self.email.text = SHARED_MANAGER.qpnUser.email;
    self.dob.text = SHARED_MANAGER.qpnUser.dob;
    if ([SHARED_MANAGER.qpnUser.gender isEqualToString:@"1"]){
        self.gender.text = @"Male";
    }else {
        self.gender.text = @"Female";
    }
    self.number.text = SHARED_MANAGER.qpnUser.telephone;
    self.nationality.text = SHARED_MANAGER.qpnUser.nationality_name;
    self.living.text = [NSString stringWithFormat:@"%@,%@",SHARED_MANAGER.qpnUser.city,SHARED_MANAGER.qpnUser.country_name];
}

@end
