//
//  ProfileCoverDpCell.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "ProfileCoverDpCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProfileCoverDpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) populateCell
{ 
    self.dpimage.layer.cornerRadius =2.0;
    self.dpimage.clipsToBounds = YES;
    self.dpimage.layer.borderColor = [UIColor colorWithRed:182.0/225.0 green:182.0/255.0 blue:182.0/255.0 alpha:1.0].CGColor;
    self.dpimage.layer.borderWidth = 1.0;
    
    self.profileBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileBtn.layer.borderWidth = 1.0;
    
    self.addpostBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.addpostBtn.layer.borderWidth = 1.0;
    
    self.recentJobBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.recentJobBtn.layer.borderWidth = 1.0;
    
    self.moreBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.moreBtn.layer.borderWidth = 1.0;

    self.createPost.layer.borderColor = [UIColor whiteColor].CGColor;
    self.createPost.layer.borderWidth = 1.0;
    self.aboutLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.aboutLabel.layer.borderWidth = 1.0;
    self.moreLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.moreLabel.layer.borderWidth = 1.0;
    self.jobLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.jobLabel.layer.borderWidth = 1.0;
    
    self.menuView.layer.borderColor = [UIColor colorWithRed:(126/255.0) green:(126/255.0) blue:(138/255.0) alpha:1].CGColor;
    self.jobLabel.layer.borderWidth = 1.0;
    
}
- (IBAction)changeCover:(UIButton *)sender {
    if (self.profileDelegate && [self.profileDelegate respondsToSelector:@selector(onChangeCoverBtn:)])
    {
        [self.profileDelegate onChangeCoverBtn:sender];
    }

}

- (IBAction)changeDp:(UIButton *)sender {
    
    if (self.profileDelegate && [self.profileDelegate respondsToSelector:@selector(onChangeDpBtn:)])
    {
        [self.profileDelegate onChangeDpBtn:sender];
    }
}

- (IBAction)aboutBtnPressed:(UIButton *)sender {
    
    if (self.profileDelegate && [self.profileDelegate respondsToSelector:@selector(onAboutBtn:)])
    {
        [self.profileDelegate onAboutBtn:sender];
    }
}
- (IBAction)myJobsBtnPressed:(UIButton *)sender {
    if (self.profileDelegate && [self.profileDelegate respondsToSelector:@selector(onMyJobBtn:)])
    {
        [self.profileDelegate onMyJobBtn:sender];
    }
}
- (IBAction)inboxBtnPressed:(UIButton *)sender {
    if (self.profileDelegate && [self.profileDelegate respondsToSelector:@selector(onInboxBtn:)])
    {
        [self.profileDelegate onInboxBtn:sender];
    }
}
- (IBAction)menuBTnPressed:(UIButton *)sender {
    if (self.profileDelegate && [self.profileDelegate respondsToSelector:@selector(onMenuBtn:)])
    {
        [self.profileDelegate onMenuBtn:sender];
    }
}
- (IBAction)onLabelTouch:(id)sender {
    
    if (self.profileDelegate && [self.profileDelegate respondsToSelector:@selector(onObjectiveClick:)])
    {
        [self.profileDelegate onObjectiveClick:sender];
    }
}

@end
