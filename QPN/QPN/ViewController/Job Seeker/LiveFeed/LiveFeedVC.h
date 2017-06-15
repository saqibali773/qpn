//
//  ViewController.h
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "JobSeekerCell.h"

@interface LiveFeedVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign) int selectedTopTagIndex;

@property (nonatomic,assign) int editdeletePostIndex;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

