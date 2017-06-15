//
//  PostAttachMediaCell.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PostAttachMediaCellDelegate <NSObject>

-(void) removeImage:(id) sender cellIndex:(NSIndexPath*) index;

@end

@interface PostAttachMediaCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *placeImage;
@property(nonatomic) NSIndexPath * index;

@property(nonatomic,assign) id<PostAttachMediaCellDelegate> postMediaCellDelegate;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@end
