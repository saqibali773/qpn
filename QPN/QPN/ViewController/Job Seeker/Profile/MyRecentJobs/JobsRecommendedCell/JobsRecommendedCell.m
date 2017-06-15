//
//  JobsRecommendedCell.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "JobsRecommendedCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "QPNAuthorizationManager+Jobs.h"

@interface JobsRecommendedCell () {
    
}
@property (strong, nonatomic) IBOutlet UIImageView *personImage;
@property (strong, nonatomic) IBOutlet UILabel *personName;
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *lastDate;
@property (strong, nonatomic) IBOutlet UIButton *flag;
@property (nonatomic,strong) Job *selectedJob;


@end

@implementation JobsRecommendedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark Public Methods
- (void)configureCell:(Job *)job; {
    self.selectedJob = job;
    [self.personImage sd_setImageWithURL:[NSURL URLWithString:job.userAvatar]
                       placeholderImage:[UIImage imageNamed:@"boy"]
                              completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  }];
    self.personName.text = [NSString stringWithFormat:@"%@",job.userName];
    self.jobTitle.text = [NSString stringWithFormat:@"Title :%@",job.title];
    self.companyName.text = [NSString stringWithFormat:@"Company :%@",job.company_name];
    self.companyName.text = [NSString stringWithFormat:@"Company :%@",job.company_name];
    if(job.lastDate.length != 0) {
        self.lastDate.text = [NSString stringWithFormat:@"Last Date :%@",job.lastDate];
    } else {
        self.lastDate.text = @"";
    }
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
