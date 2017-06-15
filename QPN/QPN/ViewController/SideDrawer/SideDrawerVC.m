//
//  SideDrawerVC.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SideDrawerVC.h"
#import "SideMenuCell.h"
#import "AppDelegate.h"


@interface SideDrawerVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SideDrawerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedCell = 0;
    
    self.sideList = [NSMutableArray array];
    
    [self sideListUpdate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sideListUpdate)
                                            name:@"TestNotification"
                                               object:nil];
    
}


-(void)sideListUpdate{
    [self.sideList removeAllObjects];
    
//    if([USER_DEF objectForKey:PH_NO]){
//        [self.sideList addObject:@{@"logo":@"home",@"logo1":@"home1",@"lableText":@"HOME"}];
//        [self.sideList addObject:@{@"logo":@"profile",@"logo1":@"profile1",@"lableText":@"My Profile"}];
//        [self.sideList addObject:@{@"logo":@"OrderNow",@"logo1":@"OrderNow1",@"lableText":@"ORDER NOW"}];
//        [self.sideList addObject:@{@"logo":@"addReferal",@"logo1":@"addReferal1",@"lableText":@"Refer a Friend"}];
//        [self.sideList addObject:@{@"logo":@"How",@"logo1":@"How1",@"lableText":@"How it Works"}];
//        [self.sideList addObject:@{@"logo":@"terms&conditin1",@"logo1":@"terms&conditin1",@"lableText":@"Terms And Condition"}];
//        [self.sideList addObject:@{@"logo":@"contactUs",@"logo1":@"contactUs1",@"lableText":@"Contact Us"}];
//        [self.sideList addObject:@{@"logo":@"currentOrder",@"logo1":@"currentOrder1",@"lableText":@"MY CURRENT ORDER"}];
//        [self.sideList addObject:@{@"logo":@"history",@"logo1":@"history1",@"lableText":@"My Order History"}];
//    }else{
//        
//        [self.sideList addObject:@{@"logo":@"addReferal",@"logo1":@"addReferal1",@"lableText":@"Refer a Friend"}];
//           [self.sideList addObject:@{@"logo":@"contactUs",@"logo1":@"contactUs1",@"lableText":@"Contact Us"}];
//
//    }
    [self.sideMenuTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeDrawerBtnClicked:(UIButton *)sender {
    
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootContainer setMenuState:MFSideMenuStateClosed];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * resuseID = @"HomeSideCell";
    SideMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SideMenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.percent.hidden = YES;
    
    switch (indexPath.row) {
        case 0:
            cell.title.text= @"Search";
            break;
        case 1:
            cell.title.text= @"Recent Applications";
            break;

        case 2:
            cell.title.text= @"Recent Jobs";
            break;

        case 3:
            cell.title.text= @"Profile";
            cell.percent.hidden = NO;
            break;
        
        case 4:
            cell.title.text= @"Log Out";
            break;

        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary* viewInfo = @{@"VCnum": @(indexPath.row).stringValue};
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"PushVC" object:self userInfo:viewInfo];
    
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootContainer setMenuState:MFSideMenuStateClosed];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}
- (IBAction)shareButton:(id *)sender
{
    /*
    NSString*str = @"";
    
    NSURL *myWebsite = [NSURL URLWithString:@"https://play.google.com/store/apps/details?id=com.jhatpat"];
    
    NSArray *objectsToShare = @[str, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
     */
}


@end
