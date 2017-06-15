//
//  SignInSignUpVC.h
//  Myfilix
//
//  Created by Muhammad Usman on 03/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInSignUpVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (weak, nonatomic) IBOutlet UIButton *guestBtn;
@property (weak, nonatomic) IBOutlet UIView *signUpOptionView;
@property (weak, nonatomic) IBOutlet UIView *transparentLayer;
@property (weak, nonatomic) IBOutlet UIView *varifCodePopup;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end
