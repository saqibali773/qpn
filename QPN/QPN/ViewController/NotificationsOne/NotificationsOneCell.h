//
//  NotificationsOneCell.h
//  QPN
//
//  Created by Muhammad Usman on 10/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationOne.h"
#import "NotificationTwo.h"
@interface NotificationsOneCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *message;


- (void)configureCell:(NotificationOne *)notif;
- (void)configureCellWithNotificationTwo:(NotificationTwo *)notif;

@end
