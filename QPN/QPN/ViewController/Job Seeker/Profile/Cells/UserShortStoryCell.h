//
//  UserShortStoryCell.h
//  QPN
//
//  Created by Muhammad Usman on 05/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UserShortStoryCellDelegate <NSObject>

-(void)addVideo;
-(void)playVideo;

@end

@interface UserShortStoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoPlaceHolder;

@property (nonatomic,strong) id <UserShortStoryCellDelegate>shortStoryCellDelegate;

@end
