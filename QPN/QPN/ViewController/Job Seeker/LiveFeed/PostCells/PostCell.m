//
//  PostCell.m
//  Myfilix
//
//  Created by Muhammad Usman on 14/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import "PostCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "QPNSharedData.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _post = [[QPNPost alloc] init];
    self.seeMoreBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) populateData: (bool)moreHidden
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    if (_post)
    {
        if (_post.qpnUser)
        {
            _userName.text = _post.qpnUser.first_name;
            [_dp sd_setImageWithURL:[NSURL URLWithString:_post.qpnUser.avatar_file_name]
                                  placeholderImage:[UIImage imageNamed:@"boy"]
                                         completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                             
                                             NSLog(@"Width:: %f",image.size.width);
                                             NSLog(@"Width:: %f",image.size.width);
            }];
        }
        
        _postDescp.text = _post.text;
        _postTime.text = _post.ago;
        
        NSString * likeCount;
        if (_post.no_of_likes.integerValue > 0)
        {
            likeCount = [_post.no_of_likes stringValue];
        }
        else
        {
            likeCount = @"";
        }
        //
        NSString * likeImage;
        
        if (_post.is_liked_by_me) {
            likeImage = @"like-by-me";
        }
        else
        {
            likeImage = @"like";
        }
        
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:likeImage];
        
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:likeCount];
        [myString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
        [myString appendAttributedString:attachmentString];
        
        //             [self.likeBtn setTitle:[NSString stringWithFormat:@ "%@",_post.no_of_likes] forState:UIControlStateNormal];
        
        [self.likeBtn setAttributedTitle:myString forState:UIControlStateNormal];
        
        UIImage *btnImage = nil;//[UIImage imageNamed:@""];
        [self.likeBtn setImage:btnImage forState:UIControlStateNormal];
        
        
        if (_post.image.length > 0)
        {
            [_attachedMedia sd_setImageWithURL:[NSURL URLWithString:_post.image]
                              placeholderImage:[UIImage imageNamed:@""]
                                     completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         
                                         if(image){
                                             
                                         }else{
                                         }
                                     }];
            
        }

    }
   
    self.seeMoreBtn.hidden = YES;
    float height = [SHARED_MANAGER postTextViewHeightForAttributedText:_post.text andWidth:screenWidth - 17.0 heightWithoutText:0.0];
    if (height >= 50.0 && !_isDetailPost) {
        self.seeMoreBtn.hidden = NO;
    }
    
    if (_isDetailPost)
    {
        _commentBtn.hidden = YES;
        _moreBtn.hidden = YES;
        _commentHeight.constant = 0.0;
        _CommentContainer.hidden = YES;
    }
    else
    {
        _commentBtn.hidden = NO;
        _moreBtn.hidden = moreHidden;

    }
    
    if(_post.comment.text.length != 0 )
    {
        _commentDescp.text = _post.comment.text;
        if (_post.comment.qpnUser) {
            
            _commenterUserName.text = _post.comment.qpnUser.first_name;
            if (_post.comment.qpnUser.avatar_file_name.length > 0)
            {
                [_commenterDp sd_setImageWithURL:[NSURL URLWithString:_post.comment.qpnUser.avatar_file_name]
                                  placeholderImage:[UIImage imageNamed:@"dummyIs"]
                                         completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType, NSURL *imageURL) {
                                             
                                             if(image){
                                                 
                                             }else{
                                             }
                                         }];
                
            }
            
        }
    }
    else
    {
        _commentHeight.constant = 0.0;
        _CommentContainer.hidden = YES;
    }
    
    
}

- (IBAction)seeMoreTextPressed:(UIButton *)sender {
    
    if (self.postCellDelegate && [self.postCellDelegate respondsToSelector:@selector(onSeeMoreBtn:cellIndex:)])
    {
        [self.postCellDelegate onSeeMoreBtn:sender cellIndex:_index];
    }

}
- (IBAction)likeBtnPressed:(UIButton *)sender {
    
    if (self.postCellDelegate && [self.postCellDelegate respondsToSelector:@selector(onLikeBtn:cellIndex:)])
    {
        [self.postCellDelegate onLikeBtn:sender cellIndex:_index];
    }

}
- (IBAction)commentBtnPressed:(UIButton *)sender {
    if (self.postCellDelegate && [self.postCellDelegate respondsToSelector:@selector(onCommentBtn:cellIndex:)])
    {
        [self.postCellDelegate onCommentBtn:sender cellIndex:_index];
    }
}
- (IBAction)moreBTnPressed:(UIButton *)sender {
    
    if (self.postCellDelegate && [self.postCellDelegate respondsToSelector:@selector(onMoreBtn:cellIndex:)])
    {
        [self.postCellDelegate onMoreBtn:sender cellIndex:_index];
    }
}
- (IBAction)onImageClick:(id)sender {
    
    if (self.postCellDelegate && [self.postCellDelegate respondsToSelector:@selector(onImageClick:cellIndex:)])
    {
        [self.postCellDelegate onImageClick:sender cellIndex:_index];
    }

}

- (IBAction)onUserClick:(id)sender {
    
    
    if (self.postCellDelegate && [self.postCellDelegate respondsToSelector:@selector(onUserClick:cellIndex:)])
    {
        [self.postCellDelegate onUserClick:sender cellIndex:_index];
    }

}






@end
