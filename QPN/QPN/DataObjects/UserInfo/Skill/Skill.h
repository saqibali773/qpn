//
//  Skill.h
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Skill : NSObject
@property (nonatomic, strong) NSNumber *skillId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *updated_at;

- (id)initWithDictionary:(NSDictionary *)industryDic;
 @end
