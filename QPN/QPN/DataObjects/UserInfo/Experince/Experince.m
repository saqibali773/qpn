//
//  Experince.m
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "Experince.h"
#import <UIKit/UIKit.h>


@interface Experince ()

@end
@implementation Experince

- (id)initWithDictionary:(NSDictionary*)industryDic {
    
    if(self = [super init])
    {
        _experinceId = [industryDic objectForKey:@"id"];
        _company_name = [industryDic objectForKey:@"company_name"];
        _descp = [industryDic objectForKey:@"description"];
        _job_title = [industryDic objectForKey:@"job_title"];
        _start_date = [industryDic objectForKey:@"start_date"];
        _end_date = [industryDic objectForKey:@"end_date"];
        _user_id = [industryDic objectForKey:@"user_id"];
        
    }
    return self;
}


@end


