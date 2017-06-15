//
//  ButtonCell.h
//  Myfilix
//
//  Created by Muhammad Usman on 05/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonCellDelegate <NSObject>

-(void) btnClicked:(id) sender cellIndexD:(NSIndexPath*) ind;

@end

@interface ButtonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *ButtonClick;
@property (strong, nonatomic) NSIndexPath * cellIndex;
@property(nonatomic,assign) id<ButtonCellDelegate> btnDelegate;

@end
