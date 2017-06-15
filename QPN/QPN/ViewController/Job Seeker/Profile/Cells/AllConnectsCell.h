//
//  AllConnectsCell.h
//  QPN
//
//  Created by Muhammad Usman on 04/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnnectCell.h"

@protocol AllConnectsCellDelegate <NSObject>
-(void)seeAllConnects;
-(void) connectPressed:(NSIndexPath*)indexPath;
@end

@interface AllConnectsCell : UITableViewCell  <NSObject,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *connectsCount;

@property (weak, nonatomic) IBOutlet UICollectionView *connectsCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *seeAllBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seeAllHeight;

@property (strong,nonatomic) NSArray * connectsArray;

@property (nonatomic,assign) id <AllConnectsCellDelegate> delegate;


-(void) populateConnectData;

@end
