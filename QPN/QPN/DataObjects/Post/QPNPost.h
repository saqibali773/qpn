//
//  QPNPost.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTConstants.h"
#import "QPNUser.h"
#import "QPNPostComment.h"

@interface QPNPost : NSObject

@property (nonatomic, readwrite)NSString* post_id;
@property (nonatomic, readwrite)NSString* image;
@property (nonatomic, readwrite)NSString* text;
//@property (nonatomic, readwrite)NSString* created_at;
//@property (nonatomic, readwrite)NSString* updated_at;
@property (nonatomic, readwrite)NSString* ago;
@property (nonatomic, readwrite)NSNumber * no_of_likes;

@property (nonatomic, readwrite)BOOL is_liked_by_me;
@property (nonatomic, readwrite)BOOL is_my_post;

@property (strong, nonatomic) QPNUser * qpnUser;
@property (strong, nonatomic) QPNPostComment * comment;




-(id)initWithDictionary:(NSDictionary*) userObject;
-(void)updateWithDictionary:(NSDictionary*) userObject;

@end
