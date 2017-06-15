//
//  QPNAuthorizationManager+Jobs.h
//  QPN
//
//  Created by SaqibAli on 06/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNAuthorizationManager.h"

@interface QPNAuthorizationManager (Jobs)


- (void)getAppliedJobs:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getWishJobs:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getRecommendedJobs:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)onApplyJob:(NSString*)ID withParameter:(NSDictionary*)parameter parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)onDeclineJob:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)onWishJob:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)onDetailJob:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler ;

@end
