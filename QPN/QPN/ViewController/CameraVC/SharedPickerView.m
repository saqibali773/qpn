//
//  SharedPickerView.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SharedPickerView.h"

#import <AVFoundation/AVFoundation.h>

@interface SharedPickerView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end
@implementation SharedPickerView

static SharedPickerView * staticSharedDataInstance = NULL;

+(SharedPickerView * ) getSharedInstance
{
    
    if(staticSharedDataInstance == NULL)
    {
        staticSharedDataInstance = [[SharedPickerView alloc] init];
    }
    return staticSharedDataInstance;
}

+(void) releaseSharedInstance
{
    if(staticSharedDataInstance)
    {
        staticSharedDataInstance = NULL;
    }
}
-(id)init
{
    self = [super init];
    if(self)
    {
    
    }
    
    return self;
    
}

- (BOOL)startCameraPickerFromViewController:(UIViewController*)controller usingDelegate:(id)delegateObject withSelectionType:(bool)isVideoSelection
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        picker.delegate = delegateObject;
        [controller presentViewController:picker animated:YES completion:nil];
        
    }
    return YES;
}

- (BOOL)startLibraryPickerFromViewController:(UIViewController*)controller usingDelegate:(id)delegateObject withSelectionType:(bool)isVideoSelection
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker1 = [[UIImagePickerController alloc] init];
        picker1.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        picker1.allowsEditing = NO;
        picker1.delegate = delegateObject;
        [controller presentViewController:picker1 animated:YES completion:nil];
    }
    return YES;
}

@end
