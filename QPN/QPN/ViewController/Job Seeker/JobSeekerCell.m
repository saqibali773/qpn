//
//  MovieTaableViewCell.m
//  QPN
//
//  Created by SaqibAli on 26/01/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "JobSeekerCell.h"

@implementation JobSeekerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.image.layer.borderColor = [UIColor whiteColor].CGColor;
    self.image.layer.borderWidth = 2.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)populateDataForTable:(Movie*)movieObj{
//
//    self.Name.text = [NSString stringWithFormat:@"%@ (%@)",movieObj.headlines,movieObj.year];
//    self.staring.text = [NSString stringWithFormat:@"Starring:%@",[self addCast:movieObj.cast]];
//    self.director.text = [NSString stringWithFormat:@"Director:%@",[self addDirectors:movieObj.directors]];
//    self.genre.text = [NSString stringWithFormat:@"%@",[self addGenre:movieObj.genres]];
//    
//    self.rating.text = [NSString stringWithFormat:@"%0.1f",movieObj.rating];
//    self.hrsMins.text = movieObj.duarationInHrMinSec;
//    if(movieObj.keyArt.count>0){
//        KeyArt*obj = movieObj.keyArt[0];
//        
//        [self.image sd_setImageWithURL:[NSURL URLWithString:obj.url]
//                      placeholderImage:[UIImage imageNamed:@"placeholder"]
//                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                 if(image){
//                                     [self.image setImage:image];
//                                 }else{}
//                             }];
//        
//    }
//
//    
//    
//}
//-(NSString*)addCast:(NSMutableArray*)casts{
//
//    NSString*string = @"";
//    for(Person*castObj  in casts){
//        if(string.length>0){
//            string=[NSString stringWithFormat:@"%@,",string];
//        }
//        string= [NSString stringWithFormat:@"%@%@",string,castObj.name];
//    }
//    
//    return string;
//    
//}
//-(NSString*)addDirectors:(NSMutableArray*)dirctors{
//    
//    NSString*string = @"";
//    for(Person*directorObj  in dirctors){
//        if(string.length>0){
//            string=[NSString stringWithFormat:@"%@,",string];
//        }
//         string= [NSString stringWithFormat:@"%@%@",string,directorObj.name];
//    }
//    
//    return string;
//    
//}
//-(NSString*)addGenre:(NSMutableArray*)genres{
//    
//    NSString*string = @"";
//    for(NSString*genre  in genres){
//        if(string.length>0){
//            string=[NSString stringWithFormat:@"%@ | ",string];
//        }
//        string= [NSString stringWithFormat:@"%@%@",string,genre];
//    }
//    
//    return string;
//    
//}
@end
