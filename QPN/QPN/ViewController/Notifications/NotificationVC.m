//
//  NotificationVC.m
//  QPN
//
//  Created by Muhammad Usman on 10/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "NotificationVC.h"
#import "NotificationCell.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager+Notification.h"
#import "NotificationTwo.h"
#import "NotificationsOneCell.h"
#import "OtherProfileVC.h"
@interface NotificationVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *notification;
@end

@implementation NotificationVC




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification) name:@"NOTIFICATION" object:nil];
    
    // Do any additional setup after loading the view from its nib.
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Waiting..."];
    self.tabBarItem.badgeValue = nil;
    [self getNotification];

}

- (void)getNotification {

    [AUTH_MAN getNotification:@"2" parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if([response isKindOfClass:[NSArray class]]) {
            NSMutableArray *notifications = [NSMutableArray array];
            for (NSDictionary *iNotification in response) {
                NotificationTwo *notif = [[NotificationTwo alloc] initWithDictionary:iNotification];
                [notifications addObject:notif];
            }
            self.notification = notifications;
            [self.tableView reloadData];
        }
    }];
}
- (void)viewDidDisappear:(BOOL)animated {
    if ([self.tabBarController.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.tabBarController.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notification.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationTwo *notif = [self.notification objectAtIndex:indexPath.row];
    if(![notif.note isEqualToString:@"accept"]) {
        return 147.0;
    }else {
        return 100.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotificationTwo *notif = [self.notification objectAtIndex:indexPath.row];

    if(![notif.note isEqualToString:@"accept"]) {
        NSString * resuseID = @"NotificationCell";
        NotificationCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell configureCell:notif];
        return cell;
    } else {
        NSString * resuseID = @"NotificationsOneCell";
        NotificationsOneCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationsOneCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell configureCellWithNotificationTwo:notif];
        return cell;
    }


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NotificationTwo *notif = [self.notification objectAtIndex:indexPath.row];
    if([notif.note isEqualToString:@"accept"]) {
        OtherProfileVC * vc = [[OtherProfileVC alloc] initWithNibName:@"OtherProfileVC" bundle:[NSBundle mainBundle]];
        vc.userId = [notif.owner_id stringValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
@end
