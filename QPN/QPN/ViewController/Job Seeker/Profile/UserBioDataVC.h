//
//  UserBioDataVC.h
//  Myfilix
//
//  Created by Muhammad Usman on 22/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserBioDataVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *dp;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *education;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *email;

@end
