//
//  OtherProfileVC.h
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "JobSeekerCell.h"
#import "GTConstants.h"
@interface OtherProfileVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *userTitle;
@property (strong, nonatomic) NSString *userId;

@property (nonatomic,assign) int selectedTopTagIndex;

@property (nonatomic) UserDataCatagory catagory;


@end

