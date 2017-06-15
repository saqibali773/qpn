//
//  SharedData.h
//  SaferApp
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SHARED_MANAGER [SharedData getSharedInstance]
#define RELEASE_SHARED_MANAGER [SharedData releaseSharedInstance]

@interface SharedData : NSObject

// initializer
+(SharedData * )getSharedInstance;
+(void) releaseSharedInstance;

// UI Methods
-(void) showWorkingSpinner:(UIView*) view text:(NSString*) text;
-(void) hideWorkingSpinner:(UIView*) view;
-(void) hideWorkingSpinner:(UIView*) view after:(float) seconds;

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(BOOL) CheckPasswordIsValid:(NSString *)checkString;


-(GTCity*)getCity:(int)cityId;// wrong

-(NSString*) convert24hTo12h:(NSString*)time;
-(NSString*) convert12To24h:(NSString*)time;

-(NSString*)commaSepratedString:(NSMutableArray*)array ;

- (CGFloat)textViewHeightForAttributedText: (NSString*)text andWidth: (CGFloat)width heightWithoutText:(float)h;
-(NSString*) urlBy:(NSString*)lat and:(NSString*)lng;

-(NSString*) dayByNumber:(int) dayNum;

-(NSMutableArray*)dataBreaker: (NSString*)date;

/*#pragma mark VideoDelegates
-(void)exportVideo:(NSURL*)videoPath
 completionHanlder:(RequestCompletionHandler) handler;
-(UIImage*)getVideoThumbnail:(NSURL*)filePath;
-(NSString*)imageUploadCompleteURL:(UploadClassType) uploadType withFileType:(UploadObjectType)fileType withRecordId:(NSString*)recordId andReportId:(NSString*)reportId;

- (NSString *)urlencode:(NSString*)str;
*/
 @end
