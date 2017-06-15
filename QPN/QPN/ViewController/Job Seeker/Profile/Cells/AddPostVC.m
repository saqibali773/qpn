    //
//  AddPostVC.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "SharedPickerView.h"
#import "UIView+Toast.h"
#import "AddPostVC.h"
#import "AppDelegate.h"
#import "GTAuthorizationManager.h"
#import "GTSharedData.h"
#import "GTAWSS3Manager.h"
#import "QPNPost.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"

#define AUTH_MAN [GTAuthorizationManager getSharedInstance]


@interface AddPostVC ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    BOOL isLocationFetchedOnce;
    CGFloat keyBoradHeight;
    NSURL *postVideoURL;
}

@property (nonatomic) BOOL isCounteryAdded;

@end

@implementation AddPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.userName.text = [NSString stringWithFormat:@"Mr. %@",SHARED_MANAGER.qpnUser.first_name];
    
    [self registerForKeyboardNotifications];
    
    if (SHARED_MANAGER.qpnUser.avatar_file_name)
    {
        [self.userDp sd_setImageWithURL:[NSURL URLWithString:SHARED_MANAGER.qpnUser.avatar_file_name]
                        placeholderImage:[UIImage imageNamed:@"boy"]
                               completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   
                                   if(image){
                                       
                                   }else{
                                   }
                               }];
    }
    
    self.attachedFileView.layer.cornerRadius = 8.0;
    self.attachedFileView.clipsToBounds = YES;
    
    self.attackedImageView.layer.cornerRadius = 7.0;
    self.attackedImageView.clipsToBounds = YES;

    if (self.attachedImage)
    {
        self.attackedImageView.image = self.attachedImage;
        self.attachedFileView.hidden = NO;
    }
    else
    {
        self.attachedFileView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
   // [[IQKeyboardManager sharedManager] setEnable:YES];
}
- (IBAction)backBtnClicked:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUpNavigation{
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UIView *shadow=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 64)];
    [shadow setBackgroundColor:[UIColor whiteColor]];
    shadow.layer.shadowColor=[UIColor colorWithRed:51/255 green:76/255 blue:104/255 alpha:1.0].CGColor;
    shadow.layer.shadowOffset=CGSizeMake(0, 15);
    shadow.layer.shadowOpacity=0.12;
    shadow.layer.shadowRadius=4.5;
    [self.view addSubview:shadow];
    
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

#pragma mark textfieldDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    float height = [self textViewHeightForAttributedText:textView.text andWidth:screenWidth- 62 heightWithoutText:32.0];
    
    NSLog(@"height %f",height);
    
    if (self.postTextHeight.constant <= screenHeight*0.2 && textView.text.length > 0)
    {
        self.postTextHeight.constant = height;
    }
    else
    {
        self.postTextHeight.constant = 32.0;
    }
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        textView.text = [textView.text stringByAppendingString:@" "];
    }
    return YES;
}
- (IBAction)addMedia:(UIButton *)sender {
    [self addImage:sender];
    
}

#pragma mark Action Sheet Delegate
-(void) addImage:(id) sender {
    
   UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Media Picker" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
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

#pragma mark Camera Delegate
- (void)TakeWithCamera:(NSTimer*)theTimer {
    
    [[SharedPickerView getSharedInstance]  startCameraPickerFromViewController:self usingDelegate:self withSelectionType: NO];
}
- (void)SelectFromLibrary:(NSTimer*)theTimer {
    [[SharedPickerView getSharedInstance] startLibraryPickerFromViewController:self usingDelegate:self withSelectionType: NO];
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
    [self useImage:img];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)useImage:(UIImage *)theImage {
    
    if (theImage)
    {
        self.attachedImage = theImage;
        self.attackedImageView.image = self.attachedImage;
        self.attachedFileView.hidden = NO;
    }
    else
    {
        self.attachedFileView.hidden = NO;
    }
    
}

- (IBAction)cancelAttachedImage:(UIButton *)sender {
    self.attachedFileView.hidden= YES;
    self.attackedImageView.image = nil;
    self.attachedImage = nil;
}

- (IBAction)createPostBtnClicked:(UIButton *)sender {
    
    if (self.postText.text.length> 0) {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"Waiting ...."];
        if(self.attachedImage) {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            
            [dateFormat setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
            
            NSDate *now = [NSDate date];
            
            NSString *theDate = [dateFormat stringFromDate:now];
            NSString *myUniqueName = [NSString stringWithFormat:@"9.jpg"];
            
            NSString *path = [documentsDirectory stringByAppendingPathComponent:myUniqueName];
            
            NSData *imageData = UIImageJPEGRepresentation(self.attachedImage,0.8);
            [imageData writeToFile:path atomically:NO];
            NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
            
            NSString*bucket = @"qpn/images/images/000/000/002/original";
            [[GTAWSS3Manager getSharedInstance] uploadObject:url fileName:myUniqueName uploadBucket:bucket completionHandler:^(BOOL sucess, NSError *error) {
                if(sucess) {
                    NSString*imageURL = [NSString stringWithFormat:@"https://s3-us-west-2.amazonaws.com/%@/%@",bucket,myUniqueName];
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    if ([fileManager fileExistsAtPath:path]){
                        [fileManager removeItemAtPath:path error:nil];
                    }
                     [self uploadPost:imageURL];
                } else {
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:error.localizedDescription];

                }
            }];
        }
        else {
            [self uploadPost:@""];
        }
    }
    else {
        
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Can't send Empty Post"];
        
    }
}

- (void)uploadPost:(NSString *)imageUrl{

    [SHARED_MANAGER showWorkingSpinner:self.view text:@"Creating Post.."];
    NSDictionary *parameters = @{ @"post": @{ @"text" : self.postText.text, @"image":imageUrl} };
    [AUTH_MAN createPost:parameters parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
        [SHARED_MANAGER hideWorkingSpinner:self.view];
        if(response) {
            
//            QPNPost * qpnPost = [[QPNPost alloc]initWithDictionary:response];
//            [SHARED_MANAGER.QPNPostArray addObject:qpnPost];
            
            
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Your post has been submitted and will be reviewed within a few hours"];

            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:@"reloadPost" object:self userInfo:nil];
            [self backBtnClicked:nil];
            
            
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

- (CGFloat)textViewHeightForAttributedText:(NSString*)text andWidth:(CGFloat)width heightWithoutText:(float)h {
    
    UITextView *calculationView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 0.0)];
    calculationView.font = [UIFont systemFontOfSize:16];
    calculationView.text = text;
    [calculationView sizeToFit];
    if(text.length > 0) {
        return calculationView.frame.size.height + h;
    }
    else {
        return h;
    }
}
@end


