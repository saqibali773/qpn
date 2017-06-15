//
//  UserBriefInfoCell.m
//  QPN
//
//  Created by Muhammad Usman on 25/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "UserBriefInfoCell.h"

@implementation UserBriefInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)dobBtn:(UIButton *)sender {
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(dobBtnPressed)]){
        [self.delegate dobBtnPressed];
    }
}
- (IBAction)genderBtn:(UIButton *)sender {
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(genderBtnPressed)]){
        [self.delegate genderBtnPressed];
    }

}
- (IBAction)carrerObjBtn:(UIButton *)sender {
    if(self.delegate&&[self.delegate respondsToSelector:@selector(carrerObjBtnPressed)]){
        [self.delegate carrerObjBtnPressed];
    }
}

@end
