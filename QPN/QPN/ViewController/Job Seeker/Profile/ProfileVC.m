//
//  ProfileVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "ProfileVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "ProfileCoverDpCell.h"
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
#import "MyRecentJobsVC.h"
#import "FollowerFollowingVC.h"

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
#import "ConnectUser.h"
#import "OtherProfileVC.h"
#import "DetailPostVC.h"
#import "PostSearchVC.h"

#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]

@interface ProfileVC ()<UISearchBarDelegate,ProfileCoverDpCellDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,PostCellDelegate,AllConnectsCellDelegate,UserShortStoryCellDelegate>
{
    UIAlertController *actionSheet;
    
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(reloadUserInfo:) name:@"reloadUserInfo" object:nil];
    
    [self reloadPost:nil];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];
    [SHARED_MANAGER showWorkingSpinner:self.view text:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: YES animated:NO];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    if ([self.tabBarController.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.tabBarController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark Private - Methods
- (void) menuOption {
    actionSheet = [UIAlertController alertControllerWithTitle:@"Select" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{ }];
    }]];
    
    if (self.is_postOption == true)
    {
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(editPost:) userInfo: @"" repeats: NO];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            //        if(self.attatchedImageCount <4){
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(deletePost:) userInfo: @"" repeats: NO];
        }]];
    }
    else{
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Print my CV/Resume" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(printMyCV:) userInfo: @"" repeats: NO];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Privacy Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            //        if(self.attatchedImageCount <4){
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(privacySettings:) userInfo: @"" repeats: NO];
        }]];
    }
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void) printMyCV:(NSTimer*)theTimer {
}
- (void) privacySettings:(NSTimer*)theTimer {
    PrivacySettings*vc = [[PrivacySettings alloc] initWithNibName:@"PrivacySettings" bundle:[NSBundle mainBundle]];
    self.tabBarController.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}

- (void)addImage:(id)sender {
    
    actionSheet = [UIAlertController alertControllerWithTitle:@"Media Picker" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose Image From Camera Roll" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                       selector: @selector(SelectFromLibrary:) userInfo: @"Image" repeats: NO];
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                       selector: @selector(TakeWithCamera:) userInfo: @"Image" repeats: NO];
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
- (void)TakeWithCamera:(NSTimer*)theTimer {
    
    [[SharedPickerView getSharedInstance]  startCameraPickerFromViewController:self usingDelegate:self withSelectionType: NO];
}
- (void)SelectFromLibrary:(NSTimer*)theTimer {
    [[SharedPickerView getSharedInstance] startLibraryPickerFromViewController:self usingDelegate:self withSelectionType: NO];
}

-(void)useImage:(UIImage *)theImage {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myUniqueName;
    
    ProfileCoverDpCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (self.is_dpChanging){
        cell.dpimage.image = theImage;
        myUniqueName = [NSString stringWithFormat:@"avatar.jpg"];
    }else{
        cell.coverImage.image = theImage;
        myUniqueName = [NSString stringWithFormat:@"avatar_cover.jpg"];
    }
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:myUniqueName];
    
    NSData *imageData = UIImageJPEGRepresentation(theImage,0.5);
    [imageData writeToFile:path atomically:NO];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    
    NSString*bucket = @"qpn/images/images/000/000/002/original";
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Updating image..."];
    [[QPNAWSS3Manager getSharedInstance] uploadObject:url fileName:myUniqueName uploadBucket:bucket completionHandler:^(BOOL sucess, NSError *error) {
        if(sucess) {
            NSString*imageURL = [NSString stringWithFormat:@"https://s3-us-west-2.amazonaws.com/%@/%@",bucket,myUniqueName];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:path]){
                [fileManager removeItemAtPath:path error:nil];
            }
            [self updateUserInfo:imageURL];
        } else {
            
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:error.localizedDescription];
            
        }
    }];
}

- (void)updateUserInfo:(NSString *)imageUrl {
    
    NSDictionary *parameters = [NSDictionary dictionary];
    if (self.is_dpChanging)
    {
        parameters = @{@"user": @{@"avatar":imageUrl}};
    }
    else
    {
        parameters = @{@"user": @{@"cover_avatar":imageUrl}};
    }
    
    [AUTH_MAN updateUser:parameters parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            SHARED_MANAGER.qpnUser = nil;
            SHARED_MANAGER.qpnUser = [[QPNUser alloc]initWithDictionary:response isShortInfo:false];
        }else{
            if(error) {
                NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:errorDic[@"errors"]];
            }
        }
        
    }];
}

- (void)confirmationDPdelete {
    
    actionSheet = [UIAlertController alertControllerWithTitle:@"Are you sure you want to remove?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                       selector: @selector(removeDisplayImage) userInfo: @"Image" repeats: NO];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)confirmationCoverDelete {
    
    actionSheet = [UIAlertController alertControllerWithTitle:@"Are you sure you want to remove?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                       selector: @selector(removeCoverImage) userInfo: @"Image" repeats: NO];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)removeDisplayImage {
    
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Loading..."];
    
    [AUTH_MAN deleteDPImage:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            SHARED_MANAGER.qpnUser = nil;
            SHARED_MANAGER.qpnUser = [[QPNUser alloc]initWithDictionary:response isShortInfo:false];
            [self.tableView reloadData];
        }else{
            if(error) {
                NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:errorDic[@"errors"]];
            }
        }
    }];
    
}
- (void)removeCoverImage {
    
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Loading..."];
    [AUTH_MAN deleteCoverImage:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            SHARED_MANAGER.qpnUser = nil;
            SHARED_MANAGER.qpnUser = [[QPNUser alloc]initWithDictionary:response isShortInfo:false];
            [self.tableView reloadData];
        }else{
            if(error) {
                NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:errorDic[@"errors"]];
            }
        }
    }];
    
}

#pragma mark - Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5-1;
    }
    else
    {
        NSLog(@"%lu",(unsigned long)SHARED_MANAGER.QPNPostArray.count);
        return SHARED_MANAGER.QPNPostArray.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    if (indexPath.section == 0)
    {
        if (indexPath.row ==0)
        {
            return 466;
        }
        else if(indexPath.row == 1)
        {
            return 223.0;
        }
        /*else if(indexPath.row == 2)
        {
            return 198.0;
        }*/
        else if(indexPath.row == 2)

        {
            if (SHARED_MANAGER.qpnUser.connects.count == 0)
            {
                return 87.0 - 40.0; // 87.0 is height with out collectionView 40.0 is seeAll
            }
            else if (SHARED_MANAGER.qpnUser.connects.count > 3)
            {
                return 87.0 + ((screenWidth/3.0)+ 15)*2;
            }
            else
            {
                return 87.0 + ((screenWidth/3.0)+ 15);
            }
        }
        else
        {
             return 72.0;
        }
    }
    else
    {
        if (SHARED_MANAGER.QPNPostArray.count > 0)
        {
            QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:indexPath.row];
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
            NSString * resuseID = @"ProfileCoverDpCell";
            ProfileCoverDpCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileCoverDpCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            [cell populateCell];
            cell.userName.text = SHARED_MANAGER.qpnUser.first_name;
            
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            attachment.image = [UIImage imageNamed:@"star"];
            
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
            
            NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@""];

            for(int i=0;i<SHARED_MANAGER.qpnUser.rating.intValue;i++) {
                [myString appendAttributedString:attachmentString];
                [myString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
            }
            cell.star.attributedText = myString;
            if(SHARED_MANAGER.qpnUser.careerObjective.length == 0) {
                cell.careerObjectiveLbl.text = @"Click here to add objective.";
            } else {
                cell.careerObjectiveLbl.text = SHARED_MANAGER.qpnUser.careerObjective;
            }
            if (SHARED_MANAGER.qpnUser.avatar_file_name)
            {
                [cell.dpimage sd_setImageWithURL:[NSURL URLWithString:SHARED_MANAGER.qpnUser.avatar_file_name]
                                   placeholderImage:[UIImage imageNamed:@"boy"]
                                          completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              
                                              if(image){
                                                  
                                              }else{
                                              }
                                          }];
            }
            if (SHARED_MANAGER.qpnUser.cover_avatar_file_name)
            {
                [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:SHARED_MANAGER.qpnUser.cover_avatar_file_name]
                                placeholderImage:[UIImage imageNamed:@"boy"]
                                       completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           
                                           if(image){
                                               
                                           }else{
                                           }
                                       }];
            }
            
            cell.profileDelegate =  self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (indexPath.row == 1) {
            NSString * reuseID = @"UserShortInfoell";
            
            UserShortInfoell * cell;

            cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if (!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserShortInfoell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell populateCellWithUserInfo];
            return cell;
        }/*
        else if (indexPath.row == 2) {
            NSString * reuseID = @"UserShortStoryCell";
            
            UserShortStoryCell * cell;
            
            cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if (!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserShortStoryCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.shortStoryCellDelegate = self;
            return cell;
        }*/
        else if (indexPath.row == 2) {
            {
                NSString * reuseID = @"AllConnectsCell";
                
                AllConnectsCell * cell;
                
                cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
                if (!cell)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllConnectsCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                    cell.backgroundColor = [UIColor clearColor];
                    
                    cell.connectsArray = SHARED_MANAGER.qpnUser.connects;
                    [cell populateConnectData];
                    
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                return cell;
            }
        }
        else {
            NSString * resuseID = @"AddPostCell";
            AddPostCell * cell = [tableView dequeueReusableCellWithIdentifier:resuseID];

            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddPostCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

            }
            [cell.dp sd_setImageWithURL:[NSURL URLWithString:SHARED_MANAGER.qpnUser.avatar_file_name] placeholderImage:[UIImage imageNamed:@"boy"]
                              completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {}];
            return cell;

        }
    }
    else if (indexPath.section == 1)
    {
        QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:indexPath.row];
        
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
            [cell populateData:NO];
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
            [cell populateData:NO];
            return cell;
        }
    }
    return  nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:(int)indexPath.row];
        
        DetailPostVC * vc;
        vc = [[DetailPostVC alloc] initWithNibName:@"DetailPostVC" bundle:[NSBundle mainBundle]];
        vc.post = qpnPost;
        self.navigationController.navigationBar.hidden = YES;
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        AddPostVC*vc = [[AddPostVC alloc] initWithNibName:@"AddPostVC" bundle:[NSBundle mainBundle]];
        self.tabBarController.navigationController.navigationBar.hidden = YES;
        [self.tabBarController.navigationController pushViewController:vc animated:YES];

    }
    else {
       
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

-(void) editPost:(NSTimer*)theTimer
{
//    SharePostVC*vc = [[SharePostVC alloc] initWithNibName:@"SharePostVC" bundle:[NSBundle mainBundle]];
//    self.tabBarController.navigationController.navigationBar.hidden = YES;
//    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}
-(void) deletePost:(NSTimer*)theTimer
{
//    SharePostVC*vc = [[SharePostVC alloc] initWithNibName:@"SharePostVC" bundle:[NSBundle mainBundle]];
//    self.tabBarController.navigationController.navigationBar.hidden = YES;
//    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}

#pragma -mark ProfileCoverDpCellDelegate
-(void) onAboutBtn:(id) sender
{
    AboutUserVC*vc = [[AboutUserVC alloc] initWithNibName:@"AboutUserVC" bundle:[NSBundle mainBundle]];
    self.tabBarController.navigationController.navigationBar.hidden = YES;
    SHARED_MANAGER.userDataCat =  UserAllData;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void) onMyJobBtn:(id) sender
{
    MyRecentJobsVC *vc = [[MyRecentJobsVC alloc] initWithNibName:@"MyRecentJobsVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
   
}
-(void) onInboxBtn:(id) sender
{
    AddPostVC*vc = [[AddPostVC alloc] initWithNibName:@"AddPostVC" bundle:[NSBundle mainBundle]];
    self.tabBarController.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}
-(void) onMenuBtn:(id) sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Resume"
                                                                   message:[NSString stringWithFormat:@"Are you sure you want to email your resume at %@?",SHARED_MANAGER.qpnUser.email]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [AUTH_MAN getResume:nil parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            if(response[@"status"]) {
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:@"You resume has been emailed."];
            }

        }];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}
- (void) onChangeDpBtn:(id)sender {
    
    if(SHARED_MANAGER.qpnUser.isDPExist) {
        actionSheet = [UIAlertController alertControllerWithTitle:@"Media Picker" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove Display Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
           
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(confirmationDPdelete) userInfo: @"Image" repeats: NO];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Change Display Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.is_dpChanging = true;
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(addImage:) userInfo: @"Image" repeats: NO];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
//        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Preview Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [self.navigationController setNavigationBarHidden: NO animated:NO];
//            [SHARED_MANAGER_PREVIEW viewPhotos:@[SHARED_MANAGER.qpnUser.avatar_file_name] withController:self withIndex:0];
//
//            
//            [self dismissViewControllerAnimated:YES completion:^{
//            }];
//        }]];
        
        // Present action sheet.
        [self presentViewController:actionSheet animated:YES completion:nil];
    } else {
        self.is_dpChanging = true;
        [self addImage:sender];
    }
}
- (void) onChangeCoverBtn:(id)sender {
    
    if(SHARED_MANAGER.qpnUser.isCoverExist) {
        actionSheet = [UIAlertController alertControllerWithTitle:@"Media Picker" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove Cover Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
          
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(confirmationCoverDelete) userInfo: @"Image" repeats: NO];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Change Cover Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.is_dpChanging = false;
            [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(addImage:) userInfo: @"Image" repeats: NO];
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
//        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Preview Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            
//            [self.navigationController setNavigationBarHidden: NO animated:NO];
//            [SHARED_MANAGER_PREVIEW viewPhotos:@[SHARED_MANAGER.qpnUser.cover_avatar_file_name] withController:self withIndex:0];
//            [self dismissViewControllerAnimated:YES completion:^{
//            }];
//        }]];
        
        
        [self presentViewController:actionSheet animated:YES completion:nil];
    } else {
        self.is_dpChanging = false;
        [self addImage:sender];
    }
}

- (void)onObjectiveClick:(id)sender {
    ObjectiveInfoVC *vc = [[ObjectiveInfoVC alloc] initWithNibName:@"ObjectiveInfoVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)reloadUserInfo:(NSNotification*)notification {
    [self.tableView reloadData];
}
- (void)reloadPost:(NSNotification*)notification{
    
    [AUTH_MAN getTimelinePost:nil parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        
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

#pragma mark ImagePickerDelegates
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker  dismissViewControllerAnimated:YES completion:nil];
    self.navigationController.navigationBarHidden = YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info  {
    self.navigationController.navigationBarHidden = YES;
    __block UIImage * img;
    img= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self useImage:img];
    
    
}

#pragma -mark connects Delegates
- (void)connectPressed:(NSIndexPath*)indexPath {
    
    ConnectUser *user = [SHARED_MANAGER.qpnUser.connects objectAtIndex:indexPath.row];
    OtherProfileVC * vc = [[OtherProfileVC alloc] initWithNibName:@"OtherProfileVC" bundle:[NSBundle mainBundle]];
    vc.userId = [user.userId stringValue];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)seeAllConnects {
    FollowerFollowingVC *vc =  [[FollowerFollowingVC alloc] initWithNibName:@"FollowerFollowingVC" bundle:[NSBundle mainBundle]];
    vc.userId = [SHARED_MANAGER.qpnUser.userId stringValue];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma -mark Shor Story Video Delegate
-(void)addVideo {

}

- (void)playVideo {
    
    if(SHARED_MANAGER.qpnUser.video.length != 0){
        [[QPNSharedPreview getSharedInstance] viewVideo:@[SHARED_MANAGER.qpnUser.video] withController:self];
    }
}

#pragma mark search Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    PostSearchVC*vc = [[PostSearchVC alloc] initWithNibName:@"PostSearchVC" bundle:[NSBundle mainBundle]];
    self.tabBarController.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
    vc.serchText = searchBar.text;
    [self.view endEditing:YES];
    searchBar.text = @"";
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}


- (void)onLikeBtn:(id) sender cellIndex:(NSIndexPath*) index{
    
    QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex: (index.row )];
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
                [SHARED_MANAGER.QPNPostArray replaceObjectAtIndex:(index.row) withObject:qpnPost];
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
                [SHARED_MANAGER.QPNPostArray replaceObjectAtIndex:(index.row) withObject:qpnPost];
                [self.tableView reloadData];
            }
        }];
    }
}
- (void)onCommentBtn:(id) sender cellIndex:(NSIndexPath*) index{
    QPNPost * qpnPost = [SHARED_MANAGER.QPNPostArray objectAtIndex:(int)index.row];
    
    DetailPostVC * vc;
    vc = [[DetailPostVC alloc] initWithNibName:@"DetailPostVC" bundle:[NSBundle mainBundle]];
    vc.post = qpnPost;
    self.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
    
}
- (void)onMoreBtn:(id) sender cellIndex:(NSIndexPath*) index{
    [self postOption:index];
}
#pragma matk- action Sheet
-(void)postOption:(NSIndexPath*)index
{
    self.editdeletePostIndex = (int)index.row;
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

@end
