//
//  QPNSharedData.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNSharedPreview.h"
#import "GTConstants.h"

#import <AVFoundation/AVFoundation.h>

#import <Photos/Photos.h>
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"
@interface QPNSharedPreview ()<MWPhotoBrowserDelegate>


@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;
@end
@implementation QPNSharedPreview

static QPNSharedPreview * staticSharedDataInstance = NULL;

+(QPNSharedPreview * ) getSharedInstance
{
    
    if(staticSharedDataInstance == NULL)
    {
        staticSharedDataInstance = [[QPNSharedPreview alloc] init];
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

-(void) viewPhotos:(NSArray*)imageUrls withController: (UIViewController*)controller withIndex: (int) photoIndex{
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    
    for(id imageObj in imageUrls){
        if([imageObj isKindOfClass:[NSString class]]){
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:imageObj]]];
        }else{
            [photos addObject:[MWPhoto photoWithImage:imageObj]];
        }
    }
    self.photos = photos;
    enableGrid = NO;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:photoIndex];
    [controller.navigationController pushViewController:browser animated:YES];
}

-(void) viewVideo:(NSArray*)videoUrls withController: (UIViewController*)controller{
   
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    
    for(id imageObj in videoUrls){
        
        if([imageObj isKindOfClass:[NSString class]]){
            [photos addObject:[MWPhoto videoWithURL:[NSURL URLWithString:imageObj]]];
        }else{
            [photos addObject:[MWPhoto videoWithURL:imageObj]];
        }
    }
    self.photos = photos;
    enableGrid = NO;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    [controller.navigationController pushViewController:browser animated:YES];

}





#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}



- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [photoBrowser dismissViewControllerAnimated:YES completion:nil];
}



//- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
//    return [[_selections objectAtIndex:index] boolValue];
//}
//
//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
//    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
//    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
//}

@end
