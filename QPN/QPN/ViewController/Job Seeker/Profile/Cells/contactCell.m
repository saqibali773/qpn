//
//  contactCell.m
//  QPN
//
//  Created by Muhammad Usman on 08/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "contactCell.h"

@implementation contactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.layer.cornerRadius =6.0;
    self.bgView.clipsToBounds = YES;
    
    self.bgView.layer.borderWidth = 1.0;
    self.bgView.layer.borderColor = [UIColor colorWithRed:132/255.0 green:0/255.0 blue:42.0/255.0 alpha:1.0].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
