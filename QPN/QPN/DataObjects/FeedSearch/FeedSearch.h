//
//  Job.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTConstants.h"
#import "QPNUser.h"
#import "Job.h"

@interface FeedSearch : NSObject

@property (strong , nonatomic) NSMutableArray * jobsArray;
@property (strong , nonatomic) NSMutableArray * usersArray;

-(id)initWithDictionary:(NSArray*) userObject;
-(void)updateWithDictionary:(NSArray*) userObject;

@end
