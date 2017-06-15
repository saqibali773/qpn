//
//  Achievement.m
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "Achievement.h"
#import <UIKit/UIKit.h>


@interface Achievement ()

@end
@implementation Achievement

- (id)initWithDictionary:(NSDictionary*)industryDic {
    
    if(self = [super init])
    {
        _achievementId = [industryDic objectForKey:@"id"];
        _title = [industryDic objectForKey:@"title"];
        _start_date = [industryDic objectForKey:@"start_date"];
        _descp = [industryDic objectForKey:@"description"];
        _user_id = [industryDic objectForKey:@"user_id"];
        _created_at = [industryDic objectForKey:@"created_at"];
        _updated_at = [industryDic objectForKey:@"updated_at"];
        
        
        
    }
    return self;
}


@end


