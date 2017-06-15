//
//  Job.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "FeedSearch.h"
#import "GTConstants.h"
#import "QPNSharedData.h"
@implementation FeedSearch

- (id)initWithDictionary:(NSArray*)userObject {
    
    if(self = [super init])
    {
        _jobsArray = [NSMutableArray array];
        _usersArray = [NSMutableArray array];
        
        [self updateWithDictionary:userObject];
    }
    return self;
}
- (void)updateWithDictionary:(NSArray*)userObject {

    if (userObject.count > 0) {
        
        NSDictionary * userDic = [userObject objectAtIndex:0];
        if (userDic[@"users"]) {
             [self populateUserArray:userDic[@"users"]];
        }
        else
        {
           [self populateJobArray:userDic[@"jobs"]];
        }
       
      
        if (userObject.count >1) {
            
            NSDictionary * userDic = [userObject objectAtIndex:1];
            
            if (userDic[@"users"]) {
                [self populateUserArray:userDic[@"users"]];
            }
            else
            {
                [self populateJobArray:userDic[@"jobs"]];
            }
        }
    }
    
}


- (void) populateUserArray :(NSDictionary*) dic
{
    for (NSDictionary * userDic in  dic) {
        
        QPNUser * userObj = [[QPNUser alloc] initWithDictionary:userDic isShortInfo:YES];
        [self.usersArray addObject:userObj];
    }
}

- (void) populateJobArray :(NSDictionary*) dic
{
    for (NSDictionary * jobDic in  dic) {
        
        Job * jobObj = [[Job alloc] initWithDictionary:jobDic];
        [self.jobsArray addObject:jobObj];
    }
}

@end
