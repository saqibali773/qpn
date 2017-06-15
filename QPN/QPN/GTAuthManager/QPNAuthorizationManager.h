//
//  QPNAuthorizationManager.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GTConstants.h"
#import "GTEnumConstant.h"

#import <CoreLocation/CoreLocation.h>
//typedef void (^GTLoginCompletionHandler)(id response, NSError* error);
#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]

@interface QPNAuthorizationManager : NSObject



// initializer
+(QPNAuthorizationManager * )getSharedInstance;
+(void) releaseSharedInstance;
@property (nonatomic) NSString* authToken;

// user related
- (void)loginWithParameters:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)registerWithParameters:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)isUserApproved:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)smsCodeApproval:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)authenticateUser:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getUserInfo:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)logoutUser:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getCountry:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)getIndustries:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)updateUser:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;

- (void)getEducations:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)addEducations:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)updateEducations:(NSDictionary*) parameters catagoryId:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)getExperiences:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)addExperiences:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)updateExperiences:(NSDictionary*) parameters catagoryId:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)getAchievemnts:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)addAchievemnts:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)updateAchievemnts:(NSDictionary*) parameters catagoryId:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;


- (void)getSkills:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)addSkills:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)updateSkills:(NSDictionary*) parameters catagoryId:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)deleteEducation:(NSNumber*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)deleteExperince:(NSNumber*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler ;
- (void)deleteAchievemnts:(NSNumber*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;
- (void)deleteSkills:(NSNumber*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)getCountryDialCode:(NSString *)countryId parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

#pragma -mark Post

- (void)createPost:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;

- (void)likePost:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)unlikePost:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)deletePost:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)editPost:(NSString*) ID params:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;

- (void)addCommentOnPost:(NSString*) ID params:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;

- (void)getAllCommets:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)getTimelinePost:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;

- (void)getNewsFeedPost:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;

#pragma -mark Search
- (void)searchFeed:(NSString*) searchString parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler;
#pragma -mark Helper
- (void)showWorkingSpinner:(UIView*) view text:(NSString*) text;
- (void)hideWorkingSpinner:(UIView*) view;
- (void)hideWorkingSpinner:(UIView*) view after:(float) seconds;
- (void)showErrorMessage:(UIView*) view text:(NSString*) text;
- (void)hideErrorMessage:(UIView*) view;


- (void)saveAuthData;
- (void)removeAuthData;

- (BOOL)CheckPasswordIsValid:(NSString *)checkString;
- (BOOL)NSStringIsValidEmail:(NSString *)checkString;

@end
