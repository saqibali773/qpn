//
//  QPNAuthorizationManager.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#import "QPNAuthorizationManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "ServerEngine.h"
#import "QPNSharedData.h"
#import "GTColorConstants.h"
#import "GTAPIConstant.h"

@interface QPNAuthorizationManager ()
@property (nonatomic) RequestCompletionHandler loginCompletionHandler;
@property (nonatomic) UIViewController * viewController;
@end
@implementation QPNAuthorizationManager


static QPNAuthorizationManager * staticSharedDataInstance = NULL;

+ (QPNAuthorizationManager * ) getSharedInstance {
    
    if(staticSharedDataInstance == NULL)
    {
        staticSharedDataInstance = [[QPNAuthorizationManager alloc] init];
    }
    return staticSharedDataInstance;
}

+ (void)releaseSharedInstance {
    if(staticSharedDataInstance)
    {
        staticSharedDataInstance = NULL;
    }
}
- (id)init {
    self = [super init];
    if(self)
    {
        NSString * cachedToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"auth_token"];
        if (cachedToken&&!isEmpty(cachedToken))
        {
            self.authToken = cachedToken;
        }
        else
        {
            self.authToken = nil;
        }
    }
    
    return self;

}
#pragma mark - Login Methods

- (void)loginWithParameters:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler{
   DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_LOGIN parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
       self.authToken = response[@"auth_token"];
       [self saveAuthData];
       handler(response,error);
   }];
    [request executeRequest];
}

- (void)registerWithParameters:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler{
   
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_SIGNUP parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        
        if (response && response[@"user"][@"auth_token"])
        {
            self.authToken = response[@"user"][@"auth_token"];
            [self saveAuthData];
        }
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)smsCodeApproval:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler{
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_SMS_CODE_APPROVAL parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)isUserApproved:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_APPROVED parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)authenticateUser:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {

    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_AUTHENTICATE parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getUserInfo:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_INFO parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)logoutUser:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_LOGOUT parameter:parameters encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        
        [self removeAuthData];
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)updateUser:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_UPDATE parameter:parameters encoding:parameterEncoding httpMethod:PATCH completionHandler:^(id response, NSError *error) {
       NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)createPost:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_CREATE_POST parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {        
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)likePost:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/like",API_LIKE_POST,ID];
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)unlikePost:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/unlike",API_UNLIKE_POST,ID];
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)deletePost:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_DELETE_POST,ID];
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)editPost:(NSString*) ID params:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_EDIT_POST,ID];
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:parameters encoding:parameterEncoding httpMethod:PATCH completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)addCommentOnPost:(NSString*) ID params:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler
{
    NSString *url = [NSString stringWithFormat:@"%@/%@/comment",API_ADD_COMMENT_POST,ID];
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getAllCommets:(NSString*) ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/comments",API_GET_ALL_COMMENTS_POST,ID];
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getTimelinePost:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_GET_TIMELINE_POST parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getNewsFeedPost:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_GET_NEWS_FEED_POST parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}


- (void)searchFeed:(NSString*) searchString parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_SEARCH_POST,searchString];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}


- (void)getCountry:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_GETCOUNTRY parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        NSMutableDictionary *okdic = [NSMutableDictionary dictionary];
        for (NSDictionary *dic in response) {
            okdic[dic[@"iso"]] = [NSString stringWithFormat:@"%@",dic[@"id"]];
        }
        
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getIndustries:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding  completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_GET_INDUSTERIES parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getEducations:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_GET_EDUCATIONS parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)addEducations:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_SET_EDUCATIONS parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)updateEducations:(NSDictionary*) parameters catagoryId:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_USER_UPDATE_EDUCATIONS,ID];
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:parameters encoding:parameterEncoding httpMethod:PATCH completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}


- (void)getExperiences:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
   
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_GET_EXPERINCES parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)addExperiences:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_SET_EXPERINCES parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)updateExperiences:(NSDictionary*) parameters catagoryId:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_UPDATE_USER_EXPERINCES,ID];
    
    DataRequest* request = [[ServerEngine getSharedInstance] requestWithPathString:url parameter:parameters encoding:parameterEncoding httpMethod:PATCH completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getAchievemnts:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
   
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_GET_ACHIEVEMENTS parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)updateAchievemnts:(NSDictionary*) parameters catagoryId:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_UPDATE_USER_ACHIEVEMENTS,ID];
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:parameters encoding:parameterEncoding httpMethod:PATCH completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getSkills:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_GET_SKILLS parameter:parameters encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)updateSkills:(NSDictionary*) parameters catagoryId:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler; {
    
     NSString *url = [NSString stringWithFormat:@"%@/%@",API_UPDATE_USER_SKILLS,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:parameters encoding:parameterEncoding httpMethod:PATCH completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)addAchievemnts:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_SET_ACHIEVEMENTS parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}


- (void)addSkills:(NSDictionary*) parameters parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_USER_SET_SKILLS parameter:parameters encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}


- (void)deleteEducation:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_USER_GET_EDUCATIONS,ID];

    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)deleteExperince:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_USER_GET_EXPERINCES,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)deleteAchievemnts:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_USER_GET_ACHIEVEMENTS,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}
- (void)deleteSkills:(NSNumber*)ID parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_USER_GET_SKILLS,ID];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:DELETE completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)getCountryDialCode:(NSString *)countryId parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    NSString *url = [NSString stringWithFormat:@"%@/%@",API_USER_GET_COUNTRY_DCODE,countryId];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:url parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        handler(response,error);
    }];
    [request executeRequest];
}


#pragma mark - Helpers
- (void)saveAuthData {
    [[NSUserDefaults standardUserDefaults] setObject:self.authToken forKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)removeAuthData {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     self.authToken  = nil;
}
#pragma mark - Helpers
- (void)showWorkingSpinner:(UIView*) view text:(NSString*) text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[view viewWithTag:6526] removeFromSuperview];
        
        UIView * vv = [[UIView alloc] initWithFrame:view.frame];
        [vv setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
        
        vv.tag = 6526;
        [view addSubview:vv];
        
        UIView * bgView;
        
        if (text)
        {
            
            UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0,70.0, 150.0, 70.0)];
            lbl.text = text;
            lbl.textColor = [UIColor whiteColor];
            lbl.numberOfLines = 2;
            lbl.font = [UIFont  systemFontOfSize:17.0];
            lbl.textAlignment = NSTextAlignmentCenter;
            [lbl sizeToFit];
            
            
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0+lbl.frame.size.height, 100.0+lbl.frame.size.height)];
            lbl.frame = CGRectMake((bgView.frame.size.width-lbl.frame.size.width)*0.5, 80.0,lbl.frame.size.width , lbl.frame.size.height);
            [bgView addSubview:lbl];
        }
        else
        {
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
        }
        
        bgView.backgroundColor = [UIColor clearColor];
        bgView.center = CGPointMake(vv.frame.size.width*0.5, vv.frame.size.height*0.5);
        bgView.layer.cornerRadius = 10.0;
        [vv addSubview:bgView];
        
        UIImageView*imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 80.0)];
        imgView.center = CGPointMake(bgView.frame.size.width*0.5, bgView.frame.size.height*0.2);
        
        NSMutableArray*array = [NSMutableArray array];
        for(int i=1;i<=20;i++){
            NSString*str = [NSString stringWithFormat:@"loader_%d.png",i];
            [array addObject:[UIImage imageNamed:str]];
        }
        
        imgView.animationImages = array;
        [bgView addSubview:imgView];
        imgView.animationDuration = 1.0;
        [imgView startAnimating];
        
    });
    
}
- (void)hideWorkingSpinner:(UIView*) view {
    dispatch_async(dispatch_get_main_queue(), ^{
        [((UIActivityIndicatorView*)[view viewWithTag:6527]) stopAnimating];
        [[view viewWithTag:6526] removeFromSuperview];
        
    });
}
- (void)hideWorkingSpinner:(UIView*) view after:(float) seconds {
    dispatch_async(dispatch_get_main_queue(), ^{
        [((UIActivityIndicatorView*)[view viewWithTag:6527]) stopAnimating];
        [[view viewWithTag:6526] removeFromSuperview];
    });
}

- (void)showErrorMessage:(UIView*) view text:(NSString*) text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[view viewWithTag:6500] removeFromSuperview];
        
        UIView * vv = [[UIView alloc] initWithFrame:view.frame];
        [vv setBackgroundColor:[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:0.5]];
        vv.tag = 6500;
        [view addSubview:vv];
        
        UIView * bgView;
        
        if (text)
        {
            
            UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0,70.0, 150.0, 70.0)];
            lbl.text = text;
            lbl.numberOfLines = 2;
            lbl.font = APP_FONT(16);
            lbl.textAlignment = NSTextAlignmentCenter;
            [lbl sizeToFit];
            
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0+lbl.frame.size.width, 100.0+lbl.frame.size.height)];
            lbl.frame = CGRectMake((bgView.frame.size.width-lbl.frame.size.width)*0.5, 50.0,lbl.frame.size.width , lbl.frame.size.height);
            [bgView addSubview:lbl];
        }
        else
        {
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
        }
        
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.center = CGPointMake(vv.frame.size.width*0.5, vv.frame.size.height*0.5);
        bgView.layer.cornerRadius = 10.0;
        [vv addSubview:bgView];
        
    });
    [self hideErrorMessage:view];
}

- (void)hideErrorMessage:(UIView*) view {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[view viewWithTag:6500] removeFromSuperview];
        
    });
}
- (BOOL)CheckPasswordIsValid:(NSString *)checkString {

    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z]{6,}$";
    NSString *emailRegex = stricterFilterString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
- (BOOL)NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


@end
