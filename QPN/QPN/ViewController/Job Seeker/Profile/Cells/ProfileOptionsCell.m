//
//  ProfileOptionsCell.m
//  Myfilix
//
//  Created by Muhammad Usman on 22/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "ProfileOptionsCell.h"

@implementation ProfileOptionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
//    self.bgView.layer.cornerRadius = 5.0;
//    self.bgView.clipsToBounds = YES;
//    
//    self.bgView.layer.borderWidth = 1.0;
//    self.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)addUserDataBtnPressed:(UIButton *)sender {
    
    if (self.userAddDataDelegate && [self.userAddDataDelegate respondsToSelector:@selector(onAddBtnPressed: cellIndex:)])
    {
        [self.userAddDataDelegate onAddBtnPressed:sender cellIndex:self.index];
    }
}

@end
