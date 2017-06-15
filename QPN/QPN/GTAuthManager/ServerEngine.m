//
//  ServerEngine.m
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "ServerEngine.h"
#import "AFNetworking.h"
#import "QPNSharedData.h"
#import "QPNAuthorizationManager.h"
#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]


@interface ServerEngine ()<GTRequestDelegate>

@property (nonatomic) AFURLSessionManager * networkManager;
@property (nonatomic) NSMutableArray * requestsQueue;
@end

@implementation ServerEngine

static ServerEngine * staticServerEngineInstance = NULL;
static NSString * serverBaseURL = NULL;
+(void) setServerBaseURL:(NSString*) baseURL
{
    serverBaseURL = baseURL;
}
+(ServerEngine * ) getSharedInstance
{
    
    if(staticServerEngineInstance == NULL)
    {
        staticServerEngineInstance = [[ServerEngine alloc] init];
    }
    return staticServerEngineInstance;
}

+(void) releaseSharedInstance
{
    if(staticServerEngineInstance)
    {
        staticServerEngineInstance = NULL;
    }
}
-(id)init
{
    self = [super init];
    if(self)
    {
        self.requestsQueue = [NSMutableArray array];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.networkManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
    }
    return self;
}

#pragma mark - Data Request Methods
-(DataRequest*) requestWithPathString:(NSString*) api parameter:(NSDictionary*) parameters encoding:(ParameterEncoding) encoding httpMethod:(NSString*) httpMethod completionHandler:(RequestCompletionHandler) handler
{
  
    NSString * fullURL = [serverBaseURL stringByAppendingString:api];
    NSLog(@"Full Url %@",fullURL);
    NSLog(@"Parameter %@",parameters);
    
   return [self requestWithURLString:fullURL parameter:parameters encoding:encoding httpMethod:httpMethod completionHandler:handler];
}
-(DataRequest*) requestWithURLString:(NSString*) api parameter:(NSDictionary*) parameters encoding:(ParameterEncoding) encoding httpMethod:(NSString*) httpMethod completionHandler:(RequestCompletionHandler) handler
{
    NSMutableURLRequest * request;
    if (encoding == URL)
    {
       request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:httpMethod URLString:api parameters:parameters error:nil];
    }
    else if(encoding == JSON)
    {
       request = [[AFJSONRequestSerializer serializer] requestWithMethod:httpMethod URLString:api parameters:parameters error:nil];
    }
    
    // This header will be set for all apis other than,signup and signin
    if (AUTH_MAN.authToken)
    {
        NSLog(@"Auth::%@",AUTH_MAN.authToken);
        [request setValue: AUTH_MAN.authToken forHTTPHeaderField:@"token"];
    }
    
    DataRequest * newRequest = [[DataRequest alloc] initWithRequest:request networkManager:self.networkManager delegate:self completionHandler:handler];
    [self.requestsQueue addObject:newRequest];
    return newRequest;
}
#pragma mark - Download File Request Methods
-(QPNDownloadRequest*) downloadRequestWithPathString:(NSString*) api parameter:(NSDictionary*) parameters encoding:(ParameterEncoding) encoding httpMethod:(NSString*) httpMethod progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler
{
    NSString * fullURL = [serverBaseURL stringByAppendingString:api];
    
   return [self downloadRequestWithURLString:fullURL parameter:parameters encoding:encoding httpMethod:httpMethod progressBlock:progressBlock completionHandler:handler];
}
-(QPNDownloadRequest*) downloadRequestWithURLString:(NSString*) api parameter:(NSDictionary*) parameters encoding:(ParameterEncoding) encoding httpMethod:(NSString*) httpMethod progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler
{
    NSMutableURLRequest * request;
    if (encoding == URL)
    {
        request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:httpMethod URLString:api parameters:parameters error:nil];
    }
    else if(encoding == JSON)
    {
        request = [[AFJSONRequestSerializer serializer] requestWithMethod:httpMethod URLString:api parameters:parameters error:nil];
    }
    
    
    QPNDownloadRequest * newRequest = [[QPNDownloadRequest alloc] initWithRequest:request networkManager:self.networkManager delegate:self progressBlock:progressBlock completionHandler:handler];
    [self.requestsQueue addObject:newRequest];
//    [newRequest executeRequest];
    return newRequest;
}
#pragma mark - Upload Request methods
-(QPNUploadRequest*) uploadRequestWithPathString:(NSString*) api httpBody:(NSData*) httpBodyData formDataBoundaryConstant:(NSString*) boundaryConstant  httpMethod:(NSString*) httpMethod progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler
{
    NSString * fullURL = [serverBaseURL stringByAppendingString:api];
    
    return [self uploadRequestWithURLString:fullURL httpBody:httpBodyData formDataBoundaryConstant:boundaryConstant httpMethod:httpMethod progressBlock:progressBlock completionHandler:handler];
}
-(QPNUploadRequest*) uploadRequestWithURLString:(NSString*) api httpBody:(NSData*) httpBodyData formDataBoundaryConstant:(NSString*) boundaryConstant httpMethod:(NSString*) httpMethod progressBlock:(GTRequestProgressBlock)progressBlock completionHandler:(RequestCompletionHandler) handler
{
    NSMutableURLRequest * request;
    request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:httpMethod URLString:api parameters:nil error:nil];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[httpBodyData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    QPNUploadRequest * uploadRequest = [[QPNUploadRequest alloc] initWithRequest:request httpBody:httpBodyData networkManager:self.networkManager delegate:self progressBlock:progressBlock completionHandler:handler];
    [self.requestsQueue addObject:uploadRequest];
    return uploadRequest;
}
-(void) requestFinished:(DataRequest*) request
{
    if ([self.requestsQueue containsObject:request])
    {
        [self.requestsQueue removeObject:request];
    }
}
#pragma mark - Helpers
-(void) removeIfFileExistsAtPath:(NSString*) path
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        [fileManager removeItemAtPath:path error:nil];
    }
}
-(void) createDownloadsDirectory
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* videosPath = [[self downloadDirectoryPath] path];
    if ( ![fileManager fileExistsAtPath: videosPath
                            isDirectory: NULL] )
    {
        NSError* error = nil;
        if ( ![fileManager createDirectoryAtPath: videosPath
                     withIntermediateDirectories: YES
                                      attributes: nil
                                           error: &error] )
        {
            
        }
    }
}
-(NSURL*) downloadDirectoryPath
{
    NSURL* baseDirectory =  [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory
                                                                    inDomains: NSUserDomainMask] lastObject];
   // NSURL* finalDirectory = [baseDirectory URLByAppendingPathComponent: @"downloads"
                                                       //    isDirectory: YES];
    return baseDirectory;
}
-(NSString*) urlEncodeString:(NSString*) apiURL parameters:(NSDictionary*) parameters
{
    NSArray* keys = parameters.allKeys;
    apiURL = [apiURL stringByAppendingString:@"?"];
    for (int i=0;i<keys.count;i++)
    {
        NSString * key = keys[i];
        NSString * value = parameters[key];
        if (i==0)
        {
            apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
        }
        else
        {
           apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
        }
    }
    return apiURL;
}
-(NSMutableData *) uploadImage:(UIImage*)image withImageKey:(NSString*)fileKey withPayload:(NSDictionary*)payload{

    
    // post body
   
    NSString* FileParamConstant =fileKey;// @"fileName";
    
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in payload) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [payload objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    return body;
    

}
-(NSMutableData *) uploadMultiImage:(NSMutableArray*)images withPayload:(NSDictionary*)payload{
    


    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in payload) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [payload objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    int i =0;
    for(id obj in images){
    
        NSString* FileParamConstant = [NSString stringWithFormat:@"file[%d]",i];
        
        if([obj isKindOfClass:[UIImage class]]){
            UIImage*image = obj;
            // @"fileName";
            NSData *imageData = UIImageJPEGRepresentation(image, .40);
        
            if (imageData) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:imageData];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }else if([obj isKindOfClass:[NSURL class]]){
        
            NSString *path = [obj path];
            
            CFStringRef pathExtension = (__bridge_retained CFStringRef)[path pathExtension];
            CFStringRef type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, NULL);
            CFRelease(pathExtension);
            
            // The UTI can be converted to a mime type:
            
            NSString *mimeType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass(type, kUTTagClassMIMEType);
            if (type != NULL)
                CFRelease(type);
            
            NSString *theFileName = [path lastPathComponent];
            
            // add image data
            NSData *imageData = [NSData dataWithContentsOfURL:obj];
            if (imageData) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant,theFileName] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n",mimeType] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:imageData];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        i++;
    }
    
    return body;

}
-(NSMutableData *) uploadFile:(NSURL*) fileURL withFileKey:(NSString*)fileKey withPayload:(NSDictionary*)payload
{
    // post body
    
    NSString* FileParamConstant = fileKey;
    
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in payload) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [payload objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *path = [fileURL path];
    
    CFStringRef pathExtension = (__bridge_retained CFStringRef)[path pathExtension];
    CFStringRef type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, NULL);
    CFRelease(pathExtension);
    
    // The UTI can be converted to a mime type:
    
    NSString *mimeType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass(type, kUTTagClassMIMEType);
    if (type != NULL)
        CFRelease(type);
    NSLog(@"%@",mimeType);
    
    NSString *theFileName = [path lastPathComponent];
    
    // add image data
    NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant,theFileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n",mimeType] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    return body;
}

-(NSMutableData *) uploadMultiple:(NSMutableArray*)fileURLs  withPayload:(NSDictionary*)payload
{
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in payload) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [payload objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    int i=0;
    for (NSURL*fileUrl in fileURLs){
        NSString *path = [fileUrl path];
     NSString* FileParamConstant = [NSString stringWithFormat:@"file[%d]",i];
        CFStringRef pathExtension = (__bridge_retained CFStringRef)[path pathExtension];
        CFStringRef type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, NULL);
        CFRelease(pathExtension);
        NSString *mimeType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass(type, kUTTagClassMIMEType);
        if (type != NULL)
            CFRelease(type);
        NSString *theFileName = [path lastPathComponent];
    
        // add image data
        NSData *imageData = [NSData dataWithContentsOfURL:fileUrl];
        if (imageData) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant,theFileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n",mimeType] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        i++;
    }
    
        return body;
}
@end
