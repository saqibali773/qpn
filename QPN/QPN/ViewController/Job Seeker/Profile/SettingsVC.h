//
//  SettingsVC.h
//  QPN
//
//  Created by Muhammad Usman on 11/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomTF.h"


@interface SettingsVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *navTitle;
@property (weak, nonatomic) IBOutlet UIImageView *dpImage;

@property (weak, nonatomic) IBOutlet MyCustomTF *oldPassword;
@property (weak, nonatomic) IBOutlet MyCustomTF *updatePassword;
@property (weak, nonatomic) IBOutlet MyCustomTF *confirmPass;

@property (weak, nonatomic) IBOutlet UIButton *saveBtnword;
@end
