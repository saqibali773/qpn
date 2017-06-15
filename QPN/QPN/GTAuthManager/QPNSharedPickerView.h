//
//  QPNSharedData.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GTConstants.h"
#import "DataRequest.h"

#define SHARED_MANAGER_PICKERVIEW [QPNSharedPickerView getSharedInstance]
#define RELEASE_SHARED_MANAGER_PICKERVIEW [QPNSharedPickerView releaseSharedInstance]


@interface QPNSharedPickerView : NSObject

+(QPNSharedPickerView * ) getSharedInstance;
- (BOOL)startCameraPickerFromViewController:(UIViewController*)controller usingDelegate:(id)delegateObject withSelectionType:(bool)isVideoSelection;
- (BOOL)startLibraryPickerFromViewController:(UIViewController*)controller usingDelegate:(id)delegateObject withSelectionType:(bool)isVideoSelection;
@end


