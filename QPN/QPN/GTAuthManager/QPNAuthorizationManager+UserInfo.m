//
//  QPNAuthorizationManager+UserInfo.m
//  QPN
//
//  Created by SaqibAli on 06/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNAuthorizationManager+UserInfo.h"
#import "ServerEngine.h"
#import "QPNSharedData.h"
#import "GTColorConstants.h"
#import "GTAPIConstant.h"

#define API_EMAIL_RESUME @"/api/v1/resume_mail"
#define API_FOLLOW_RELATION @"/api/v1/relationships"
#define API_GET_OTHER_POST @"/api/v1/other_user/"


#define API_USER_GET_Follows @"/api/v1/connects"


@implementation QPNAuthorizationManager (UserInfo)




- (void)deleteCoverImage:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler{
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_DEL_COVER parameter:parameters encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)deleteDPImage:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler{
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_DEL_AVATAR parameter:parameters encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)deleteVideo:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler{
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_DEL_VIDEO parameter:parameters encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}


- (void)updatePassword:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler{
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_UPDATE parameter:parameters encoding:parameterEncoding httpMethod:PATCH completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getResume:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_EMAIL_RESUME parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)otherUser:(NSString*)userId parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:[NSString stringWithFormat:@"%@/%@",API_USER_INFO,userId] parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)followUnfollow:(NSDictionary*)parameter parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_FOLLOW_RELATION parameter:parameter encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getOtherPost:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler{
    NSString*url =  [NSString stringWithFormat:@"%@%@/posts",API_GET_OTHER_POST,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getFollowersFollowing:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    NSString*url = [NSString stringWithFormat:@"%@/%@",API_USER_GET_Follows,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getOtherAchievemnts:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    NSString*url = [NSString stringWithFormat:@"%@?id=%@",API_USER_GET_ACHIEVEMENTS,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)getOtherExperiences:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    NSString*url = [NSString stringWithFormat:@"%@?id=%@",API_USER_GET_EXPERINCES,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getOtherEducations:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    NSString*url = [NSString stringWithFormat:@"%@?id=%@",API_USER_GET_EDUCATIONS,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getOtherSkills:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    NSString*url = [NSString stringWithFormat:@"%@?id=%@",API_USER_GET_SKILLS,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}



@end
