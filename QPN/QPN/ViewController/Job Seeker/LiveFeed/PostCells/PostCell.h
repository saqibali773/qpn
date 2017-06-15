//
//  PostCell.h
//  Myfilix
//
//  Created by Muhammad Usman on 14/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPNPost.h"

@protocol PostCellDelegate <NSObject>

- (void) onLikeBtn:(id) sender cellIndex:(NSIndexPath*) index;
- (void) onCommentBtn:(id) sender cellIndex:(NSIndexPath*) index;
- (void) onMoreBtn:(id) sender cellIndex:(NSIndexPath*) index;
- (void) onSeeMoreBtn:(id) sender cellIndex:(NSIndexPath*) index;

@optional
- (void) onImageClick:(id) sender cellIndex:(NSIndexPath*) index;
- (void) onUserClick:(id) sender cellIndex:(NSIndexPath*) index;

@end

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dp;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *postTime;

@property (weak, nonatomic) IBOutlet UITextView *postDescp;
@property (weak, nonatomic) IBOutlet UIImageView *attachedMedia;
@property (weak, nonatomic) IBOutlet UIView *postContainer;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIView *CommentContainer;
@property (weak, nonatomic) IBOutlet UIImageView *commenterDp;
@property (weak, nonatomic) IBOutlet UILabel *commenterUserName;

@property (weak, nonatomic) IBOutlet UITextView *commentDescp;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeight;



@property(nonatomic,assign) id<PostCellDelegate> postCellDelegate;

@property (nonatomic,strong) QPNPost * post;

@property (nonatomic,strong) NSIndexPath * index;

@property (weak, nonatomic) IBOutlet UIButton *seeMoreBtn;

@property (nonatomic) bool isDetailPost;

- (void)populateData:(bool)moreHidden;

@end
