//
//  Achievement.h
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Achievement : NSObject
@property (nonatomic, strong) NSNumber *achievementId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *start_date;
@property (nonatomic, strong) NSString *descp;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *updated_at;

- (id)initWithDictionary:(NSDictionary *)industryDic;
 @end
