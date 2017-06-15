//
//  Education.m
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "Education.h"
#import <UIKit/UIKit.h>


@interface Education ()

@end
@implementation Education

- (id)initWithDictionary:(NSDictionary*)industryDic {
    
    if(self = [super init])
    {
        
        _educationId = [industryDic objectForKey:@"id"];
        _institute = [industryDic objectForKey:@"institute"];
        _degree_title = [industryDic objectForKey:@"degree_title"];
        _start_date = [industryDic objectForKey:@"start_date"];
        if([[industryDic objectForKey:@"end_date"] isKindOfClass:[NSString class]]){
            _end_date = [industryDic objectForKey:@"end_date"];
        } else if([[industryDic objectForKey:@"end_date"] isKindOfClass:[NSNull class]]){
            _end_date = @"Present";
        }
        _created_at = [industryDic objectForKey:@"created_at"];
        _updated_at = [industryDic objectForKey:@"updated_at"];
        _user_id = [industryDic objectForKey:@"user_id"];

    }
    return self;
}


@end


