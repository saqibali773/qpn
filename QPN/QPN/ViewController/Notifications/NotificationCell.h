//
//  NotificationCell.h
//  QPN
//
//  Created by Muhammad Usman on 10/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationTwo.h"
@interface NotificationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) NotificationTwo *notif;



- (void)configureCell:(NotificationTwo *)notif;

@end
