//
//  PostCommentCell.h
//  Myfilix
//
//  Created by Muhammad Usman on 14/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPNPostComment.h"

@interface PostCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dp;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextView *postDescp;
@property (weak, nonatomic) IBOutlet UIView *postContainer;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;



@property (nonatomic,strong) QPNPostComment * commentPost;

@property (nonatomic,strong) NSIndexPath * index;


- (void)populateData;

@end
