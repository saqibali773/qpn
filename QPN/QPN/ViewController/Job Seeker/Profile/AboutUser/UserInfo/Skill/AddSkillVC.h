//
//  AddSkillVC.h
//  QPN
//
//  Created by Muhammad Usman on 21/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomTF.h"
#import "Skill.h"

@interface AddSkillVC : UIViewController

@property (weak, nonatomic) IBOutlet MyCustomTF *titleTF;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic) bool isEditingMode;

@property (strong,nonatomic) Skill * skillObj;

@end
