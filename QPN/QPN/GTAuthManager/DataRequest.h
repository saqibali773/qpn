//
//  GTNetworkRequest.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "GTEnumConstant.h"
#import "GTConstants.h"

typedef void (^RequestCompletionHandler)(id response, NSError* error);

@interface DataRequest : NSObject

-(id) initWithRequest:(NSURLRequest*) request networkManager:(AFURLSessionManager*) manager delegate:(id)delegate  completionHandler:(RequestCompletionHandler) handler;
-(void) executeRequest;

@property (nonatomic) GTRequestStatus status;
@end
