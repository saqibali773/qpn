//
//  QPNUploadRequest.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"AFNetworking.h"
#import "GTConstants.h"
#import "GTEnumConstant.h"

@interface QPNUploadRequest : NSObject


-(id) initWithRequest:(NSURLRequest*) request httpBody:(NSData*) httpBody networkManager:(AFURLSessionManager*) manager delegate:(id)delegate progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler;
-(void) executeRequest;
@property (nonatomic) GTRequestStatus status;
@property (readonly) float uploadProgress;
@end
