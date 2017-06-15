//
//  AboutOtherUserVC.h
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "GTConstants.h"
#import "QPNUser.h"
@interface AboutOtherUserVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign) int selectedTopTagIndex;

@property (nonatomic) int userAlldataApiCount;

@property (strong, nonatomic) NSMutableArray* educationArray;
@property (strong, nonatomic) NSMutableArray* experianceArray;
@property (strong, nonatomic) NSMutableArray* achievementArray;
@property (strong, nonatomic) NSMutableArray* skillArray;

@property (strong, nonatomic) QPNUser* otherUser;
@property (nonatomic) UserDataCatagory catagory;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;

@end

