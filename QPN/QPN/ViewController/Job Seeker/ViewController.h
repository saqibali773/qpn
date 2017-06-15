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

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign) int selectedTopTagIndex;


@end

