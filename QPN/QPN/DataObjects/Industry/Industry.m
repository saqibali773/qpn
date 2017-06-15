//
//  Industry.m
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "Industry.h"
#import <UIKit/UIKit.h>


@implementation Industry
@synthesize industryId,industryName;

- (id)initWithDictionary:(NSDictionary*)industryDic {
    
    if(self = [super init])
    {
        industryId = [industryDic objectForKey:@"id"];
        industryName = [industryDic objectForKey:@"name"];
        
    }
    return self;
}


@end


