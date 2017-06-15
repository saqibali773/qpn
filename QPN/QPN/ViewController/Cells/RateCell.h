//
//  RateCell.h
//  SaferApp
//
//  Created by Granjur on 03/10/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RateCellDelegate <NSObject>

-(void) onRateBtnClicked:(id) sender starTag:(int) tag;

@end

@interface RateCell : UITableViewCell

@property(nonatomic)int starTag;
@property(nonatomic,assign) id<RateCellDelegate> rateDelegate;
-(void)setRatting:(int)tag;
@end
