//
//  OtherProfileVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "OtherProfileVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "OtherProfileCoverDpCell.h"
#import "UserShortInfoell.h"
#import "AllConnectsCell.h"
#import "UserShortStoryCell.h"
#import "UserBioDataVC.h"
#import "UIView+Toast.h"
#import "AddPostCell.h"
#import "PostCell.h"
#import "AddPostVC.h"
#import "UserBioDataVC.h"
#import "SharePostVC.h"
#import "AboutUserVC.h"
#import "PrivacySettings.h"
#import "FollowerFollowingVC.h"
#import "MyRecentJobsVC.h"
#import "DetailPostVC.h"

#import "QPNPost.h"
#import "QPNUser.h"

#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "QPNAWSS3Manager.h"
#import "SharedPickerView.h"
#import "ObjectiveInfoVC.h"
#import "QPNAuthorizationManager+UserInfo.h"
#import "QPNSharedPreview.h"
#import "AboutOtherUserVC.h"


#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]

@interface OtherProfileVC ()<UISearchBarDelegate,OtherProfileCoverDpCellDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,PostCellDelegate,AllConnectsCellDelegate,UserShortStoryCellDelegate>
{
    UIAlertController *actionSheet;
    
}
@property (strong,nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) QPNUser *otherUser;
@property (strong,nonatomic) NSMutableArray * QPNPostArray;
@property (readwrite,nonatomic) int numberOfRows;
@property (readwrite,nonatomic) int numberOfSection;

@end

@implementation OtherProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(reloadUserInfo:) name:@"reloadUserInfo" object:nil];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Waiting..."];
    [self getUser];
    self.QPNPostArray = [NSMutableArray array];
}
- (void)viewDidDisappear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
#pragma mark Private - Methods
- (void)getUser {
    
    [AUTH_MAN otherUser:self.userId parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        self.otherUser = [[QPNUser alloc] initWithDictionary:response isShortInfo:false];
        self.userTitle.text = self.otherUser.first_name;

        if ([self.otherUser.following isEqualToString:@"Follow"] || [self.otherUser.following isEqualToString:@"Requested"]) {
            self.numberOfRows = 1;
            self.numberOfSection = 1;
            [self.tableView reloadData];
        } else if ([self.otherUser.following isEqualToString:@"Unfollow"]) {
            self.numberOfRows = 2;
            self.numberOfSection = 2;
            [self reloadPost:nil];
        }
    }];
}


#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return _numberOfRows;
    }else{
        return self.QPNPostArray.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _numberOfSection;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    if (indexPath.section == 0)
    {
        if (indexPath.row ==0)
        {
            return 362.0;
        }
        else if(indexPath.row == 1)

        {
            if (self.otherUser.connects.count == 0)
            {
                return 79.0 - 40.0;
            }
            else if (self.otherUser.connects.count > 3)
            {
                return 79.0 + ((screenWidth/3.0)+ 15)*2;
            }
            else
            {
                return 79.0 + ((screenWidth/3.0)+ 15);
            }
        }
    }
    else
    {
        
        if (self.QPNPostArray.count > 0) {
            QPNPost * qpnPost = [self.QPNPostArray objectAtIndex:indexPath.row];
                
            float height = [SHARED_MANAGER postTextViewHeightForAttributedText:qpnPost.text andWidth:screenWidth - 17.0 heightWithoutText:0.0];
                
            if(qpnPost.comment.text.length != 0 )
            {
                height = height + 71; // 71 comment container Height
            }
            
            if (qpnPost.image.length == 0)
            {
                // total cell height 160
                // height without text = 135.5
                
                return 135.5 + height;
            }
            // total cell height 309.0
            // height without text = 283.0
                
            return 283.0 + height;
                
        }
        else{
            return 0.0;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            NSString * resuseID = @"OtherProfileCoverDpCell";
            OtherProfileCoverDpCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OtherProfileCoverDpCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            [cell populateCell:self.otherUser];
            cell.userName.text = self.otherUser.first_name;
            
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            attachment.image = [UIImage imageNamed:@"star"];
            
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
            
            NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@""];

            for(int i=0;i<self.otherUser.rating.intValue;i++) {
                [myString appendAttributedString:attachmentString];
                [myString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
            }
            cell.star.attributedText = myString;
            
            if (self.otherUser.avatar_file_name)
            {
                [cell.dpimage sd_setImageWithURL:[NSURL URLWithString:self.otherUser.avatar_file_name]
                                   placeholderImage:[UIImage imageNamed:@"boy"]
                                          completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                          }];
            }
            if (self.otherUser.cover_avatar_file_name)
            {
                [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:self.otherUser.cover_avatar_file_name]
                                placeholderImage:[UIImage imageNamed:@"boy"]
                                       completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           }];
            }
            
            cell.profileDelegate =  self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 1) {
                NSString * reuseID = @"AllConnectsCell";
                
                AllConnectsCell * cell;
                
                cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
                if (!cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllConnectsCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                    cell.backgroundColor = [UIColor clearColor];
                    
                    cell.connectsArray = self.otherUser.connects;
                    [cell populateConnectData];
                    
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        QPNPost * qpnPost = [self.QPNPostArray objectAtIndex:indexPath.row];
        
        if (qpnPost.image.length == 0)
        {
            NSString * reuseID = @"postCell";
            
            PostCell * cell;
            
            cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if (!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PostCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.postCellDelegate = self;
            cell.moreBtn.hidden = YES;
            
            cell.post = qpnPost;
            cell.index = indexPath;
            cell.postCellDelegate = self;
            [cell populateData:YES];
            
            
            
            return cell;
        }
        else
        {
            NSString * reuseID = @"mediaPostCell";
            
            PostCell * cell;
            
            cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if (!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MediaPostCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.moreBtn.hidden = YES;
            cell.postCellDelegate = self;
            
            cell.post = qpnPost;
            cell.index = indexPath;
            cell.postCellDelegate = self;
            [cell populateData:YES];
        
            return cell;
        }
    }
    return  nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark ProfileCoverDpCellDelegate
- (void)onAboutBtn:(id) sender
{
    AboutOtherUserVC*vc = [[AboutOtherUserVC alloc] initWithNibName:@"AboutOtherUserVC" bundle:[NSBundle mainBundle]];
    self.navigationController.navigationBar.hidden = YES;
    vc.otherUser = self.otherUser;
    SHARED_MANAGER.userDataCat =  UserAllData;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reloadUserInfo:(NSNotification*)notification {
    [self getUser];
}
- (void)reloadPost:(NSNotification*)notification{
    
    [AUTH_MAN getOtherPost:[self.otherUser.userId stringValue] parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        
        if(response) {
            
            [self.QPNPostArray removeAllObjects];
            
            for (NSDictionary * dic in response) {
                
                QPNPost * qpnPost = [[QPNPost alloc] initWithDictionary:dic];
                [self.QPNPostArray addObject:qpnPost];
            }
            
            [self.tableView reloadData];
            
        }
        
    }];
}
- (IBAction)onBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)onLikeBtn:(id) sender cellIndex:(NSIndexPath*) index{
    
    QPNPost * qpnPost = [self.QPNPostArray objectAtIndex:index.row];
    NSString* postID = qpnPost.post_id;
    if (qpnPost.is_liked_by_me && qpnPost.no_of_likes.intValue > 0)
    {
        qpnPost.is_liked_by_me = NO;
        [AUTH_MAN unlikePost: postID parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            if (response[@"success"])
            {
                qpnPost.is_liked_by_me = NO;
                qpnPost.no_of_likes = response[@"no_of_likes"];
                [self.QPNPostArray replaceObjectAtIndex:(index.row) withObject:qpnPost];
                [self.tableView reloadData];
            }
            
        }];
    }
    else
    {
        qpnPost.is_liked_by_me = YES;
        [AUTH_MAN likePost: postID parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            if (response[@"success"])
            {
                qpnPost.is_liked_by_me = YES;
                qpnPost.no_of_likes = response[@"no_of_likes"];
                [self.QPNPostArray replaceObjectAtIndex:(index.row) withObject:qpnPost];
                [self.tableView reloadData];
            }
        }];
    }
}
- (void)onCommentBtn:(id) sender cellIndex:(NSIndexPath*) index{
    QPNPost * qpnPost = [self.QPNPostArray objectAtIndex:(int)index.row];
    DetailPostVC * vc;
    vc = [[DetailPostVC alloc] initWithNibName:@"DetailPostVC" bundle:[NSBundle mainBundle]];
    vc.post = qpnPost;
    self.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}
- (void)seeAllConnects {
    FollowerFollowingVC *vc =  [[FollowerFollowingVC alloc] initWithNibName:@"FollowerFollowingVC" bundle:[NSBundle mainBundle]];
    vc.userId = [self.otherUser.userId stringValue];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
