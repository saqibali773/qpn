//
//  MovieTableViewCell.h
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface JobSeekerCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *Name;
@property (strong, nonatomic) IBOutlet UILabel *staring;
@property (strong, nonatomic) IBOutlet UILabel *director;
@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UILabel *genre;
@property (strong, nonatomic) IBOutlet UILabel *hrsMins;




//-(void)populateDataForTable:(Movie*)movieObj;
@end
