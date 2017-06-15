//
//  QPNPost..m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "QPNPost.h"
#import "GTConstants.h"
#import "QPNSharedData.h"
@implementation QPNPost

@synthesize post_id,image,text,no_of_likes,ago;
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
    
    self.image = userObject[@"image"];
    if(![self.image containsString:@"http"] && self.image.length != 0) {
        self.image = [NSString stringWithFormat:@"http:%@",self.image];
    }
    
    self.text = userObject[@"text"];
    self.ago = userObject[@"ago"];
    
    
    // Numbers
    self.no_of_likes = userObject[@"no_of_likes"];
    
    // bool
    if (userObject[@"is_liked_by_me"]) {
        self.is_liked_by_me = [userObject[@"is_liked_by_me"] boolValue];
    }
    if (userObject[@"is_my_post"]) {
        self.is_my_post = [userObject[@"is_my_post"] boolValue];
    }
    
    
    _qpnUser = [[QPNUser alloc] initWithDictionary:userObject[@"posted_user"] isShortInfo:true];
    
    if (userObject[@"comment"]) {
        _comment = [[QPNPostComment alloc] initWithDictionary:userObject[@"comment"]];
    }
    
    
}
@end
