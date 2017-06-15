//
//  NotificationOne.h
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QPNPost.h"

@interface NotificationOne : NSObject
@property (nonatomic, strong) NSNumber *notificationId;
@property (nonatomic, strong) NSString *notifiable_type;
@property (nonatomic, strong) NSNumber *owner_id;
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSNumber *read;

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *owner_avatar;
@property (nonatomic, strong) NSString *owner_name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) QPNPost * qpnPost;
- (id)initWithDictionary:(NSDictionary *)notification;

 @end
