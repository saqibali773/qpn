//
//  ProfileVC.h
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "JobSeekerCell.h"
#import "GTConstants.h"
@interface ProfileVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign) int selectedTopTagIndex;

@property (nonatomic) BOOL is_postOption;
@property (nonatomic) BOOL is_dpChanging;

@property (nonatomic) UserDataCatagory catagory;
@property (nonatomic,assign) int editdeletePostIndex;


@end

