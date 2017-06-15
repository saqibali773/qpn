//
//  QPNUser..m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNUser.h"
#import "GTConstants.h"
#import "QPNSharedData.h"
#import "ConnectUser.h"
@implementation QPNUser

- (id)initWithDictionary:(NSDictionary*)userObject isShortInfo:(bool)shortInfo {
    
    if(self = [super init])
    {
        if (shortInfo)
        {
            [self updateWithDictionaryShortInfo:userObject];
        }
        else
        {
            [self updateWithDictionaryFullInfo:userObject];
        }
        
    }
    return self;
}
- (void)updateWithDictionaryFullInfo:(NSDictionary*)userObject {
    
    // Strings
    _email  = CHECK_STRING(userObject[@"email"]);
    _password = CHECK_STRING(userObject[@"password"]);
    _salutation = CHECK_STRING(userObject[@"salutation"]);
    _first_name = CHECK_STRING(userObject[@"first_name"]);
    _middle_name = CHECK_STRING(userObject[@"middle_name"]);
    _last_name = CHECK_STRING(userObject[@"last_name"]);
    _dob = CHECK_STRING(userObject[@"dob"]);
    _gender = CHECK_STRING(userObject[@"gender"]);
    _telephone = CHECK_STRING(userObject[@"telephone"]);
    _city = CHECK_STRING(userObject[@"city"]);
    _company_address = CHECK_STRING(userObject[@"company_address"]);
    _employee_name = CHECK_STRING(userObject[@"employee_name"]);
    _company_num = CHECK_STRING(userObject[@"company_num"]);
    _industry_name = CHECK_STRING(userObject[@"industry_name"]);
    _institute_name = CHECK_STRING(userObject[@"institute_name"]);
    _provider = CHECK_STRING(userObject[@"provider"]);
    _uid = CHECK_STRING(userObject[@"uid"]);
    
    
    _avatar_file_name = CHECK_STRING(userObject[@"avatar"]);
    if(![_avatar_file_name containsString:@"http"]) {
        _avatar_file_name = [NSString stringWithFormat:@"http:%@",self.avatar_file_name];
    }
    
    _cover_avatar_file_name = CHECK_STRING(userObject[@"cover_avatar"]);
    if(![self.cover_avatar_file_name containsString:@"http"]) {
        _cover_avatar_file_name = [NSString stringWithFormat:@"http:%@",self.cover_avatar_file_name];
    }
    
    if([self.cover_avatar_file_name containsString:@"default"]) {
        _isCoverExist = NO;
    }else {
        _isCoverExist = YES;
    }
    
    if([self.avatar_file_name containsString:@"default"]) {
        _isDPExist = NO;
    }else {
        _isDPExist = YES;
    }
    
    _company_url = CHECK_STRING(userObject[@"company_url"]);
    _company_name = CHECK_STRING(userObject[@"company_name"]);
    _auth_token = CHECK_STRING(userObject[@"auth_token"]);
    _job_title = CHECK_STRING(userObject[@"job_title"]);
    _code = CHECK_STRING(userObject[@"code"]);
    _accept_code = CHECK_STRING(userObject[@"accept_code"]);
    _careerObjective = CHECK_STRING(userObject[@"career_objective"]);
    _role = userObject[@"role"];
    // Numbers
    __notification_count_Request = userObject[@"notification_count_request"];
    _notification_count_simple = userObject[@"notification_count_simple"];
    _userId = userObject[@"id"];
    _rating = userObject[@"ratings"];
    _country_id = userObject[@"country_id"];
    _role_id = userObject[@"role_id"];
    _ratings = userObject[@"ratings"];
    _nationality_id = userObject[@"nationality_id"];
    _nationality_name = CHECK_STRING(userObject[@"nationality_name"]);
    _country_name = CHECK_STRING(userObject[@"country_name"]);
    
    // Boolean
    _approved = userObject[@"approved"];
    _sms_approved = userObject[@"sms_approved"];
    _video = userObject[@"video"];
    
    if(userObject[@"connects"]) {
        [self addConnects:userObject[@"connects"]];
    }
    if(![userObject[@"following"] isKindOfClass:[NSNull class]]) {
        self.following = userObject[@"following"];
    }

}
- (void)addConnects:(NSArray *)connects {

    NSMutableArray *tempConnects = [[NSMutableArray alloc] init];
    
    for(NSDictionary *iConnects in connects) {
        ConnectUser *user = [[ConnectUser alloc] initWithDictionary:iConnects];
        [tempConnects addObject:user];
        user = nil;
    }
    
    _connects = tempConnects;
    
}


- (void)updateWithDictionaryShortInfo:(NSDictionary*)userObject {
    
    _userId = userObject[@"id"];
    if(userObject[@"name"]){
        _first_name = CHECK_STRING(userObject[@"name"]);
    }
    if(userObject[@"full_name"]){
        _first_name = CHECK_STRING(userObject[@"full_name"]);
    }
    _rating = userObject[@"ratings"];
    
    _avatar_file_name = CHECK_STRING(userObject[@"avatar"]);
    if(![_avatar_file_name containsString:@"http"]) {
        _avatar_file_name = [NSString stringWithFormat:@"http:%@",self.avatar_file_name];
    }
    if(![userObject[@"following"] isKindOfClass:[NSNull class]]) {
        self.following = userObject[@"following"];
    }
    _cover_avatar_file_name = CHECK_STRING(userObject[@"cover_avatar"]);
    if(![self.cover_avatar_file_name containsString:@"http"]) {
        _cover_avatar_file_name = [NSString stringWithFormat:@"http:%@",self.cover_avatar_file_name];
    }
    if(userObject[@"connects"]) {
        [self addConnects:userObject[@"connects"]];
    }
    
    _company_name = CHECK_STRING(userObject[@"company_name"]);
    if(userObject[@"industry_name"]) {
        _job_title = CHECK_STRING(userObject[@"industry_name"]);
    }
}
@end
