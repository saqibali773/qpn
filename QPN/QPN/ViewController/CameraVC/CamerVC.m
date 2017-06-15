//
//  CamerVC.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "CamerVC.h"
#import "MBProgressHUD.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "PostCell.h"
#import "SharedPickerView.h"

#import "AddPostVC.h"

@interface CamerVC ()
@end

@implementation CamerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
     [self addImage:nil];
    
}
-(void) addImage:(id) sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Media Picker" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose Image From Camera Roll" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                       selector: @selector(SelectFromLibrary:) userInfo:nil repeats: NO];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                           selector: @selector(TakeWithCamera:) userInfo: nil repeats: NO];
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

    // Go to add post
    AddPostVC * vc;
    vc = [[AddPostVC alloc] initWithNibName:@"AddPostVC" bundle:[NSBundle mainBundle]];
//    vc.attachedImage = [[UIImage alloc] init];
    vc.attachedImage = theImage;
    self.navigationController.navigationBar.hidden = YES;
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onMenuClick:(id)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootContainer toggleLeftSideMenuCompletion:nil];

 
}




@end
