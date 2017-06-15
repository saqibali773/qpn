//
//  QPNAuthorizationManager+Notification.m
//  QPN
//
//  Created by SaqibAli on 06/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNAuthorizationManager+Notification.h"
#import "ServerEngine.h"
#import "QPNSharedData.h"
#import "GTColorConstants.h"
#import "GTAPIConstant.h"

#define API_GET_NOTIFICATION @"/api/v1/notifications?type="
#define API_MARK_NOTIFICATION @"/api/v1/mark_notification_read"

#define API_ACCEPT_REJECT @"/api/v1/accept_follower"

@implementation QPNAuthorizationManager (Notification)


- (void)getNotification:(NSString*)type parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
   
    [self notificationCount:type parameterEncoding:parameterEncoding completionHanlder:handler];
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:[NSString stringWithFormat:@"%@%@",API_GET_NOTIFICATION,type] parameter:nil encoding:parameterEncoding httpMethod:GET completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}

- (void)acceptRejectNotification:(NSDictionary*)param parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
  
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_ACCEPT_REJECT parameter:param encoding:parameterEncoding httpMethod:POST completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}


- (void)notificationCount:(NSString*)type parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler {
    
    DataRequest* request =  [[ServerEngine getSharedInstance] requestWithPathString:API_MARK_NOTIFICATION parameter:@{@"type":type} encoding:parameterEncoding httpMethod:PATCH completionHandler:^(id response, NSError *error) {
        NSLog(@"Response: %@",response);
        handler(response,error);
    }];
    [request executeRequest];
}



@end
