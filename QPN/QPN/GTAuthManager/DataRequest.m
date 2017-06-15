//
//  GTNetworkRequest.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "DataRequest.h"
#import "QPNSharedData.h"

@interface DataRequest ()

@property (nonatomic) RequestCompletionHandler completionHandler;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (weak,nonatomic) id<GTRequestDelegate> delegate;
@end

@implementation DataRequest


-(id) initWithRequest:(NSURLRequest*) request networkManager:(AFURLSessionManager*) manager delegate:(id)delegate completionHandler:(RequestCompletionHandler) handler
{
    self = [super init];
    if(self)
    {
        self.delegate = delegate;
        self.completionHandler = handler;
        self.dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            if(error.code == -1009){
                [SHARED_MANAGER showAlertView:@"Error" description:@"Please Check your connection" positiveBtn:@"OK" negativeBtn:nil delegate:nil alertViewTag:0];
                }
                self.completionHandler(nil,error);
            } else {
                self.completionHandler(responseObject,nil);
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
    [self.dataTask resume];
}
@end
