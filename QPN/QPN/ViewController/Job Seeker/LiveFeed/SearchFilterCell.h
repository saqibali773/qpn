//
//  SearchFilterCell.h
//  SaferApp
//
//  Created by Granjur on 12/01/2017.
//  Copyright © 2017 Granjur. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GTImageView <NSObject>

-(void)selectedImage:(NSIndexPath*)indexPath;

@end

@interface SearchFilterCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *FilterTitle;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;

@property (nonatomic) bool isSelected;

@end
