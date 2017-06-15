//
//  OtherProfileCoverDpCell.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPNUser.h"

@protocol OtherProfileCoverDpCellDelegate <NSObject>

- (void)onAboutBtn:(id) sender;
- (void)onFollowBtn:(id) sender;


@end

@interface OtherProfileCoverDpCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *dpCoverContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dpCoverContainerHeight;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageHeight;
@property (strong, nonatomic) IBOutlet UILabel *star;
@property (weak, nonatomic) IBOutlet UIImageView *dpimage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dpHeight;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (nonatomic,strong) QPNUser *otherUser;

@property (strong, nonatomic) IBOutlet UIButton *aboutButton;
@property (strong, nonatomic) IBOutlet UIButton *followButton;


@property(nonatomic,assign) id<OtherProfileCoverDpCellDelegate> profileDelegate;

- (void)populateCell:(QPNUser *)user;

@end
