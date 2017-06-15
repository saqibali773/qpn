//
//  QPNPostComment..m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNPostComment.h"
#import "GTConstants.h"
#import "QPNSharedData.h"
@implementation QPNPostComment

@synthesize post_id,text,time,is_commented_by_me;
- (id)initWithDictionary:(NSDictionary*)userObject {
    
    if(self = [super init])
    {
        [self updateWithDictionary:userObject];
    }
    return self;
}
- (void)updateWithDictionary:(NSDictionary*)userObject {
    
    // Strings
    self.post_id = userObject[@"id"];
    self.text = userObject[@"text"];
    self.time = userObject[@"time"];
    
    // bool
    self.is_commented_by_me = userObject[@"is_commented_by_me"];
    
    _qpnUser = [[QPNUser alloc] initWithDictionary:userObject[@"user"] isShortInfo:true];
    
    
    
}
@end
