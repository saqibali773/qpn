//
//  TextFieldCell.h
//  Myfilix
//
//  Created by Muhammad Usman on 04/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomTF.h"

@protocol TextFieldCellDelegate <NSObject>

-(void) optionPicker:(id) sender cellIndexD:(int) ind;
@end

@interface TextFieldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MyCustomTF *textField;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property(nonatomic,assign) id<TextFieldCellDelegate> TFCellDelegate;

@end
