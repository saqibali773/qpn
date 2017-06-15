//
//  QPNSharedData.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GTConstants.h"
#import "DataRequest.h"

#define SHARED_MANAGER_PREVIEW [QPNSharedPreview getSharedInstance]
#define RELEASE_SHARED_MANAGER_PREVIEW [QPNSharedPreview releaseSharedInstance]


@interface QPNSharedPreview : NSObject

+(QPNSharedPreview * ) getSharedInstance;
-(void) viewPhotos:(NSArray*)imageUrls withController: (UIViewController*)controller withIndex: (int) photoIndex;
-(void) viewVideo:(NSArray*)videoUrls withController: (UIViewController*)controller;
@end


