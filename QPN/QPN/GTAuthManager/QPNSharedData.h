//
//  QPNSharedData.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GTConstants.h"
#import "DataRequest.h"
#import "ServerEngine.h"
#import "QPNAuthorizationManager.h"
#import "SignUpPayload.h"
#import "QPNUser.h"

#define SHARED_MANAGER [QPNSharedData getSharedInstance]
#define RELEASE_SHARED_MANAGER [QPNSharedData releaseSharedInstance]


@protocol CutsomAlertDelegate <NSObject>

@optional
-(void) alertPositiveButtonClicked:(id)sender;
-(void) alertNegativeButtonClicked:(id)sender;
-(float) updateUploadProgress;

@end
@interface QPNSharedData : NSObject


// initializer
+(QPNSharedData * )getSharedInstance;
+(void) releaseSharedInstance;

@property (nonatomic, assign) BOOL hasInet;
@property (nonatomic) SignUpPayload * signUpPayload;
@property (strong, nonatomic) QPNUser * qpnUser;
@property (strong, nonatomic) NSMutableArray* QPNPostArray;
@property (nonatomic) UserDataCatagory userDataCat;

@property (nonatomic,retain) NSMutableArray* wyDropDownArray;


// helpers
- (UIBarButtonItem*) barButtonWithTitle:(NSString*) titleText target:(id)target selector:(SEL) selector;
- (UIBarButtonItem*) barButtonWithImage:(NSString*) imageName target:(id)target selector:(SEL) selector;
-(void) showAlertView:(NSString*) title description:(NSString*) description positiveBtn:(NSString*) positiveBtn negativeBtn:(NSString*) negativeBtn delegate:(id<CutsomAlertDelegate>) delegate alertViewTag:(int) tag;
-(void) showUploadProgressAlert:(NSString*) title  delegate:(id<CutsomAlertDelegate>)delegate;

// UI Methods
-(void) showWorkingSpinner:(UIView*) view text:(NSString*) text;
-(void) hideWorkingSpinner:(UIView*) view;
-(void) hideWorkingSpinner:(UIView*) view after:(float) seconds;

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(BOOL) CheckPasswordIsValid:(NSString *)checkString;

-(NSString*) convert24hTo12h:(NSString*)time;
-(NSString*) convert12To24h:(NSString*)time;

-(NSString*)commaSepratedString:(NSMutableArray*)array ;

- (CGFloat)postTextViewHeightForAttributedText:(NSString*)text andWidth: (CGFloat)width heightWithoutText:(float)h;
- (NSString*)urlBy:(NSString*)lat and:(NSString*)lng;

- (NSString*)dayBuNumber:(int)dayNum;
- (NSMutableArray*)dataBreaker:(NSString*)date;

#pragma mark VideoDelegates
-(void)exportVideo:(NSURL*)videoPath
 completionHanlder:(RequestCompletionHandler) handler;
-(UIImage*)getVideoThumbnail:(NSURL*)filePath;

- (NSString *)urlencode:(NSString*)str;
- (NSString *)getIdOfCountry:(NSString *)code;
@end
