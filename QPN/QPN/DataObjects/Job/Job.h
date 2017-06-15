//
//  Job.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTConstants.h"
#import "QPNUser.h"
#import "QPNPostComment.h"

@interface Job : NSObject

@property (nonatomic, readwrite)NSNumber *job_id;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *jobDescription;
@property (nonatomic, strong)NSString *industry;
@property (nonatomic, strong)NSNumber *required_experience;
@property (nonatomic, strong)NSString *region;
@property (nonatomic, strong)NSString *contract_type;
@property (nonatomic, strong)NSString *location;
@property (nonatomic, strong)NSString *company_name;
@property (nonatomic, strong)NSString *skills;
@property (nonatomic, strong)NSString *lastDate;
@property (nonatomic, readwrite)bool isInternShip;
@property (nonatomic, readwrite)bool isWishList;

// Job Application
@property (nonatomic, strong)NSNumber *applicationJobId;
@property (nonatomic, strong)NSString *cover_letter;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, readwrite)bool is_applied;

// Job Owner
@property (nonatomic, readwrite)NSNumber *jobUserId;
@property (nonatomic, readwrite)NSString *userName;
@property (nonatomic, readwrite)NSString *userAvatar;


-(id)initWithDictionary:(NSDictionary*) userObject;
-(void)updateWithDictionary:(NSDictionary*) userObject;

@end
