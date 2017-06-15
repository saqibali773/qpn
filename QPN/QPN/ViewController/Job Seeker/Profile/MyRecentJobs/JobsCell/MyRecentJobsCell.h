//
//  MyRecentJobsCell.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"
@interface MyRecentJobsCell : UITableViewCell

- (void)configureCell:(Job *)job;
@property (strong, nonatomic) IBOutlet UIButton *flag;

@end
