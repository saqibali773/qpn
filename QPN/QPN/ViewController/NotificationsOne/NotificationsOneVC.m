//
//  NotificationsOneVC.m
//  QPN
//
//  Created by Muhammad Usman on 10/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "NotificationsOneVC.h"
#import "NotificationCell.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager+Notification.h"
#import "NotificationOne.h"
#import "NotificationsOneCell.h"
#import "DetailPostVC.h"
@interface NotificationsOneVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *notification;
@end

@implementation NotificationsOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.badgeValue = nil;
    // Do any additional setup after loading the view from its nib.
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Waiting..."];
    [AUTH_MAN getNotification:@"1" parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if([response isKindOfClass:[NSArray class]]) {
            NSMutableArray *notifications = [NSMutableArray array];
            for (NSDictionary *iNotification in response) {
                NotificationOne *notif = [[NotificationOne alloc] initWithDictionary:iNotification];
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
    return 100.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * resuseID = @"NotificationsOneCell";
    NotificationsOneCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    NotificationOne *notif = [self.notification objectAtIndex:indexPath.row];
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationsOneCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell configureCell:notif];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NotificationOne *notif = [self.notification objectAtIndex:indexPath.row];
    if(notif.qpnPost){
        DetailPostVC * vc;
        vc = [[DetailPostVC alloc] initWithNibName:@"DetailPostVC" bundle:[NSBundle mainBundle]];
        vc.post = notif.qpnPost;
        self.navigationController.navigationBar.hidden = YES;
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    
    }
}
@end
