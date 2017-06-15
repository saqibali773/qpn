//
//  UserShortStoryCell.m
//  QPN
//
//  Created by Muhammad Usman on 05/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "UserShortStoryCell.h"

@implementation UserShortStoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addVideoBtnPressed:(UIButton *)sender {
    
    if(self.shortStoryCellDelegate&&[self.shortStoryCellDelegate respondsToSelector:@selector(addVideo)]){
        [self.shortStoryCellDelegate addVideo];
    }
}
- (IBAction)playVideo:(UIButton *)sender {
    
    if(self.shortStoryCellDelegate&&[self.shortStoryCellDelegate respondsToSelector:@selector(playVideo)]){
        [self.shortStoryCellDelegate playVideo];
    }
}

@end
