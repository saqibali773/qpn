//
//  NotificationCell.m
//  QPN
//
//  Created by Muhammad Usman on 10/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "NotificationsOneCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation NotificationsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCell:(NotificationOne *)notif {
    self.name.text = notif.owner_name;
    self.time.text = notif.time;
    self.message.text = notif.message;
    [self.image sd_setImageWithURL:[NSURL URLWithString:notif.owner_avatar]
                    placeholderImage:[UIImage imageNamed:@"boy"]
                           completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                               }];
}

- (void)configureCellWithNotificationTwo:(NotificationTwo *)notif {
    self.name.text = notif.owner_name;
    self.time.text = notif.time;
    self.message.text = notif.message;
    [self.image sd_setImageWithURL:[NSURL URLWithString:notif.owner_avatar]
                  placeholderImage:[UIImage imageNamed:@"boy"]
                         completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                         }];
}


@end
