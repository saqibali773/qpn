//
//  NotificationTwo.m
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "NotificationTwo.h"
#import <UIKit/UIKit.h>


@implementation NotificationTwo

- (id)initWithDictionary:(NSDictionary*)notification {
    
    if(self = [super init])
    {
        if(![notification[@"notification"][@"id"] isKindOfClass:[NSNull class]]) {
            self.notificationId = notification[@"notification"][@"id"];
        }
        if(![notification[@"notification"][@"owner_id"] isKindOfClass:[NSNull class]]) {
            self.owner_id = notification[@"notification"][@"owner_id"];
        }
        if(![notification[@"notification"][@"user_id"] isKindOfClass:[NSNull class]]) {
            self.user_id = notification[@"notification"][@"user_id"];
        }
        if(![notification[@"notification"][@"read"] isKindOfClass:[NSNull class]]) {
            self.read = notification[@"notification"][@"read"];
        }
        if(![notification[@"notification"][@"note"] isKindOfClass:[NSNull class]]) {
            self.note = notification[@"notification"][@"note"];

        }
        self.message = notification[@"message"];
        self.owner_avatar = notification[@"owner_avatar"];
        if(![self.owner_avatar containsString:@"http"]) {
            self.owner_avatar = [NSString stringWithFormat:@"https:%@",self.owner_avatar];
        }
        self.owner_name = notification[@"owner_name"];
        self.time = notification[@"time"];
    }
    return self;
}


@end


