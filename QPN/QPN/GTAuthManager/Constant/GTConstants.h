//
//  GTConstants.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#ifndef GTConstants_h
#define GTConstants_h

#import <UIKit/UIKit.h>



static NSString * GET = @"GET";
static NSString * POST = @"POST";
static NSString * PUT = @"PUT";
static NSString * DELETE = @"DELETE";
static NSString * PATCH = @"PATCH";


typedef void (^RequestCompletionHandler)(id response, NSError* error);
typedef void (^GTRequestProgressBlock)(float progress);


@protocol GTRequestDelegate <NSObject>
-(void) requestFinished:(NSObject*)request;
@end

#define LIMIT  20

// *************************** //  app constants

#define AZYLocalized(string) NSLocalizedString(string, nil)
#define CHECK_STRING(string) ([string isKindOfClass: [NSString class]] ? string : @"")
#define CHECK_NUMBER(number) ([number isKindOfClass: [NSNumber class]] ? number : nil)
#define USER_DEFAULTS  [NSUserDefaults standardUserDefaults]
#define USER_DEF    [NSUserDefaults standardUserDefaults]
#define DEVICE_TOKEN @"token"
#define ACESS_TOKEN  @"accessToken" 
#define APP_DELEGATE1 ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define ACCESS_MANAGER  [GTUserAccess getSharedInstance]
#define NSStringIsEqual(first,second) [first isEqualToString:second]


#define GOOGLE_API_KEY @"AIzaSyBpx3Oo2dAgHA8DVcRFplW8skzhHHlHv7I"
#define HOCKEY_APP_KEY @"0861d34726e34aaeb10e83cd36d8a4bd"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#define INT_TO_STR(a)  [NSString stringWithFormat:@"%d",a]
#define INT_TO_NUM(a)  [NSNumber numberWithInt:a]
#pragma mark LazyWork
#define isEmpty(string) ([string isEqualToString:@""])
#define toast(string) ([self.view makeToast:string])
#define number(a) ([NSNumber numberWithInteger:a])

#define TEXT_FIELD_VIEW_HEIGHT 50.0
#define TEXT_VIEW_VIEW_HEIGHT 70.0


#define IMAGE_TAG 6001
#define GENDER_PICKER_TAG 6002
#define PERSON_PICKER_TAG 6003
#define INSTITUTE_PICKER_TAG 6004
#define ATTACHMENT_PICKER_TAG 6005
//#define SWIMMER_PICKER_TAG 6006




#define GUSET_ALERT @"Only registered users with Safer can perform this actions. Do you want to register now?"
#define LOGIN_ALERT @"Your account is not approved Yet."
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define BoundaryConstant  @"----------V2ymHFg03ehbqgZCaKO6jy"
#define  HAS_LOUNCHED_ONCE @"HasLaunchedOnce"
#define  SELECTED_LANG @"selecedLang"

#define APPLE_LANG @"AppleLanguages"

#define AWSAcessKey  @"AKIAILF4W7NFLXR2F6WA"
#define AWSSecretKey @"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"

#pragma mark NSNotificationConstant


typedef enum : NSUInteger {
    UserBioData,
    UserEducation,
    UserExperiance,
    UserAchievement,
    UserSkill,
    UserAllData
    
}UserDataCatagory;






#endif /* GTConstants_h */
