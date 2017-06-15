//
//  AddEducationVC.h
//  QPN
//
//  Created by Muhammad Usman on 21/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomTF.h"

#import "Education.h"

@interface AddEducationVC : UIViewController

@property (weak, nonatomic) IBOutlet MyCustomTF *institute;
@property (weak, nonatomic) IBOutlet MyCustomTF *degreeTitle;
@property (weak, nonatomic) IBOutlet MyCustomTF *startDate;
@property (weak, nonatomic) IBOutlet MyCustomTF *endDate;

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic) bool isStartDate;
@property (weak, nonatomic) IBOutlet UIView *transparentLayer;

@property (weak, nonatomic) IBOutlet UIView *datePickerView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic) bool isEditMode;

@property (strong, nonatomic) Education* eduObj;



@end
