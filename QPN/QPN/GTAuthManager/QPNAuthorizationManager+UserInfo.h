//
//  QPNAuthorizationManager+UserInfo.h
//  QPN
//
//  Created by SaqibAli on 06/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNAuthorizationManager.h"

@interface QPNAuthorizationManager (UserInfo)


- (void)deleteCoverImage:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)deleteDPImage:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)deleteVideo:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getResume:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)updatePassword:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;

- (void)getFollowersFollowing:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;

- (void)otherUser:(NSString*)userId parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)followUnfollow:(NSDictionary*)parameter parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)getOtherPost:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;


- (void)getOtherEducations:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getOtherExperiences:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getOtherSkills:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getOtherAchievemnts:(NSString*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;



@end
