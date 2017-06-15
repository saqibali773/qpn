//
//  DetailPostVC.m
//  QPN
//
//  Created by Muhammad Usman on 14/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "DetailPostVC.h"
#import "PostCell.h"
#import "PostCommentCell.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"
#import "QPNSharedPreview.h"

@interface DetailPostVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,PostCellDelegate>
{
    UIAlertController *actionSheet;
    CGFloat keyBoradHeight;
}

@end

@implementation DetailPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentsArray = [NSMutableArray array];
    [self getAllComments];
}
- (void)viewDidAppear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bakBtnPressed:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getAllComments
{
    NSString* postID = _post.post_id;
    
    [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
    [AUTH_MAN getAllCommets: postID parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        
        [self.commentsArray removeAllObjects];
        for (NSDictionary * dic in response) {
            
            QPNPostComment* qpnPostComment = [[QPNPostComment alloc] initWithDictionary:dic];
            [self.commentsArray addObject:qpnPostComment];
        }
        [self.tableView reloadData];
    }];
}
- (IBAction)sendBtnPressed:(UIButton *)sender {
    
    if (self.commentTF.text.length>0) {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
        [AUTH_MAN addCommentOnPost:_post.post_id params:@{@"body":self.commentTF.text} parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            
            if(response) {
                
                QPNPostComment * commentObj = [[QPNPostComment alloc] initWithDictionary:response];
                [self.commentsArray insertObject:commentObj atIndex:0];
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
    else
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"can't send emply comment"];
    }
    
    self.commentTF.text = @"";
    [self.view endEditing: YES];
    
}
#pragma mark -keyBoardDelegate
- (void)registerForKeyboardNotifications
{
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPostComment) name:@"MessageRecieved" object:nil
    //     ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.bottomView.transform = CGAffineTransformMakeTranslation(0.0,-kbSize.height);
    [self.view bringSubviewToFront:self.bottomView];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.bottomView.transform = CGAffineTransformMakeTranslation(0.0,0.0);
    //    self.tableview.frame = CGRectMake(0.0, self.tableview.frame.origin.y,self.tableview.frame.size.width,TABLEVIEWHEIGHT);
}


#pragma mark - Table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            
        default:
            return self.commentsArray.count;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    switch (indexPath.section) {
        case 0:
        {
            if (_post) {
                float height = [self postTextViewHeightForAttributedText:_post.text andWidth:screenWidth - 17.0 heightWithoutText:0.0];
                
                if (_post.image.length == 0)
                {
                    // total cell height 160
                    // height without text = 135.5
                    
                    return 135.5 + height;
                }
                // total cell height 309.0
                // height without text = 283.0
                
                return 283.0 + height;
            }
        }
            break;
        case 1:
        {
            QPNPostComment * comment = [self.commentsArray objectAtIndex:indexPath.row];
           
            float height = [self postTextViewHeightForAttributedText:comment.text andWidth:screenWidth - 17.0 heightWithoutText:0.0];
            
            // total cell height 120
            // height without text = 24.0
            
            return 96.0 + height;
        }
            break;
            
        default:
            return 0.0;
            break;
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (_post.image.length == 0)
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
                cell.isDetailPost = true;
                cell.post = _post;
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
                
                cell.post = _post;
                cell.index = indexPath;
                cell.isDetailPost = true;
                cell.postCellDelegate = self;
                [cell populateData:YES];
                return cell;
            }
        }
            break;
        case 1:
        {
            PostCommentCell * cell;
            NSString * reuseID = @"PostCommentCell";
            cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if (!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PostCommentCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
             QPNPostComment * comment = [self.commentsArray objectAtIndex:indexPath.row];
            cell.commentPost =  comment;
            [cell populateData];
            return cell;

        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma post cell Delegate Methods
- (void)onLikeBtn:(id) sender cellIndex:(NSIndexPath*) index{
    
    QPNPost * qpnPost = self.post;//[SHARED_MANAGER.QPNPostArray objectAtIndex: (index.row)];
    NSString* postID = qpnPost.post_id;
    if (qpnPost.is_liked_by_me && qpnPost.no_of_likes.intValue > 0)
    {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
        [AUTH_MAN unlikePost: postID parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            if (response[@"success"])
            {
                qpnPost.is_liked_by_me = NO;
                qpnPost.no_of_likes = response[@"no_of_likes"];
                self.post = qpnPost;
                [self.tableView reloadData];
            }
            
        }];
    }
    else
    {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"waiting..."];
        [AUTH_MAN likePost: postID parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            if (response[@"success"])
            {
                qpnPost.is_liked_by_me = YES;
                qpnPost.no_of_likes = response[@"no_of_likes"];
                self.post = qpnPost;
                [self.tableView reloadData];
            }
        }];
    }
    

}
- (void)onImageClick:(id)sender cellIndex:(NSIndexPath *)index {
    
    
//    [self.navigationController setNavigationBarHidden: NO animated:NO];
//    [SHARED_MANAGER_PREVIEW viewPhotos:@[self.post.image] withController:self withIndex:0];

}


- (CGFloat)postTextViewHeightForAttributedText:(NSString*)text andWidth:(CGFloat)width heightWithoutText:(float)h {
    
    UITextView *calculationView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 0.0)];
    calculationView.font = [UIFont systemFontOfSize:13];
    calculationView.text = text;
    [calculationView sizeToFit];
    if(text.length > 0) {
        h = h + calculationView.frame.size.height;
        return h;
    }
    else {
        return h;
    }
}

@end
