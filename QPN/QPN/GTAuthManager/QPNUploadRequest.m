//
//  QPNUploadRequest.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNUploadRequest.h"
#import "ServerEngine.h"
#import "QPNSharedData.h"
@interface QPNUploadRequest ()

@property (nonatomic) RequestCompletionHandler completionHandler;
@property (nonatomic) GTRequestProgressBlock progressBlock;
@property (nonatomic) NSURLSessionUploadTask *uploadTask;
@property (weak,nonatomic) id<GTRequestDelegate> delegate;
@property (nonatomic) float uploadProgress;
@end
@implementation QPNUploadRequest

-(id) initWithRequest:(NSURLRequest*) request httpBody:(NSData*) httpBody networkManager:(AFURLSessionManager*) manager delegate:(id)delegate progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler
{
    self = [super init];
    if(self)
    {
        self.uploadProgress = 0.0;
        self.delegate = delegate;
        self.completionHandler = handler;
        self.progressBlock = progressBlock;
        self.uploadTask = [manager uploadTaskWithRequest:request fromData:httpBody progress:^(NSProgress * _Nonnull uploadProgress) {
            self.uploadProgress = uploadProgress.fractionCompleted;
            self.progressBlock(self.uploadProgress);
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (!error)
            {
                
                
                self.completionHandler(responseObject,nil);
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
    [self.uploadTask resume];
}

@end
