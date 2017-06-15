//
//  QPNSharedData.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNSharedPickerView.h"
#import "GTConstants.h"

#import <AVFoundation/AVFoundation.h>

@interface QPNSharedPickerView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end
@implementation QPNSharedPickerView

static QPNSharedPickerView * staticSharedDataInstance = NULL;

+(QPNSharedPickerView * ) getSharedInstance
{
    
    if(staticSharedDataInstance == NULL)
    {
        staticSharedDataInstance = [[QPNSharedPickerView alloc] init];
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
        if(!isVideoSelection){
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            picker.allowsEditing = NO;
            picker.delegate = delegateObject;
        }else{
            picker.videoMaximumDuration = 20;
            picker.delegate = delegateObject;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        }
        [controller presentViewController:picker animated:YES completion:nil];
        
    }
    return YES;
}

- (BOOL)startLibraryPickerFromViewController:(UIViewController*)controller usingDelegate:(id)delegateObject withSelectionType:(bool)isVideoSelection
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker1 = [[UIImagePickerController alloc] init];
        if(!isVideoSelection){
            picker1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker1.allowsEditing = NO;
            picker1.delegate = delegateObject;
            
        }else{
            
            picker1.delegate = delegateObject;
            picker1.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            picker1.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
            picker1.videoQuality = UIImagePickerControllerQualityTypeHigh;
            
        }
        [controller presentViewController:picker1 animated:YES completion:nil];
    }
    return YES;
}





@end
