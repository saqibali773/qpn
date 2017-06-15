//
//  CheckBoxCell.m
//  QPN
//
//  Created by Muhammad Usman on 14/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "CheckBoxCell.h"

@implementation CheckBoxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.checkBox.selected = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClicked:(UIButton *)sender {
    
    if (self.checkBox.isSelected)
    {
        self.checkBox.selected = NO;
    }
    else
    {
     self.checkBox.selected = YES;
    }
    if (self.checkBoxDelegate  && [self.checkBoxDelegate respondsToSelector:@selector(employedBtnClicked:isEmployed:)])
    {
        [self.checkBoxDelegate employedBtnClicked:sender isEmployed:self.checkBox.selected];
    }
    
}

@end
