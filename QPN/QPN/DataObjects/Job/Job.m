//
//  Job.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "Job.h"
#import "GTConstants.h"
#import "QPNSharedData.h"
@implementation Job

- (id)initWithDictionary:(NSDictionary*)userObject {
    
    if(self = [super init])
    {
        [self updateWithDictionary:userObject];
    }
    return self;
}
- (void)updateWithDictionary:(NSDictionary*)userObject {
    
    if(userObject[@"job"]) {
        
        self.job_id = userObject[@"job"][@"id"];
        self.title = userObject[@"job"][@"title"];
        self.jobDescription = userObject[@"job"][@"description"];
        self.industry = userObject[@"job"][@"industry"];
        if(![userObject[@"job"][@"required_experience"] isKindOfClass:[NSNull class]]) {
            self.required_experience = userObject[@"job"][@"required_experience"];
        }
        if(![userObject[@"job"][@"internship"]isKindOfClass:[NSNull class]]) {
            self.isInternShip = [userObject[@"job"][@"internship"] boolValue];
        }
        if(![userObject[@"job"][@"region"]isKindOfClass:[NSNull class]]) {
            self.region = userObject[@"job"][@"region"];
        }
        if(![userObject[@"job"][@"contract_type"]isKindOfClass:[NSNull class]]) {
            self.contract_type = userObject[@"job"][@"contract_type"];
        }
        
        if(![userObject[@"job"][@"location"]isKindOfClass:[NSNull class]]) {
            self.location = userObject[@"job"][@"location"];
        }
        if(![userObject[@"job"][@"company_name"]isKindOfClass:[NSNull class]]) {
            self.company_name = userObject[@"job"][@"company_name"];
        }
        if(![userObject[@"job"][@"skills"]isKindOfClass:[NSNull class]]) {
            self.skills = userObject[@"job"][@"skills"];
        }
        if(![userObject[@"job"][@"end_date"]isKindOfClass:[NSNull class]]) {
            self.lastDate = userObject[@"job"][@"end_date"];
        }
        
        if(![userObject[@"wishlist"]isKindOfClass:[NSNull class]]) {
            self.isWishList = [userObject[@"wishlist"]boolValue];
        }
        
    }
    
    if(userObject[@"job_application"]) {
        
        self.applicationJobId = userObject[@"job_application"][@"id"];
        if(![userObject[@"job_application"][@"is_applied"] isKindOfClass:[NSNull class]]) {
            self.is_applied = [userObject[@"job_application"][@"is_applied"] boolValue];
        }
        if(userObject[@"job_application"][@"cover_letter"]) {
            self.cover_letter = userObject[@"job_application"][@"cover_letter"];
        }
        if(userObject[@"job_application"][@"status"]) {
            self.status = userObject[@"job_application"][@"status"];
        }
    }
    
    if(userObject[@"user"]) {
        
        self.jobUserId = userObject[@"user"][@"user_id"];
        self.userAvatar = userObject[@"user"][@"avatar"];
        self.userName = userObject[@"user"][@"name"];
    }
}
@end
