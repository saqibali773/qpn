//
//  Industry.h
//  QPN
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Industry : NSObject
@property (nonatomic, readwrite) NSNumber *industryId;
@property (nonatomic, readwrite) NSString *industryName;

- (id)initWithDictionary:(NSDictionary *)industryDic;
 @end
