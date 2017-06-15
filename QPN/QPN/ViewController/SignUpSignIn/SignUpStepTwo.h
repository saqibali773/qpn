//
//  SignUpStepTwo.h
//  QPN
//
//  Created by Muhammad Usman on 12/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpStepTwo : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic)bool asPartner; // true: signUp as partner  false: signUp as member
@property(nonatomic)bool isEmployed;

@property(nonatomic)int countryPicker; //1: country  2: Nationality



@property (weak, nonatomic) IBOutlet UIView *transparentLayer;
@property (weak, nonatomic) IBOutlet UIView *optionPopup;



@end
