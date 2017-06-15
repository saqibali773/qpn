//
//  QPNDownloadRequest.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#import "QPNDownloadRequest.h"
#import "ServerEngine.h"
#import "QPNSharedData.h"
@interface QPNDownloadRequest ()

@property (nonatomic) RequestCompletionHandler completionHandler;
@property (nonatomic) GTRequestProgressBlock progressBlock;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;
@property (weak,nonatomic) id<GTRequestDelegate> delegate;
@property (nonatomic) float downloadProgress;
@end

@implementation QPNDownloadRequest

-(id) initWithRequest:(NSURLRequest*) request networkManager:(AFURLSessionManager*) manager delegate:(id)delegate progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler
{
    self = [super init];
    if(self)
    {
        self.downloadProgress = 0.0;
        self.delegate = delegate;
        self.completionHandler = handler;
        self.progressBlock = progressBlock;
        self.downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress)
        {
            self.downloadProgress = downloadProgress.fractionCompleted;
            self.progressBlock(self.downloadProgress);
        }  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[ServerEngine getSharedInstance] downloadDirectoryPath];
            NSURL * finalURL = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            [[ServerEngine getSharedInstance] removeIfFileExistsAtPath:finalURL.path];
            return finalURL;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            if (!error)
            {
                self.completionHandler(filePath,nil);
            }
            else
            {
                if(error.code == -1009){
                    [SHARED_MANAGER showAlertView:@"Error" description:@"Please Check your connection" positiveBtn:@"OK" negativeBtn:nil delegate:nil alertViewTag:-3];
                }
                self.completionHandler(nil,error);
            }
            self.status = GT_FINISHED;
            if (self.delegate)
            {
                [self.delegate requestFinished:self];
            }
        }];
    }
    return self;
}
-(void) executeRequest
{
    self.status = GT_LOADING;
    [self.downloadTask resume];
}

@end
