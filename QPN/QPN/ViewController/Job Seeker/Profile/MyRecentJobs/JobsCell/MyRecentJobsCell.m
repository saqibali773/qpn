//
//  MyRecentJobsCell.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "MyRecentJobsCell.h"
#import "QPNAuthorizationManager+Jobs.h"


@interface MyRecentJobsCell () {
    
}
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (nonatomic,strong) Job *selectedJob;

@end

@implementation MyRecentJobsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark Public Methods
- (void)configureCell:(Job *)job {
    
    self.selectedJob = job;
    self.jobTitle.text = job.title;
    
    if(!self.selectedJob.isWishList) {
        [self.flag setBackgroundImage:[UIImage imageNamed:@"flag-off"] forState:UIControlStateNormal];
    } else {
        [self.flag setBackgroundImage:[UIImage imageNamed:@"flag-on"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)onFlagClick:(id)sender {
    
    NSNumber *flag = @0;
    if(!self.selectedJob.isWishList)  {
        flag = @1;
    }
    [AUTH_MAN onWishJob:@{@"job_id":[self.selectedJob.job_id stringValue],@"flag":flag} parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        if(response){
            if(!self.selectedJob.isWishList) {
                [self.flag setBackgroundImage:[UIImage imageNamed:@"flag-on"] forState:UIControlStateNormal];
            }else {
                [self.flag setBackgroundImage:[UIImage imageNamed:@"flag-off"] forState:UIControlStateNormal];
            }
            self.selectedJob.isWishList = !self.selectedJob.isWishList;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wishJobs" object:self];
        }
    }];
}


@end
