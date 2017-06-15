//
//  WYDropDownCell.m
//  SaferApp
//
//  Created by Granjur on 17/08/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "WYDropDownCell.h"


@implementation WYDropDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.cellImg.layer.cornerRadius = self.cellImg.frame.size.width*0.5;
    self.cellImg.clipsToBounds = YES;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
