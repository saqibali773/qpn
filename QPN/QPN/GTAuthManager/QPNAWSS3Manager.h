//
//  QPNAWSS3Manager.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AWSCore.h>
#import <AWSS3/AWSS3.h>
#import <AWSS3/AWSS3TransferManager.h>

typedef void (^QPNAWSS3RequestCompletionHandler)(BOOL sucess, NSError* error);


@interface QPNAWSS3Manager : NSObject

// initializer
+(QPNAWSS3Manager * )getSharedInstance;
+(void) releaseSharedInstance;
@property (nonatomic) NSString* awsS3AccessKey;
@property (nonatomic) NSString* awsS3AccessSecret;

-(void) uploadObject:(NSURL*) fileURL fileName:(NSString*) fileName uploadBucket:(NSString*) bucket completionHandler:(QPNAWSS3RequestCompletionHandler) handler;

@end
