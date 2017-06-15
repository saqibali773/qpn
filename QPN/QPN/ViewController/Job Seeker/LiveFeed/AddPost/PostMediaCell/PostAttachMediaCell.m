//
//  PostAttachMediaCell.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "PostAttachMediaCell.h"

@implementation PostAttachMediaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.placeImage.layer.cornerRadius = self.placeImage.frame.size.height*0.03;
    self.placeImage.clipsToBounds = YES;
    
    self.playBtn.hidden = YES;
}

- (IBAction)cancelBtnClicked:(UIButton *)sender {
    
    if (self.postMediaCellDelegate && [self.postMediaCellDelegate respondsToSelector:@selector(removeImage:cellIndex:)])
    {
        [self.postMediaCellDelegate removeImage: sender cellIndex:_index];
    }
}

@end
