//
//  QPNUser.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTConstants.h"
@interface QPNUser : NSObject

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *country_id;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *country_name;

@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *salutation;
@property (nonatomic, strong) NSString *first_name;
@property (nonatomic, strong) NSString *middle_name;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic, strong) NSString *dob;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *careerObjective;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *company_address;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *employee_name;
@property (nonatomic, strong) NSString *industry_name;
@property (nonatomic, strong) NSString *company_num;
@property (nonatomic, strong) NSString *institute_name;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *avatar_file_name;
@property (nonatomic, strong) NSString *cover_avatar_file_name;
@property (nonatomic, strong) NSString *company_url;
@property (nonatomic, strong) NSString *company_name;

@property (nonatomic, strong) NSNumber *role_id;
@property (nonatomic, strong) NSNumber *_notification_count_Request;
@property (nonatomic, strong) NSNumber *notification_count_simple;
@property (nonatomic, readwrite)bool approved;
@property (nonatomic, strong) NSString *auth_token;
@property (nonatomic, strong) NSString *job_title;
@property (nonatomic, strong) NSNumber *ratings;
@property (nonatomic, strong) NSNumber *nationality_id;
@property (nonatomic, strong) NSString *nationality_name;
@property (nonatomic, strong) NSString *code;     //"92",
@property (nonatomic, strong) NSString *accept_code;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, strong) NSString *role;

@property (nonatomic, strong) NSString *following;

@property (nonatomic, strong) NSArray *connects;
@property (nonatomic, readwrite)bool sms_approved;

@property (nonatomic, readwrite)bool isCoverExist;
@property (nonatomic, readwrite)bool isDPExist;


-(id)initWithDictionary:(NSDictionary*) userObject isShortInfo:(bool)shortInfo;
-(void)updateWithDictionaryFullInfo:(NSDictionary*) userObject;
-(void)updateWithDictionaryShortInfo:(NSDictionary*) userObject;

@end
