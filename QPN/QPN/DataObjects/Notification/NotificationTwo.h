//
//  NotificationTwo.h
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NotificationTwo : NSObject
@property (nonatomic, readwrite) NSNumber *notificationId;
@property (nonatomic, readwrite) NSString *notifiable_type;
@property (nonatomic, readwrite) NSNumber *owner_id;
@property (nonatomic, readwrite) NSNumber *user_id;
@property (nonatomic, readwrite) NSNumber *read;

@property (nonatomic, readwrite) NSString *message;
@property (nonatomic, readwrite) NSString *note;
@property (nonatomic, readwrite) NSString *owner_avatar;
@property (nonatomic, readwrite) NSString *owner_name;
@property (nonatomic, readwrite) NSString *time;

- (id)initWithDictionary:(NSDictionary *)notification;





 @end
