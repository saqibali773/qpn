//
//  RecommendedJobDetailVC.h
//  QPN
//
//  Created by Muhammad Usman on 12/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"
@interface RecommendedJobDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *navTitle;

@property (nonatomic,strong)Job *currentJob;

@end
