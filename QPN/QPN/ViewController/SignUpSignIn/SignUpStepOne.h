//
//  SignUpStepOne.h
//  QPN
//
//  Created by Muhammad Usman on 12/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpStepOne : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic)bool asPartner; // true: signUp as partner  false: signUp as member

@property (weak, nonatomic) IBOutlet UIView *transparentLayer;
@property (weak, nonatomic) IBOutlet UIView *selectionPopup;
@property (weak, nonatomic) IBOutlet UILabel *selectTitle;
@property (weak, nonatomic) IBOutlet UIButton *optionOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *optionTwoBtn;

@property (strong, nonatomic) NSString * popupType;


@property (weak, nonatomic) IBOutlet UIView *datePickerView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
