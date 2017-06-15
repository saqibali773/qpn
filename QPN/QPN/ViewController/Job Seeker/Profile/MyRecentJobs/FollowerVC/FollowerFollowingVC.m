//
//  MyRecentJobsVC.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//
#import <AVFoundation/AVFoundation.h>
#import "FollowerFollowingVC.h"
#import "MyRecentJobsCell.h"
#import "QPNAuthorizationManager+Jobs.h"
#import "QPNAuthorizationManager.h"
#import "AppliedJobDetailVC.h"
#import "JobsRecommendedCell.h"
#import "RecommendedJobDetailVC.h"
#import "Job.h"
#import "OtherProfileVC.h"
#import "QPNAuthorizationManager+UserInfo.h"
#import "SearchUserCell.h"
typedef enum : NSUInteger {
    UserTypeFollower,
    UserTypeFollowing
} UserType;

#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]
@interface FollowerFollowingVC ()<UITextViewDelegate> {
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (nonatomic,strong) NSArray *followers;
@property (nonatomic,strong) NSArray *followings;
@property (nonatomic,readwrite) UserType selectedType;

@end


@implementation FollowerFollowingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getUsersFollowers];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated {
}


#pragma mark Custom Methods
- (IBAction)controlSegmentClicked:(id)sender {
    UISegmentedControl *control = (UISegmentedControl*)sender;
    
    self.selectedType = control.selectedSegmentIndex;
    
    int count = 0;
    
    switch (self.selectedType) {
            case UserTypeFollower: {
                count = (int)self.followers.count;
            }
            break;
            case UserTypeFollowing: {
                count = (int)self.followings.count;
            }
            break;
            
        default:
            break;
    }
    
    
    if(count == 0) {
        self.tableView.hidden = YES;
    } else {
        self.tableView.hidden = NO;
    }
    [self.tableView reloadData];
}

- (IBAction)backBtnClicked:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark Private Jobs

- (void)getUsersFollowers {
    
    [AUTH_MAN getFollowersFollowing:self.userId parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        NSArray *responses = (NSArray*)response;
        if (responses.count > 0) {
            
            NSDictionary * follower = [responses objectAtIndex:0];
            if (follower[@"followers"]) {
                [self populateFollwerArray:follower[@"followers"]];
            }
            else
            {
                [self populateFollwingArray:follower[@"following"]];
            }
            
            
            if (responses.count >1) {
                
                NSDictionary * follower = [responses objectAtIndex:1];
                
                if (follower[@"followers"]) {
                    [self populateFollwerArray:follower[@"followers"]];
                }
                else
                {
                    [self populateFollwingArray:follower[@"following"]];
                }
            }
        }

        [self.tableView reloadData];
    }];
    
}

- (void)populateFollwerArray :(NSArray *)follower {

    NSMutableArray *followers = [NSMutableArray array];
    
    for (NSDictionary * userDic in  follower) {
        
        QPNUser * userObj = [[QPNUser alloc] initWithDictionary:userDic isShortInfo:YES];
        [followers addObject:userObj];
    }
    self.followers = followers;
}

- (void)populateFollwingArray :(NSArray *)following {
    
    NSMutableArray *followings = [NSMutableArray array];
    
    for (NSDictionary * userDic in following) {
        
        QPNUser * userObj = [[QPNUser alloc] initWithDictionary:userDic isShortInfo:YES];
        [followings addObject:userObj];
    }
    self.followings = followings;
}



#pragma -mark TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    switch (self.selectedType) {
            case UserTypeFollower: {
               return self.followers.count;
            }
            break;
            case UserTypeFollowing: {
                return self.followings.count;
            }
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    switch (self.selectedType) {
            case UserTypeFollower: {
                return 100.0;
            }
            break;
            case UserTypeFollowing: {
                return 100.0;
            }
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.selectedType) {
            case UserTypeFollower: {
                QPNUser *userObj = self.followers[indexPath.row];
                NSString * resuseID = @"SearchUserCell";
                SearchUserCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
                
                if(!cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchUserCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
                cell.userObj = userObj;
                [cell populateData];
                
                return cell;

            }
            break;
            case UserTypeFollowing: {
                QPNUser *userObj = self.followings[indexPath.row];
                NSString * resuseID = @"SearchUserCell";
                SearchUserCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
                
                if(!cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchUserCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                }
                cell.userObj = userObj;
                [cell populateData];
                
                return cell;
            }
            break;
        default:
            break;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (self.selectedType) {
        case UserTypeFollower: {
            QPNUser *userObj = self.followers[indexPath.row];
            OtherProfileVC * vc = [[OtherProfileVC alloc] initWithNibName:@"OtherProfileVC" bundle:[NSBundle mainBundle]];
            vc.userId = [userObj.userId stringValue];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case UserTypeFollowing: {
            QPNUser *userObj = self.followings[indexPath.row];
            OtherProfileVC * vc = [[OtherProfileVC alloc] initWithNibName:@"OtherProfileVC" bundle:[NSBundle mainBundle]];
            vc.userId = [userObj.userId stringValue];
            [self.navigationController pushViewController:vc animated:YES];
      
        }
            break;
        default:
            break;
    }

}

@end


