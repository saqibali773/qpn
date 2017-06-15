//
//  ProfileOptionsCell.h
//  Myfilix
//
//  Created by Muhammad Usman on 22/02/2017.
//  Copyright © 2017 SaqibAli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileOptionsCellDelegate <NSObject>
- (void) onAddBtnPressed:(id) sender cellIndex:(NSInteger) index;
@end

@interface ProfileOptionsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (nonatomic) NSInteger index;

@property(nonatomic,assign) id<ProfileOptionsCellDelegate> userAddDataDelegate;

@end
