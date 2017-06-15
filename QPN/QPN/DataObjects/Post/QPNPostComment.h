//
//  QPNPostComment.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTConstants.h"
#import "QPNUser.h"

@interface QPNPostComment : NSObject

@property (nonatomic, readwrite)NSString* post_id;
//@property (nonatomic, readwrite)NSString* image;
@property (nonatomic, readwrite)NSString* text;
@property (nonatomic, readwrite)NSString* time;
@property (nonatomic, readwrite)NSNumber * is_commented_by_me;

@property (strong, nonatomic) QPNUser * qpnUser;


-(id)initWithDictionary:(NSDictionary*) userObject;
-(void)updateWithDictionary:(NSDictionary*) userObject;

@end
