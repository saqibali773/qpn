//
//  AddPostVC.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "QPNPost.h"

@interface AddPostVC : UIViewController
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *postTitle;

@property (strong, nonatomic) IBOutlet UIImageView *userDp;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *attachImageBtn;

@property (strong, nonatomic) IBOutlet UIPlaceHolderTextView *postText;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *postTextHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *attachedFileView;
@property (weak, nonatomic) IBOutlet UIImageView *attackedImageView;

@property (strong, nonatomic) UIImage *attachedImage;

@property (nonatomic) BOOL isEditing;

@property (nonatomic) int indexPath;

@property (nonatomic,strong) QPNPost * postObj;


@end
