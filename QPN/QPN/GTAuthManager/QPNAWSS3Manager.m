//
//  QPNAWSS3Manager.m
//  LoginApp
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#import "QPNAWSS3Manager.h"
#import "GTConstants.h"

@interface QPNAWSS3Manager ()

//@property (nonatomic) GTRequestCompletionHandler loginCompletionHandler;
@property (nonatomic) AWSS3TransferManager * transferManager;
@end

@implementation QPNAWSS3Manager
@synthesize awsS3AccessKey,awsS3AccessSecret;
static QPNAWSS3Manager * staticSharedDataInstance = NULL;

+(QPNAWSS3Manager * ) getSharedInstance
{
    
    if(staticSharedDataInstance == NULL)
    {
        staticSharedDataInstance = [[QPNAWSS3Manager alloc] init];
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
      
        AWSStaticCredentialsProvider *credentialsProvider = [[AWSStaticCredentialsProvider alloc] initWithAccessKey:AWSAcessKey secretKey:AWSSecretKey];
        AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSWest2 credentialsProvider:credentialsProvider];
       [AWSS3TransferManager registerS3TransferManagerWithConfiguration:configuration forKey:@"GT_AWS"];
        self.transferManager = [AWSS3TransferManager S3TransferManagerForKey:@"GT_AWS"];
    }
    
    return self;
}

#pragma mark - Upload Method
-(void) uploadObject:(NSURL*) fileURL fileName:(NSString*) fileName uploadBucket:(NSString*) bucket completionHandler:(QPNAWSS3RequestCompletionHandler) handler
{
    AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
    uploadRequest.bucket = bucket;
    uploadRequest.key = fileName;
    uploadRequest.body = fileURL;
    uploadRequest.contentType = @"image/jpg";
    
    
    
    [[self.transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                       withBlock:^id(AWSTask *task) {
                                                           if (task.error != nil)
                                                           {
                                                               NSLog(@"%s %@","Error uploading :", uploadRequest.key);
                                                               handler(NO,task.error);
                                                           }
                                                           else
                                                           {
                                                               handler(YES,nil);
                                                               NSLog(@"Upload completed");
                                                           }
                                                           return nil;
                                                       }];
}
@end
