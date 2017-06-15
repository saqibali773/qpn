//
//  QPNAuthorizationManager+Jobs.m
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

#define API_APPLIED_JOBS @"/api/v1/applied_jobs"
#define API_WISH_JOBS @"/api/v1/wishlist"
#define API_RECOMMENDED_JOBS @"/api/v1/jobs"


#define API_DELINE_JOB @"/api/v1/job_applications"
#define API_APPLIED_JOBS @"/api/v1/applied_jobs"

@implementation QPNAuthorizationManager (Jobs)


- (void)getAppliedJobs:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_APPLIED_JOBS parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getWishJobs:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_WISH_JOBS parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getRecommendedJobs:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_RECOMMENDED_JOBS parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)onApplyJob:(NSString*)ID withParameter:(NSDictionary*)parameter parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:[NSString stringWithFormat:@"%@/%@/job_applications", API_RECOMMENDED_JOBS,ID] parameter:parameter encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)onDeclineJob:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {

    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:[NSString stringWithFormat:@"%@/%@",API_DELINE_JOB,ID] parameter:nil encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)onWishJob:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_WISH_JOBS parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)onDetailJob:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:[NSString stringWithFormat:@"%@/%@",API_RECOMMENDED_JOBS,ID] parameter:nil encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}
@end
