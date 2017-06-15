//
//  ObjectiveInfoVC.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@interface ObjectiveInfoVC : UIViewController

@property (strong, nonatomic) IBOutlet UIPlaceHolderTextView *postText;
@property (nonatomic) BOOL isEditing;
@property (nonatomic) int indexPath;

@end
