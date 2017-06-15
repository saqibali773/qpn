//
//  AddAchievementVC.h
//  QPN
//
//  Created by Muhammad Usman on 21/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomTF.h"
#import "Achievement.h"

@interface AddAchievementVC : UIViewController

@property (weak, nonatomic) IBOutlet MyCustomTF *titleTF;
@property (weak, nonatomic) IBOutlet MyCustomTF *descp;
@property (weak, nonatomic) IBOutlet MyCustomTF *startDate;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic) bool isStartDate;
@property (weak, nonatomic) IBOutlet UIView *transparentLayer;

@property (weak, nonatomic) IBOutlet UIView *datePickerView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic) bool isEditingMode;

@property (strong,nonatomic) Achievement * achObj;

@end
