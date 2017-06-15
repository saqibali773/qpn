//
//  MyApplicationVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "LiveFeedVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "PostCell.h"
#import "AddPostCell.h"
#import "UIView+Toast.h"
#import "QPNPost.h"
#import "AddPostVC.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "DetailPostVC.h"
#import "PostSearchVC.h"
#import "OtherProfileVC.h"

#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]

@interface LiveFeedVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,PostCellDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIAlertController *actionSheet;
}
@property (nonatomic, strong) UIRefreshControl * tableRefreshTop;

@end

@implementation LiveFeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(reloadPost:) name:@"reloadPost" object:nil]; //// pull to referesh
    self.tableRefreshTop = [[UIRefreshControl alloc] init];
    CGAffineTransform transform = CGAffineTransformMakeScale(0.75f, 0.75f);
    self.tableRefreshTop.transform = transform;
    
    self.tableView.refreshControl = self.tableRefreshTop;
    [self.tableRefreshTop addTarget:self action:@selector(loadMorePosts:) forControlEvents:UIControlEventValueChanged];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];

    
}
- (void)viewDidAppear:(BOOL)animated {
    [self reloadPost:nil];
    if ([self.tabBarController.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.tabBarController.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
    }
    
}
-(void)loadMorePosts:(id)sender{
    [self reloadPost:nil];
}
#pragma search delegates
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    PostSearchVC*vc = [[PostSearchVC alloc] initWithNibName:@"PostSearchVC" bundle:[NSBundle mainBundle]];
    self.tabBarController.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
    vc.serchText = searchBar.text;
    [self.view endEditing:YES];
    searchBar.text = @"";
    self.searchBar.showsCancelButton = NO;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (SHARED_MANAGER.QPNPostArray.count==0)
    {
        return 1;
    }
    return SHARED_MANAGER.QPNPostArray.count +1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    if (indexPath.row == 0) {
        return 72.0;
    }
    else
    {
        if (SHARED_MANAGER.QPNPostArray.count > 0)
        {
            QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:indexPath.row-1];
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
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSString * resuseID = @"AddPostCell";
        AddPostCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddPostCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.dp sd_setImageWithURL:[NSURL URLWithString:SHARED_MANAGER.qpnUser.avatar_file_name]
               placeholderImage:[UIImage imageNamed:@"boy"]
                      completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                      
                      }];
        return cell;
    }
    else
    {
    
    QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:indexPath.row -1 ];
    
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
        
        cell.index = indexPath;
        cell.post = qpnPost;
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
        
        cell.post = qpnPost;
        cell.index = indexPath;
        cell.postCellDelegate = self;
        [cell populateData:YES];
        return cell;
    }
}
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0)
    {
        AddPostVC*vc = [[AddPostVC alloc] initWithNibName:@"AddPostVC" bundle:[NSBundle mainBundle]];
        self.tabBarController.navigationController.navigationBar.hidden = YES;
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:(int)indexPath.row-1];
        
        DetailPostVC * vc;
        vc = [[DetailPostVC alloc] initWithNibName:@"DetailPostVC" bundle:[NSBundle mainBundle]];
        vc.post = qpnPost;
        self.navigationController.navigationBar.hidden = YES;
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMenuClick:(id)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootContainer toggleLeftSideMenuCompletion:nil];

    
}
#pragma matk- action Sheet
-(void)postOption:(NSIndexPath*)index
{
    self.editdeletePostIndex = (int)index.row - 1;
    actionSheet = [UIAlertController alertControllerWithTitle:@"Select" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{ }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                       selector: @selector(editPost) userInfo: @"" repeats: NO];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //        if(self.attatchedImageCount <4){
        [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                       selector: @selector(deletePost) userInfo: @"" repeats: NO];
    }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

}
- (void) onSeeMoreBtn:(id) sender cellIndex:(NSIndexPath*) index
{
//     QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:(int)index.row-1];
//    
//    DetailPostVC * vc;
//    vc = [[DetailPostVC alloc] initWithNibName:@"DetailPostVC" bundle:[NSBundle mainBundle]];
//    vc.post = qpnPost;
//    self.navigationController.navigationBar.hidden = YES;
//    [self.tabBarController.navigationController pushViewController:vc animated:YES];
    
}
- (void)onLikeBtn:(id) sender cellIndex:(NSIndexPath*) index{
    
     QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex: (index.row - 1)];
     NSString* postID = qpnPost.post_id;
    if (qpnPost.is_liked_by_me && qpnPost.no_of_likes.intValue > 0)
    {
        qpnPost.is_liked_by_me = NO;
        [AUTH_MAN unlikePost: postID parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            if (response[@"success"])
            {
                
                qpnPost.no_of_likes = response[@"no_of_likes"];
                [SHARED_MANAGER.QPNPostArray replaceObjectAtIndex:(index.row - 1) withObject:qpnPost];
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
                qpnPost.no_of_likes = response[@"no_of_likes"];
                [SHARED_MANAGER.QPNPostArray replaceObjectAtIndex:(index.row - 1) withObject:qpnPost];
                [self.tableView reloadData];
            }
        }];
    }
    
   
}
- (void)onCommentBtn:(id) sender cellIndex:(NSIndexPath*) index{
    QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:(int)index.row-1];
    
    DetailPostVC * vc;
    vc = [[DetailPostVC alloc] initWithNibName:@"DetailPostVC" bundle:[NSBundle mainBundle]];
    vc.post = qpnPost;
    self.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
    
}
- (void)onMoreBtn:(id) sender cellIndex:(NSIndexPath*) index{
    [self postOption:index];
}
- (void)onUserClick:(id)sender cellIndex:(NSIndexPath *)index {

    QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:(int)index.row-1];

    OtherProfileVC * vc = [[OtherProfileVC alloc] initWithNibName:@"OtherProfileVC" bundle:[NSBundle mainBundle]];
    vc.userId = [qpnPost.qpnUser.userId stringValue];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)reloadPost:(NSNotification*)notification{
    
    [AUTH_MAN getNewsFeedPost:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        [self.tableRefreshTop endRefreshing];
        
        if(response) {
            
            [SHARED_MANAGER.QPNPostArray removeAllObjects];
            
            for (NSDictionary * dic in response) {
                
                QPNPost * qpnPost = [[QPNPost alloc] initWithDictionary:dic];
                [SHARED_MANAGER.QPNPostArray addObject:qpnPost];
            }
            
            [self.tableView reloadData];
        }
    }];
    
}

- (void)editPost{
    
    AddPostVC*vc = [[AddPostVC alloc] initWithNibName:@"AddPostVC" bundle:[NSBundle mainBundle]];
    vc.isEditing = YES;
    vc.postObj = [SHARED_MANAGER.QPNPostArray objectAtIndex:self.editdeletePostIndex];
    
    self.tabBarController.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];

}
- (void)deletePost {
    
    QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:self.editdeletePostIndex];
    
    NSString* postID = qpnPost.post_id;
    
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
    [AUTH_MAN deletePost: postID parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        [SHARED_MANAGER.QPNPostArray removeObjectAtIndex:self.editdeletePostIndex];
        [self.tableView reloadData];
    }];
    
}


// helper


@end
