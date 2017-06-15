//
//  Education.h
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Education : NSObject
@property (nonatomic, strong) NSNumber *educationId;
@property (nonatomic, strong) NSString *institute;
@property (nonatomic, strong) NSString *degree_title;
@property (nonatomic, strong) NSString *start_date;
@property (nonatomic, strong) NSString *end_date;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *updated_at;
@property (nonatomic, strong) NSString *user_id;


- (id)initWithDictionary:(NSDictionary *)industryDic;
 @end
