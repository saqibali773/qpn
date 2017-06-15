//
//  SignUpPayload.h
//  QPN
//
//  Created by Muhammad Usman on 12/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignUpPayload : NSObject

@property (nonatomic,strong) NSNumber *user_role;

@property (nonatomic, strong) NSString * member_type;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * first_name;
@property (nonatomic, strong) NSString * middle_name;
@property (nonatomic, strong) NSString * last_name;
@property (nonatomic, strong) NSString * d_o_b;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, strong) NSString * mobile_number;
@property (nonatomic, strong) NSString * qID;

@property (nonatomic, strong) NSString * employer_name;
@property (nonatomic, strong) NSString * job_title;
@property (nonatomic, strong) NSString * industry_name;
@property (nonatomic, strong) NSString * institute_name;
@property (nonatomic, strong) NSString * nationality;
@property (nonatomic, strong) NSString * nationality_code;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, strong) NSString * country_id;
@property (nonatomic, strong) NSString * country_code;
@property (nonatomic, strong) NSString * city;

@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * confirm_password;

@property (nonatomic, strong) NSString * company_name;
@property (nonatomic, strong) NSString * company_address;
@property (nonatomic, strong) NSString * company_url;

@property (nonatomic, strong) NSString * company_land_line;

-(NSMutableDictionary*)givePayloadDictionary;

@end
