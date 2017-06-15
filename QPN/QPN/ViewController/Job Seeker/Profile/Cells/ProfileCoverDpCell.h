//
//  ProfileCoverDpCell.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileCoverDpCellDelegate <NSObject>

- (void) onAboutBtn:(id) sender;
- (void) onMyJobBtn:(id) sender;
- (void) onInboxBtn:(id) sender;
- (void) onMenuBtn:(id) sender;
- (void) onChangeDpBtn:(id) sender;
- (void) onChangeCoverBtn:(id) sender;

- (void) onObjectiveClick:(id) sender;

@end

@interface ProfileCoverDpCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *dpCoverContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dpCoverContainerHeight;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageHeight;
@property (strong, nonatomic) IBOutlet UILabel *star;

@property (weak, nonatomic) IBOutlet UIImageView *dpimage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dpHeight;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UILabel *careerObjectiveLbl;


@property (weak, nonatomic) IBOutlet UIButton *addpostBtn;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;
@property (weak, nonatomic) IBOutlet UIButton *recentJobBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (strong, nonatomic) IBOutlet UILabel *createPost;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (strong, nonatomic) IBOutlet UILabel *moreLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLabel;

@property(nonatomic,assign) id<ProfileCoverDpCellDelegate> profileDelegate;

- (void) populateCell;

@end
