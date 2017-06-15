//
//  PostCommentCell.m
//  Myfilix
//
//  Created by Muhammad Usman on 14/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "PostCommentCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "QPNSharedData.h"

@implementation PostCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _commentPost = [[QPNPostComment alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) populateData
{
    if (_commentPost)
    {
        if (_commentPost.qpnUser)
        {
            _userName.text = _commentPost.qpnUser.first_name;
            [_dp sd_setImageWithURL:[NSURL URLWithString:_commentPost.qpnUser.avatar_file_name]
                                  placeholderImage:[UIImage imageNamed:@"boy"]
                                         completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
        }
        
        _postDescp.text = _commentPost.text;
        _commentTime.text = _commentPost.time;
        
    
    }
   
}
@end
