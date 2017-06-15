//
//  OtherProfileCoverDpCell.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "OtherProfileCoverDpCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "QPNAuthorizationManager+UserInfo.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"

@implementation OtherProfileCoverDpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) populateCell :(QPNUser *)user
{
    self.otherUser = user;
    
    if ([self.otherUser.following isEqualToString:@"Follow"] || [self.otherUser.following isEqualToString:@"Requested"]) {
        self.aboutButton.hidden = YES;
    } else if ([self.otherUser.following isEqualToString:@"Unfollow"]) {
        self.aboutButton.hidden = NO;
    }
    
    [self.followButton setTitle:self.otherUser.following forState:UIControlStateNormal];

    
    
    self.dpimage.layer.cornerRadius =2.0;
    self.dpimage.clipsToBounds = YES;
    self.dpimage.layer.borderColor = [UIColor colorWithRed:182.0/225.0 green:182.0/255.0 blue:182.0/255.0 alpha:1.0].CGColor;
    self.dpimage.layer.borderWidth = 1.0;

    
}
- (IBAction)aboutBtnPressed:(UIButton *)sender {
   
    [_profileDelegate onAboutBtn:sender];
    
}
- (IBAction)onFollowClick:(id)sender {
    NSNumber *flag = @0;
    if ([self.otherUser.following isEqualToString:@"Follow"]) {
        flag = @1;
    } else if ([self.otherUser.following isEqualToString:@"Unfollow"]) {
        flag = @0;
    } else {
        flag = @-1;
    }
    
    if([flag isEqualToNumber:@-1]) {
        
        return;
    }
    
    [AUTH_MAN followUnfollow:@{@"followed_id":self.otherUser.userId,@"flag":flag} parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
      
        if([response[@"status"] boolValue]) {
            self.otherUser.following = response[@"following"];
            [self.followButton setTitle:self.otherUser.following forState:UIControlStateNormal];
            if ([self.otherUser.following isEqualToString:@"Follow"]||[self.otherUser.following isEqualToString:@"Requested"]) {
                self.aboutButton.hidden = YES;
            } else if ([self.otherUser.following isEqualToString:@"Unfollow"]) {
                self.aboutButton.hidden = NO;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadUserInfo" object:nil];
            self.aboutButton.hidden = YES;
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Your request has been successfully completed."];

        }
    }];
    
}

@end
