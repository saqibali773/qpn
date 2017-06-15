//
//  QPNAuthorizationManager+Notification.h
//  QPN
//
//  Created by SaqibAli on 06/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNAuthorizationManager.h"

@interface QPNAuthorizationManager (Notification)


- (void)getNotification:(NSString*)type parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)acceptRejectNotification:(NSDictionary*)param parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;

- (void)notificationCount:(NSString*)type parameterEncoding:(ParameterEncoding)parameterEncoding completionHanlder:(RequestCompletionHandler) handler;


@end
