//
//  SearchUserCell.m
//  QPN
//
//  Created by Muhammad Usman on 17/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SearchUserCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation SearchUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _userObj = [[QPNUser alloc] init];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) populateData
{
    self.userName.text = _userObj.first_name;
   
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"star"];
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@""];
    
    for(int i=0;i<_userObj.rating.intValue;i++) {
        [myString appendAttributedString:attachmentString];
        [myString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
    }
    _srats.attributedText = myString;
    _jobTitle.text = _userObj.job_title;
    _companyName.text = _userObj.company_name;
    
    if (_userObj.avatar_file_name.length > 0)
    {
        [self.userDp sd_setImageWithURL:[NSURL URLWithString:_userObj.avatar_file_name]
                       placeholderImage:[UIImage imageNamed:@"boy"]
                              completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                              }];
        

    }
}


@end
