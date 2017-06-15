//
//  IndustryVC.h
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@class Industry;
@protocol IndustryVCDelegate <NSObject>

- (void)selectedIndustry:(Industry *) industry;

@end

@interface IndustryVC : UIViewController
@property (nonatomic,strong)id<IndustryVCDelegate>delegate;

@end

