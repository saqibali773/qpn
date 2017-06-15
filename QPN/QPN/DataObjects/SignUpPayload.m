//
//  SignUpPayload.m
//  QPN
//
//  Created by Muhammad Usman on 12/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SignUpPayload.h"

@implementation SignUpPayload

@synthesize member_type,title,first_name,middle_name,last_name,d_o_b,gender,mobile_number,employer_name,job_title,industry_name,institute_name,nationality,nationality_code,country,country_id,city,email,password,confirm_password,company_name,company_address,company_url,company_land_line,user_role;

-(id)init
{
    if(self = [super init])
    {
        user_role = @0;
        member_type = @"";
        title = @"";
        first_name = @"";
        middle_name = @"";
        last_name = @"";
        d_o_b = @"";
        gender = @"";
        mobile_number = @"";
        employer_name = @"";
        job_title = @"";
        industry_name = @"";
        institute_name = @"";
        nationality = @"";
        nationality_code = @"";
        country = @"";
        country_id = @"";
        city = @"";
        email = @"";
        password = @"";
        confirm_password= @"";
        company_name=@"";
        company_address=@"";
        company_url=@"";
        company_land_line=@"";
        _qID=@"";
        _country_code=@"";

    }
    return self;
}
-(NSMutableDictionary*)givePayloadDictionary{
    NSMutableDictionary*dic = [NSMutableDictionary dictionary];
    
    dic[@"salutation"] = [NSString stringWithFormat:@"%@",self.title];
    dic[@"first_name"] = [NSString stringWithFormat:@"%@",self.first_name];
    dic[@"middle_name"] = [NSString stringWithFormat:@"%@",self.middle_name];
    dic[@"last_name"] = [NSString stringWithFormat:@"%@",self.last_name];
    dic[@"dob"] = [NSString stringWithFormat:@"%@",self.d_o_b];
    if ([self.gender isEqualToString:@"Male"]) {
        dic[@"gender"] = @"1";
    }
    else {
        dic[@"gender"] = @"2";
    }
    dic[@"code"] = [NSString stringWithFormat:@"%@",self.country_code]; // static for now
    dic[@"telephone"] = [NSString stringWithFormat:@"%@",self.mobile_number];
    dic[@"industry_name"] = [NSString stringWithFormat:@"%@",self.industry_name];
    dic[@"institute_name"] = [NSString stringWithFormat:@"%@",self.institute_name];
    dic[@"nationality_id"] = [NSString stringWithFormat:@"%@",self.nationality_code];
    dic[@"country_id"] = [NSString stringWithFormat:@"%@",self.country_id];
    dic[@"city"] = [NSString stringWithFormat:@"%@",self.city];
    dic[@"email"] = [NSString stringWithFormat:@"%@",self.email];
    dic[@"password"] = [NSString stringWithFormat:@"%@",self.password];
    dic[@"password_confirmation"] = [NSString stringWithFormat:@"%@",self.confirm_password];
    dic[@"role"] = [NSString stringWithFormat:@"%@",user_role];
    dic[@"qid"] = [NSString stringWithFormat:@"%@",self.qID];
    
    return dic;
    
    
    
    
}
@end
