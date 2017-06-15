//
//  ConnectUser.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "ConnectUser.h"
#import "GTConstants.h"
#import "QPNSharedData.h"
@implementation ConnectUser

- (id)initWithDictionary:(NSDictionary*)userObject {
    
    if(self = [super init])
    {
        [self updateWithDictionary:userObject];
    }
    return self;
}
- (void)updateWithDictionary:(NSDictionary*)userObject {
    
    // Numbers
    _userId = userObject[@"id"];
    // Strings
    _name  = CHECK_STRING(userObject[@"name"]);
    _avatar_file_name = CHECK_STRING(userObject[@"avatar"]);
    if(![_avatar_file_name containsString:@"http"]) {
        _avatar_file_name = [NSString stringWithFormat:@"http:%@",self.avatar_file_name];
    }
}

@end
