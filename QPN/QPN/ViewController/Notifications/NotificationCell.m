//
//  NotificationCell.m
//  QPN
//
//  Created by Muhammad Usman on 10/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "NotificationCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "QPNAuthorizationManager+Notification.h"
#import "QPNAuthorizationManager.h"


@implementation NotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCell:(NotificationTwo *)notif {
    self.notif = notif;
    self.name.text = notif.owner_name;
    self.time.text = notif.time;
    self.message.text = notif.message;
    [self.image sd_setImageWithURL:[NSURL URLWithString:notif.owner_avatar]
                    placeholderImage:[UIImage imageNamed:@"boy"]
                           completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                               }];
}

- (IBAction)acceptClick:(id)sender {
    
    [AUTH_MAN acceptRejectNotification:@{@"id":self.notif.notificationId,@"accept":@1} parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION" object:nil];
    
    }];
}

- (IBAction)rejectClick:(id)sender {
    
    
    [AUTH_MAN acceptRejectNotification:@{@"id":self.notif.notificationId,@"accept":@0} parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION" object:nil];
    
    }];
    
}


@end
