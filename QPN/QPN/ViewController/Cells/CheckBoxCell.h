//
//  CheckBoxCell.h
//  QPN
//
//  Created by Muhammad Usman on 14/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckBoxCellDelegate <NSObject>

-(void) employedBtnClicked:(id) sender isEmployed:(bool)employed;

@end

@interface CheckBoxCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *checkBox;

@property(nonatomic,assign) id<CheckBoxCellDelegate> checkBoxDelegate;

@end
