//
//  ConnectUser.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTConstants.h"
@interface ConnectUser : NSObject

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar_file_name;

-(id)initWithDictionary:(NSDictionary*) userObject;
-(void)updateWithDictionary:(NSDictionary*) userObject;

@end
