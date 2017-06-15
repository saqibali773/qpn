//
//  RateCell.m
//  SaferApp
//
//  Created by Granjur on 03/10/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "RateCell.h"

@implementation RateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)rateClicked:(UIButton *)sender {
    
    UIButton *button = (UIButton *)sender;
    int buttonTag = (int)[button tag];
    [self setRatting:buttonTag];
    
    if (self.rateDelegate  && [self.rateDelegate respondsToSelector:@selector(onRateBtnClicked:starTag:)] )
    {
        [self.rateDelegate onRateBtnClicked:sender starTag: (int)[button tag]];
    }
}
-(void)setRatting:(int)tag{

    for (int i = 1; i < 6; i++)
    {
        UIButton *random = (UIButton *)[self viewWithTag:i];
        
        if (i <= tag)
        {
            random. selected = YES;
        }
        else
        {
            random. selected = NO;
        }
    }
}

@end
