//
//  ServerEngine.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GTConstants.h"
#import "DataRequest.h"
#import "QPNDownloadRequest.h"
#import "QPNUploadRequest.h"


@interface ServerEngine : NSObject

+(ServerEngine * ) getSharedInstance;
+(void) releaseSharedInstance;
+(void) setServerBaseURL:(NSString*) baseURL;


// will hit the given url
-(DataRequest*) requestWithURLString:(NSString*) api parameter:(NSDictionary*) parameters encoding:(ParameterEncoding) encoding httpMethod:(NSString*) httpMethod completionHandler:(RequestCompletionHandler) handler;

// will append server base url
-(DataRequest*) requestWithPathString:(NSString*) api parameter:(NSDictionary*) parameters encoding:(ParameterEncoding) encoding httpMethod:(NSString*) httpMethod completionHandler:(RequestCompletionHandler) handler;

// will hit the given url
-(QPNDownloadRequest*) downloadRequestWithURLString:(NSString*) api parameter:(NSDictionary*) parameters encoding:(ParameterEncoding) encoding httpMethod:(NSString*) httpMethod progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler;

// will append server base url
-(QPNDownloadRequest*) downloadRequestWithPathString:(NSString*) api parameter:(NSDictionary*) parameters encoding:(ParameterEncoding) encoding httpMethod:(NSString*) httpMethod progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler;

// will hit the given url
-(QPNUploadRequest*) uploadRequestWithURLString:(NSString*) api httpBody:(NSData*) httpBodyData formDataBoundaryConstant:(NSString*) boundaryConstant httpMethod:(NSString*) httpMethod progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler;

// will append server base url
-(QPNUploadRequest*) uploadRequestWithPathString:(NSString*) api httpBody:(NSData*) httpBodyData formDataBoundaryConstant:(NSString*) boundaryConstant httpMethod:(NSString*) httpMethod progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler;


// helpers
-(NSURL*) downloadDirectoryPath;
-(void) removeIfFileExistsAtPath:(NSString*) path;
-(NSMutableData *) uploadImage:(UIImage*)image withImageKey:(NSString*)fileKey withPayload:(NSDictionary*)payload;
-(NSMutableData *) uploadMultiImage:(NSMutableArray*)images withPayload:(NSDictionary*)payload;
-(NSMutableData *) uploadMultiple:(NSMutableArray*)fileURLs withPayload:(NSDictionary*)payload;

@end
