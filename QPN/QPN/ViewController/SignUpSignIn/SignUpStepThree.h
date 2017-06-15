//
//  SignUpStepThree.h
//  QPN
//
//  Created by Muhammad Usman on 12/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpStepThree : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic)bool asPartner; // true: signUp as partner  false: signUp as member



// varif Code View

@property (weak, nonatomic) IBOutlet UIView *varifCodeLayer;

@property (weak, nonatomic) IBOutlet UITextField *charOne;
@property (weak, nonatomic) IBOutlet UITextField *charTwo;

@property (weak, nonatomic) IBOutlet UITextField *charThree;
@property (weak, nonatomic) IBOutlet UITextField *charFour;
@property (weak, nonatomic) IBOutlet UITextField *charFive;
@property (weak, nonatomic) IBOutlet UITextField *charSix;

@end
