//
//  Experince.h
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Experince : NSObject
@property (nonatomic, strong) NSNumber *experinceId;
@property (nonatomic, strong) NSString *company_name;
@property (nonatomic, strong) NSString *descp;
@property (nonatomic, strong) NSString *job_title;
@property (nonatomic, strong) NSString *start_date;
@property (nonatomic, strong) NSString *end_date;
@property (nonatomic, strong) NSString *user_id;

- (id)initWithDictionary:(NSDictionary *)industryDic;

 @end
