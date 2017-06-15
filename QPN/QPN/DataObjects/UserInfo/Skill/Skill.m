//
//  Skill.m
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "Skill.h"
#import <UIKit/UIKit.h>


@interface Skill ()

@end
@implementation Skill

- (id)initWithDictionary:(NSDictionary*)industryDic {
    
    if(self = [super init])
    {
        _skillId = [industryDic objectForKey:@"id"];
        _title = [industryDic objectForKey:@"title"];
        _user_id = [industryDic objectForKey:@"user_id"];
        _created_at = [industryDic objectForKey:@"created_at"];
        _updated_at = [industryDic objectForKey:@"updated_at"];
    
        
    }
    return self;
}


@end


