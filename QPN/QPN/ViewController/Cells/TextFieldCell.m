//
//  TextFieldCell.m
//  Myfilix
//
//  Created by Muhammad Usman on 04/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
- (IBAction)btnPressed:(UIButton *)sender
{
    if (self.TFCellDelegate  && [self.TFCellDelegate respondsToSelector:@selector(optionPicker:cellIndexD:)])
    {
        [self.TFCellDelegate optionPicker:sender cellIndexD:self.textField.row];
    }
}

@end
