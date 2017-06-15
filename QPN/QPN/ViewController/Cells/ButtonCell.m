//
//  ButtonCell.m
//  Myfilix
//
//  Created by Muhammad Usman on 05/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.ButtonClick.layer.borderWidth = 2.0;
//    
//    self.ButtonClick.layer.borderColor = [UIColor colorWithRed:157.0/255.0 green:69.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    self.ButtonClick.layer.cornerRadius = 8.0;
    self.ButtonClick.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (IBAction)buttonClicked:(UIButton *)sender {
    
    if (self.btnDelegate  && [self.btnDelegate respondsToSelector:@selector(btnClicked:cellIndexD:)])
    {
        [self.btnDelegate btnClicked:sender cellIndexD:self.cellIndex];
    }
}

@end
