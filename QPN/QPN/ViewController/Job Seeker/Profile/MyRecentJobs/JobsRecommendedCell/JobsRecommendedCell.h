//
//  JobsRecommendedCell.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"

@interface JobsRecommendedCell : UITableViewCell

- (void)configureCell:(Job *)job;
@end
